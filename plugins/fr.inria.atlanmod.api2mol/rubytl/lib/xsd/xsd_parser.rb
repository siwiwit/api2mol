

module RubyTL
  module XSD
    
    class XSDParser
      xsd_string = RubyTL::Xsd::SimpleTypeDefinition.new
      xsd_string.name = 'string'

      xsd_decimal = RubyTL::Xsd::SimpleTypeDefinition.new
      xsd_decimal.name = 'decimal'

      xsd_boolean = RubyTL::Xsd::SimpleTypeDefinition.new
      xsd_boolean.name = 'boolean'
      
      xsd_positiveInteger = RubyTL::Xsd::SimpleTypeDefinition.new
      xsd_positiveInteger.name = 'positiveInteger'

      xsd_ID = RubyTL::Xsd::SimpleTypeDefinition.new
      xsd_ID.name = 'ID'

      xsd_IDREF = RubyTL::Xsd::SimpleTypeDefinition.new
      xsd_IDREF.name = 'IDREF'
                  
    
      DATATYPE_MAPPING = {
        'string' => xsd_string,
        'decimal' => xsd_decimal,
        'boolean' => xsd_boolean,
        'positiveInteger' => xsd_positiveInteger,
        'ID' => xsd_ID,
        'IDREF' => xsd_IDREF
      }
      
      def initialize(parser_wrapper)
        @parser_wrapper = parser_wrapper
        @parser_wrapper.listener = self
        @xs_prefix = 'xs'
      end
      
      def parse        
        @schema_definition = RubyTL::Xsd::SchemaDefinition.new
        @elements          = [@schema_definition]
        @types             = {}
        @tasks             = []
        
        @parser_wrapper.start

        @tasks.each { |t| t.call }

        @schema_definition
      end
      
      def start_tag(node)
        return nil                      if node.match('schema',      @xs_prefix)
        return parse_element(node)      if node.match('element',     @xs_prefix)

        return parse_complex_type(node) if node.match('complexType', @xs_prefix)
        return parse_simple_type(node)  if node.match('simpleType',  @xs_prefix)        
        return parse_restriction(node)  if node.match('restriction', @xs_prefix)        
        return parse_pattern(node)      if node.match('pattern',     @xs_prefix)
        return parse_attribute(node)    if node.match('attribute',   @xs_prefix)
        
        return parse_annotation(node)   if node.match('annotation',  @xs_prefix)
        return parse_documentation(node)if node.match('documentation',  @xs_prefix)

        return parse_model_group(node, 'sequence')  if node.match('sequence', @xs_prefix) # TODO: Ensure sequence
        return parse_model_group(node, 'choice')    if node.match('choice',  @xs_prefix) # TODO: Ensure sequence
        
        return parse_simple_content(node) if node.match('simpleContent', @xs_prefix)
        return parse_extension(node) if node.match('extension', @xs_prefix)
        
        raise "Unrecognized node #{node.prefix}:#{node.name}"
      end
      
      def end_tag(node)     
        @elements.pop
      end
  

    private
      def parse_simple_content(node)
        complex_type = @elements.last
        complex_type.extensionKind = RubyTL::Xsd::XSDExtensionKind.getEEnumLiteral('Simple')
        # I'm assuming next tag is extension...
        @elements.push(complex_type)
      end

      def parse_extension(node)
        extension = RubyTL::Xsd::Extension.new
 
        base = node.attribute_value('base')
        set_type(extension, base, :baseTypeDefinition)        
        
        element = @elements.last
        raise "Invalid #{element}" unless element.kind_of?(RubyTL::Xsd::ComplexTypeDefinition)
  
        element.extension = extension
        @elements.push(element)
      end
    
      def parse_element(node)

        element = RubyTL::Xsd::ElementDefinition.new
        element.name = node.attribute_value('name')
        
        set_type(element, node.attribute_value('type')) if node.has_attribute?('type')
   
        element.minOccurs = node.attribute_value('minOccurs').to_i if node.has_attribute?('minOccurs')          
        element.maxOccurs = parse_max_occurs(node.attribute_value('maxOccurs')) if node.has_attribute?('maxOccurs')          
        @elements.last.elements << element
        @elements.push(element) 
      end      
      
      def parse_annotation(node)
        annotation = RubyTL::Xsd::Annotation.new
        @elements.last.annotation = annotation
        @elements.push(annotation)
      end
      
      def parse_documentation(node)
        @elements.push(nil) # It seems that no documentation exists...
      end
      
      def set_type(element, type_as_string, type_attribute = :typeDefinition)
        prefix, type = type_as_string.split(':') # It assumes that the prefix:type is compulsory. Not sure about that
        if type.nil?
          type, prefix = prefix, nil 
        end
        
        if prefix == @xs_prefix                 
          raise "No type mapping for #{type}" unless DATATYPE_MAPPING.key?(type)

          element.send("#{type_attribute}=", DATATYPE_MAPPING[type])
        else
          @tasks << lambda { 
            # TODO: Handle namespaces properly
            type_definition = @types[type]
            raise "No type for #{type_as_string}" unless type_definition
            element.send("#{type_attribute}=", type_definition)    
          }          
        end
      end
      
      def parse_complex_type(node)

        type_definition = RubyTL::Xsd::ComplexTypeDefinition.new
        if node.has_attribute?('name')
          type_definition.name = node.attribute_value('name')
          @elements.last.typeDefinitions << type_definition # @elements.last needs to be SchemaDefinition
          @types[type_definition.name] = type_definition
        else          
          @elements.last.anonymousTypeDefinition = type_definition        
        end                
        
        @elements.push(type_definition)         
      end
      
      def parse_simple_type(node)
        type_definition = RubyTL::Xsd::SimpleTypeDefinition.new
        type_definition.name = node.attribute_value('name')
        
        @types[type_definition.name] = type_definition
        @elements.last.typeDefinitions << type_definition # @elements.last needs to be SchemaDefinition
        @elements.push(type_definition)
      end
      
      def parse_restriction(node)
        simple = @elements.last
        base = node.attribute_value('base')
        set_type(simple, base, :baseTypeDefinition)        
      
        @elements.push(simple) # weird, but it is ok (because of patter)
      end
                
      def parse_pattern(node)
        simple = @elements.last
        simple.facets << facet = Xsd::PatternFacet.new
        facet.value = node.attribute_value('value')
        
        @elements.push(facet)
      end                
                
      def parse_model_group(node, literal)                   
        model_group = RubyTL::Xsd::ModelGroup.new
        model_group.compositor = RubyTL::Xsd::XSDCompositor.getEEnumLiteral(literal)
        # Get upperBounds/lowerBounds (if necessary)
        @elements.last.content = model_group
        # The type of @elements.last.content is : XSDParticle
        @elements.push(model_group) 
      end
                
      def parse_attribute(node)
        attribute = RubyTL::Xsd::AttributeDeclaration.new
        attribute.required = true if node.has_attribute?('use') && node.attribute_value('use') == 'required'
        attribute.name = node.attribute_value('name')
        
        set_type(attribute, node.attribute_value('type'))
        
        @elements.last.attributes << attribute        
        @elements.push(attribute)
      end
      
      def parse_max_occurs(string)
        return -1 if string.downcase == 'unbounded'
        return string.to_i
      end
    end
  
  end
end