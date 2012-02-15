
module RMOF
  module CommonMixin

    # Returns the absolute path of the file being read by the parser. 
    # If the parser is not reading a file, then nil is returned.
    attr_reader :file_path

  protected
    # It must be called by the constructor of the
    # classes using this module.
    # 
    # == Parameters
    # * io_or_string
    # * model_adapter : a model adapter
    # * options : a hash of options
    #
    def init_parser(io_or_string, model_adapter, options)
      @adapter  = model_adapter
      @logger   = Logger.new(STDOUT)
      @pending_tasks = []

      @file_path = File.expand_path(io_or_string.path) if io_or_string.kind_of?(File)
      @file_path ||= options[:file_path]
    end

    # It must be called before starting the parsing
    # of a file. It is in charge of creating the RMOF
    # model.
    def parse_init(&block)
      @model = RMOF::Model.new('file://' + (@file_path || 'undefined'))
      @adapter.add_loaded(@file_path, @model) if @file_path
      @uri_cache = {}
      yield(@model)      

      resolve_pending_tasks

      # Some tasks only needed for metamodels.
      package = @model.root_elements.first
      if package.respond_to? :nsURI 
        package.compact_elements     
        if @model.root_elements.size == 1
          @adapter.add_mapping(package.nsURI, @file_path)   
        else
          @model.root_elements.each do |p|
            @adapter.add_mapping(p.nsURI, @file_path, p.name)
            @model.xmi_id_set(p, p.name)
          end
        end
      end

      @model 
    end
   
    def resolve_pending_tasks
      @pending_tasks.each { |task| task.call }
    end

    def instantiate_metaclass(metaclass_name, uri)    
      model = @uri_cache[uri]
      unless model
         model = @adapter.resolve_uri(uri)
         @model.add_to_referenced_models(model) if model != @model
         @uri_cache[uri] = model
      end

      if model.respond_to? :instantiate_metaclass
        model.instantiate_metaclass(metaclass_name)
      else
        metaclass = model.lookup_object('//' + metaclass_name)
        metaclass.new_instance
      end
    end

    # Set the value of a certain property (either a Reference or an Attribute)
    # belonging to an object.
    #
    # == Arguments
    #
    # * <tt>property</tt>. The property.
    # * <tt>object</tt>. The object whose property will be set.
    # * <tt>value</tt>. The value of the property.
    #
    def set_value(property, object, value)
      if property.multivalued?
        object.get_from_property(property) << value
      else
        object.quick_set(property, value)
      end
    end

    # Parse a given string value according to the type of the property. 
    # In addition, the parsed value is assigned to the property,
    # resolving references if needed.
    #
    def set_property_value_according_to_type(property, object, string_value)
      metaclass = property.eType # originally type, change for rtype, or something like this
      raise "No type for property #{property.name}" unless metaclass

      if metaclass.is_enumeration?
         value = parse_enumeration(metaclass, string_value)
         set_value(property, object, value)
      elsif metaclass.is_metaclass?
         parse_metaclass(property, object, string_value)
      else # must be primitive
      #elsif metaclass.is_primitive?
         value = parse_primitive_value(metaclass, string_value)
         set_value(property, object, value)
      #else 
      #   raise "Error"
      end
   end
   
    # Given a metaclass this method return one of these constants: PRIMITIVE,
    # ENUMERATION or METACLASS, 
    #
    def switch_type(metaclass)
      return ENUMERATION if @adapter.is_enum?(metaclass)
      return METACLASS   if @adapter.is_metaclass?(metaclass)
      return PRIMITIVE
      #return PRIMITIVE   if @adapter.is_primitive?(metaclass)
      #raise "Unknown meta-metamodel type '#{metaclass}'"
    end
 

  end

  module ECoreCommonMixin

    SPLIT_TYPE = /([a-zA-Z0-9._-]+):(\w+)/
    def get_concrete_type_for_reference(reference, xsi_type_str = nil)
      if xsi_type_str
        # TODO: Is always like this? What about cross-file references?
        xsi_type_str =~ SPLIT_TYPE
        yield($2, $1, nil)
      else
        yield(reference.eType.non_qualified_name,
              reference.eType.ePackage.nsPrefix,
              reference.eType.ePackage.nsURI)
      end
    end

    # In eCore primitive values appears always alone, that is, there isnt'
    # any convention to comma-separate integers, for instance.
    #
    def parse_primitive_value(type, string_value)
      #[type.from_xmi_str(string_value)]
      type.from_xmi_str(string_value)
    end
    
    # Returns the ELiteral corresponding to the passed +string_value+. The ELiteral
    # is get from the +type+ (which should be an EEnum).
    #
    def parse_enumeration(type, string_value)
      # @logger << "Literal #{string_value} not found" + $/ unless type.eLiterals.any? { |l| l.name == string_value || l.literal == string_value }
      type.eLiterals.find { |l| l.name == string_value || l.literal == string_value }
      # TODO: Some kind of literal cache may help
    end

    # Parse a metaclass reference and return a Proc object which is able to resolve
    # the reference link providing that the referenced object already exist.
    #
    # In eCore there are two ways for a reference to be serialized:
    # 1. Positional references.
    # 2.
    #
    def parse_metaclass(property, object, string_value)
      if property.multivalued?
        string_value.split(' ').each do |ref_string|
          create_reference_resolver(property, object, ref_string)
        end
      else
        create_reference_resolver(property, object, string_value)
      end
    end

    def create_reference_resolver(property, object, ref_string)
      # To avoid duplicates
      return if skip_to_avoid_duplicates(property)
      @pending_tasks << Proc.new do
        if not result = @reference_cache[ref_string]
          result, model = lookup_reference_string(property, ref_string, @model)
          @reference_cache[ref_string] = result

          raise "Reference path #{ref_string} not resolved" unless result
          if model != @model
            @model.add_object(result) 
            @model.add_to_referenced_models(model)
          end
        end
        
        set_value(property, object, result)        
        result        
      end
    end

    def skip_to_avoid_duplicates(property)
      property.eOpposite       && 
      ! property.containment   &&
      ! property.multivalued?  &&
      property.eOpposite.multivalued?
    end
    
    # MATCH_REFERENCE = /^(\w+:\w+\s)?(([^\t\r\n\f#]+)?#)?(\/?\/.+)$/
    MATCH_REFERENCE = /^(\w+:\w+\s)?(([^\t\r\n\f#]+)?#)?(\/?\/.*)$/
    #                   type         uri              path

    def lookup_reference_string(property, ref_string, model)
      matched = (ref_string =~ MATCH_REFERENCE)        
      if matched
        concrete_type, model_uri, path = $1, $3, $4
        model = resolve_model(model, model_uri)
        # puts "Trying to resolve [#{path}] with #{model_uri}, and [#{ref_string}]"
        return model.lookup_object(path), model
      else
        # Try the with an attribute being the ID 
        raise "Invalid reference #{ref_string}" unless attribute = property.eType.eIDAttribute
        # TODO: This is not going to work for referenced models (test)
        # TODO: Handle complicated cases such as @objects.1 2 3 4
        ref_string = ref_string.sub(/^#/, '')
        id = attribute.eType.from_xmi_str(ref_string)        
        return model.lookup_object_by_id(property.eType, attribute, id), model
      end   
    end

    def resolve_model(model, model_uri)
      # TODO: Change @nsURI != model_uri to check if the same document is being referred
      if model_uri && (not model_uri.empty?) && @nsURI != model_uri
        model = @adapter.resolve_uri(model_uri, @file_path)
      end 
      model    
    end

    # Return the object gathered as a result of a cross reference
    # to another model.
    #
    # == Arguments
    # * <tt>href</tt>. The reference as a string with the eCore format.
    #   
    def resolve_href(reference, object, href)
      create_reference_resolver(reference, object, href)
    end
 

    def parse_schema_location(locations)
      path      = self.file_path
      #locations = @reader.attribute_with_prefix_of(node, 'xsi', 'schemaLocation')
      if locations && path
        location_pairs = locations.split(' ')
        location_pairs.each_pair do |uri, file|
          file, uri_part = parse_file_location(file)
          absolute_filename = if file =~ /^file:/
            file.sub(/^file:/, '')
          else
            File.join(File.dirname(path), file)
          end

          @adapter.add_mapping(uri, absolute_filename, uri_part) unless @adapter.mappings.key?(uri)
        end
      end
    end
 
    # A filename in a schemaLocation may have a final part (#id or #fragment)
    # to look up a certain part of the model.
    def parse_file_location(filename)
      filename.split('#')
    end
 
  end
end

