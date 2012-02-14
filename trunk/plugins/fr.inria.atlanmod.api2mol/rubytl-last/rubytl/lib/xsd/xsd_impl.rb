
module RubyTL
  module Xsd
    XSD_SIMPLE_EXTENSION_KIND = RubyTL::Xsd::XSDExtensionKind.getEEnumLiteral('Simple')
    
    module SchemaDefinitionImpl
      def find_definition(name)
        self.elements.find { |e| e.name == name }        
      end
    end
    
    module ElementDefinitionImpl
      def find_definition(name)
        type = self.typeDefinition || self.anonymousTypeDefinition
        raise "Node #{name} is not a valid node for #{self.typeDefinition.name}" if self.typeDefinition.kind_of?(SimpleTypeDefinition)
        type.find_definition(name)
        
#        case type.content.compositor.name
#        when 'sequence'
#          type.content.contents.find { |e| e.name == name }
#        else raise "Not supported #{type.content}"
#        end                
      end    
      
      def multivalued?
        (self.minOccurs && self.minOccurs > 1) ||
        (self.maxOccurs && self.maxOccurs == -1) 
      end
	 
      def is_attribute?
        self.typeDefinition && self.typeDefinition.kind_of?(SimpleTypeDefinition) 
      end
      
      def is_reference?
        ! is_attribute?
      end
      
      def is_simple_content?
        self.typeDefinition.extensionKind == XSD_SIMPLE_EXTENSION_KIND
      end
      
      def is_id?
        false
      end
    end

    module AttributeDeclarationImpl
      def multivalued?
        false # Is this ok????
      end

      def is_attribute?
        true
      end

      def is_simple_content?
        false
      end
      
      def is_reference?
        false
      end
      
      def is_id?
        self.typeDefinition.name == 'ID' # THIS IS A HACK: CREATE SIMPLE TYPE CLASSES EXPLICITLY
      end                  
    end
    
    module TypeDefinitionImpl
      def property_exist?(name)
        property_by_name(name) != nil
      end
      
      def property_by_name(name)
        self.all_properties.find { |p| p.name == name }
      end
    end
    
    module ComplexTypeDefinitionImpl
      def find_definition(name, strict = false)
        result = self.content.find_definition(name)
        raise NoElementExists.new("No element #{name} for type #{self.name}") if result.nil? && strict
        result
      end

      # Returns the list of supertypes. Since XML Schema only
      # allows single inheritance, the list will contain one or
      # zero elements. 
      def all_super_types
        # TODO: Collect supertypes
        []
      end
      
      def all_properties
        elements = self.content ? self.content.elements : []
        elements + self.attributes #TODO: inheritance
      end
    end
    
    module SimpleTypeDefinitionImpl
      # Returns the list of supertypes. Since XML Schema only
      # allows single inheritance, the list will contain one or
      # zero elements. 
      def all_super_types
        # TODO: Collect supertypes
        []
      end
      
      def all_properties
        [] # TODO: Return attributes + inheritance
      end
    end

    module ModelGroupImpl
      def find_definition(name)
        self.elements.find { |element| element.name == name }
      end
    end  
  end

  class NoElementExists < RubyTL::BaseError; end
end