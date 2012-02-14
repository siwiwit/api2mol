
module RMOF

  # This class is in charge of parsing eCore compliant XMI files.
  #
  #
  class ECoreParser < BaseParser

    # Since in eCore models the root node is always a model element 
    # this method simply return such a node.
    def top_level_nodes(root)
      nodes = super
      @reference_cache ||= {}
      @nsURI = @reader.attribute_of(root, 'nsURI')
      @model.uri = @nsURI if @nsURI
      parse_schema_location(root)
      nodes
    end

    # Given an XML element and an EReference it resolves the concrete
    # type of the of the reference. This method basicallly deals with
    # inheritance in references.
    #
    # A typical example of this is EPackage#eClassifiers. The EReference
    # has type EClassifier but the concrete type can be either EClass
    # or EDataType depending on the value of xsi:type.
    #
    # == Arguments
    # * <tt>The XML element that represents the reference (actually, a containment reference)</tt>
    # * <tt>The EReference object itself corresponding to XML element</tt>
    #
    # == Return
    # A string with the name of the type.
    #
    SPLIT_TYPE = /([a-zA-Z0-9._-]+):(\w+)/
    def resolve_reference_type(reference_element, reference)
      if type = @reader.attribute_with_prefix_of(reference_element, 'xsi', 'type')
        # TODO: Is always like this? What about cross-file references?        
        type =~ SPLIT_TYPE
        yield($2, $1, nil)
      else
        #puts reference.eType        
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
      @logger << "Literal #{string_value} not found" + $/ unless type.eLiterals.any? { |l| l.name == string_value || l.literal == string_value }
      type.eLiterals.lookup_first { |l| l.name == string_value || l.literal == string_value }
      #type.from_xmi_str(string_value)
    end

    # Parse a metaclass reference and return a Proc object which is able to resolve
    # the reference link providing that the referenced object already exist.
    # 
    # In eCore there are two ways for a reference to be serialized:
    # 1. Positional references.
    # 2. 
    #
    def parse_metaclass(property, object, string_value)
      if not property.multivalued?
        [create_reference_resolver(property, object, string_value)]
      else
        string_value.split(' ').each do |ref_string|
          create_reference_resolver(property, object, ref_string)
        end            
      end
    end
    
    def skip_attribute(attribute)
      @reader.attribute_has_prefix?(attribute, 'xsi') ||
      	@reader.attribute_has_prefix?(attribute, 'xmlns') 
      # In REX:
      # attribute.prefix == 'xsi' || attribute.prefix == 'xmlns'
    end
    
  protected    

    def create_reference_resolver(property, object, ref_string)
      # To avoid duplicates
      return if skip_to_avoid_duplicates(property)
      @pending_tasks << Proc.new do
        if not result = @reference_cache[ref_string]          
          result, model = lookup_reference_string(property, ref_string, @model)
          @reference_cache[ref_string] = result
        end
        
        raise "Reference path #{ref_string} not resolved" unless result
        if model != @model
          @model.add_object(result) 
          @model.add_to_referenced_models(model)
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
  
    # Try to guess the schema location specified in a node (usually the root node)
    # by reading the xsi:schemaLocation attribute of the element.
    #  
    # 
    def parse_schema_location(node)
      path      = self.file_path
      locations = @reader.attribute_with_prefix_of(node, 'xsi', 'schemaLocation')
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
