
module RMOF

  # This class is in charge of parsing eCore compliant XMI files.
  #
  #
  class ECoreParser < BaseParser
    include ECoreCommonMixin

    # Since in eCore models the root node is always a model element 
    # this method simply return such a node.
    def top_level_nodes(root)
      nodes = super
      @reference_cache ||= {}
      @nsURI = @reader.attribute_of(root, 'nsURI')
      @model.uri = @nsURI if @nsURI

      parse_schema_location( @reader.attribute_with_prefix_of(root, 'xsi', 'schemaLocation') )

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
    def resolve_reference_type(reference_element, reference, &block)
      xsi_type = @reader.attribute_with_prefix_of(reference_element, 'xsi', 'type')
      get_concrete_type_for_reference(reference, xsi_type, &block)
    end

  
    def skip_attribute(attribute)
      @reader.attribute_has_prefix?(attribute, 'xsi') ||
      	@reader.attribute_has_prefix?(attribute, 'xmlns') 
      # In REX:
      # attribute.prefix == 'xsi' || attribute.prefix == 'xmlns'
    end
    
  protected    

 
 end
end
