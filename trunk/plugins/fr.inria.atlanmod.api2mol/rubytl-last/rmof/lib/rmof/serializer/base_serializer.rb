require 'rexml/document'

module RMOF

  # A basic serializer for models or metamodelos according to
  # XMI 2.0
  #
  class BaseSerializer
  
    # The model to be serialized.
    # 
    # == Arguments
    # * <tt>model</tt>. The model to be serialized.
    # * <tt>adapter</tt>. Optional. It is only needed to resolve schemaLocations. 
    #
    def initialize(model, adapter = nil)
      @model = model
      @adapter = adapter
    end
    
    # Serialize the initialized model to a specific IO element, 
    # usually a file.
    #
    # == Arguments
    # * <tt>An output stream where to put the XMI result</tt>
    #
    def serialize(io)
      @result    = REXML::Document.new
      @file_path = File.expand_path(io.path) if io.respond_to?(:path)
      @schema_locations = {}
      @namespaces       = {}

      parent_element = self.root_element
      @model.root_elements.each do |object|
        element = serialize_object(object)
        parent_element.add_element(element)
      end
      @namespaces.each_pair do |prefix, uri|
        @result.root.add_namespace(prefix, uri)
      end
      specialize_root_element(@result.root)

      @result.write(io, 0)  
      # TODO: If @model.root_elements.size > 1 then the method +root_element+
      # should be redefined return a single xml root element, so that the
      # xml document is correct
      
      @result
    end

  protected

    # Serialize a given object, creating a new xml element
    # 
    # == Arguments
    # * <tt>object</tt>. The object to be serialized.
    # * <tt>parent_property</tt>. The property where this object is contained.
    #
    # == Returns
    # A REXML::Element with the XMI representation of the object.
    #
    def serialize_object(object, parent_property = nil)
      element = if parent_property.nil?
        prefix  = object.metaclass.nsPrefix
        name    = object.metaclass.non_qualified_name
        element = REXML::Element.new("#{prefix}:#{name}")
        
        store_namespace(prefix, object)       
        element
      else
        # REXML::Element.new(parent_property.owner.name)
        REXML::Element.new(parent_property.name)
      end

      # Serialize attributes
      object.metaclass.all_structural_features.each do |feature|
        serialize_attribute(object, feature, element) if feature.is_attribute?
        serialize_reference(object, feature, element) if feature.is_reference?
      end

      if self.respond_to? :specialize_serialization
        specialize_serialization(element, object, parent_property)
      end
      
      element
    end

    # Serialize a given attribute into an XML element.
    # Derived attributes are not serialized.
    #
    # == Arguments
    # * <tt>object</tt>. The object from which the attribute value will be get
    # * <tt>attribute</tt>. The attribute (from the metamodel) to be serialized</tt>
    # * <tt>element</tt>. The XML element where the attribute value will be set
    # 
    def serialize_attribute(object, attribute, element)
      return if attribute.derived

      value = object.get_from_property(attribute)

      if value != nil
        if attribute.type.is_enumeration? 
          element.add_attribute(attribute.name, value.name) 
        elsif attribute.type.is_primitive? 
          if attribute.multivalued?
            value.each do |v| 
              subelement = REXML::Element.new(attribute.name)
              subelement.text = v
              element.add_element(subelement) 
            end  
          elsif value != attribute.defaultValue 
            element.add_attribute(attribute.name, attribute.type.to_xmi_str(value)) 
          end
        else
          raise "Attributes should be primitive or enumerations (#{attribute.name} : #{attribute.type.name})"
        end
      end    
    end

    # Serialize a reference to an object
    # * <tt>containment references</tt>. The object is serialized as a inner element of the parent object.
    # * <tt>reference with an opposite reference that is a containment reference</tt>. The reference is
    #   is not serialized since the container is already serialized as a parent object.
    # * <tt>otherwise</tt>. 
    #
    # Derived references are not serialized.
    #
    def serialize_reference(object, reference, element)
      return if reference.derived

      if reference.containment
        [*object.get_from_property(reference)].compact.each do |value|
          child_element = serialize_object(value, reference)
          element.add_element(child_element)
        end        
        # raise "no"
      elsif reference.eOpposite && reference.eOpposite.containment
        # Skip
        # The reference is already serialized since there already exists
        # a parent/child in the XML
      else
        if reference.multivalued?
          intermodel_references = []
          object.get_from_property(reference).each do |value|
            href = id_for_non_containment_reference(value, reference)

            if value.owning_model != @model
              el = element.add_element(reference.name, { 'href' => value.owning_model.uri + href })
              #if self.respond_to? :specialize_serialization
              #  specialize_serialization(el, object, reference)
              #end              
            else
              intermodel_references << href   
            end
          end
          element.attributes[reference.name] = intermodel_references.join(' ') unless intermodel_references.empty?
        else
          value = object.get_from_property(reference)
          if value
            reference_string = id_for_non_containment_reference(value, reference)

            # Duplicate code!!! I don't like this
            # An horrible hacks...
            if value.owning_model != @model
              uri = value.owning_model.uri
              if uri =~ /^file/
                raise "Can't compute relative file paths if no file is given" unless @file_path
                uri = @adapter.compute_relative_file_path(uri, @file_path)
              end
              concrete_type = ''
              # TODO: This is Ecore specific...
              if reference.eType != value.metaclass
                concrete_type = "#{value.metaclass.nsPrefix}:#{value.metaclass.non_qualified_name} " 
                store_namespace(value.metaclass.nsPrefix, value)
              end
              reference_string = concrete_type + uri + reference_string
            end
            element.attributes[reference.name] = reference_string
          end
        end
#        str = [*object.get(reference)].compact.map do |value| 
#           id_for_non_containment_reference(value, reference)
#        end.join(' ')
#        element.attributes[reference.name] = str unless str.strip.empty?
        # TODO: Check if the element is in a differente resource (i.e. models)
        # than this.
      end
    end
    
    # Returns the root XML element for this document. The default
    # is the document itself.
    #
    # This method is intended for subclasses to redefine it so that 
    # they can set their own root element.
    # 
    def root_element
      unless @root        
        if @model.root_elements.size > 1 || @model.root_elements.size == 0
          @root = REXML::Element.new
          @root.name = 'xmi:XMI'
          @result.add_element(@root)
        else
          @root = @result
        end
      end
      @root
    end 
    
    def compute_schema_location(package)
      if @file_path && @adapter
        ns_uri   = package.nsURI
        root_uri = package.root_package.nsURI
        fragment = ns_uri != root_uri ? package.compute_uri_fragment : ''
        if path = @adapter.compute_relative_path(root_uri, @file_path)
          @schema_locations[ns_uri] = path + fragment
        end
      end
    end     
    
    def store_namespace(prefix, object)
      return if @namespaces.key?(prefix)
      @namespaces[prefix] = object.metaclass.nsURI
      compute_schema_location(object.metaclass.ePackage)    
    end
  end

end
