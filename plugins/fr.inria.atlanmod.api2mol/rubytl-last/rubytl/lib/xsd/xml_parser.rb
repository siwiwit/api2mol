

module RubyTL
  module XSD
  
    class XMLTree
      attr_accessor :root
      
      def initialize(root)
        @root   = root
        @id_map = {}
      end
      
      def objects
        compute_objects(@root)
      end
      
      def add_by_id(id, node)
        @id_map[id] = node
      end
      
      def node_by_id(id)
        @id_map[id]
      end
      
    private
      def compute_objects(node)
        [node] + node.children.map { |n| compute_objects(n) }.flatten
      end
    end
  
    class XMLTreeNode
      attr_reader :metaclass
      attr_reader :children
      attr_reader :value
      
      # Creates a new XML node whose structure is determined by
      # an XSD type.
      #
      # == Arguments
      # * <tt>parent</tt>. The parent XML object, or nil if no parent object exists
      # * <tt>definition</tt>. An Xsd::ElementDefinition where the type is extracted or
      #                        an Xsd::TypeDefinition (or subtype)
      # * <tt>value</tt>. An optional primitive value (for simple types)
      #
      def initialize(parent, definition, value = nil)
        @parent = parent
        if definition.kind_of?(Xsd::ElementDefinition)
	        @parent.add_children(self, definition.name) if @parent
	        raise "I need the typeDefinition | TODO: handle anonymous types" unless definition.typeDefinition
          @metaclass = definition.typeDefinition
        else
          @metaclass = definition
        end
        @children = []
        @value = value
      end
      
      def add_children(child, element_name)
        return if @children.include?(child)
        set(element_name, child)
        @children << child
      end
      
      METHOD_NAME = /^(\w+)=$/
      def method_missing(method_name, *args)
        return get(method_name.to_s) if args.size == 0
        return set($1.to_s, args.first) if args.size == 1 && method_name.to_s =~ METHOD_NAME
        raise NoMethodError.new("Invalid method #{method_name}(#{args.size} params)")
      end    
    
      def get(name)
        element_definition = @metaclass.property_by_name(name)  
        raise NoElementExists.new("No element #{name} exists in #{@metaclass.name}") unless element_definition     
        initialize_variable(element_definition)
        result = instance_variable_get("@_#{element_definition.name.to_ruby_method_name}")
        
        return result.value if element_definition.is_attribute? && ! element_definition.kind_of?(Xsd::AttributeDeclaration)
        return result          
      end
      
      def set(name, value)
        definition = @metaclass.property_by_name(name)            
        raise NoElementExists.new("No element #{name} exists in #{@metaclass.name}") unless definition
        initialize_variable(definition)
        if   definition.is_attribute? && 
           ! definition.kind_of?(Xsd::AttributeDeclaration) && 
           ! value.kind_of?(XMLTreeNode)
          value = XMLTreeNode.new(self, definition, value)
        end

        # TODO: Check type
        if definition.multivalued?
          instance_variable_get("@_#{definition.name.to_ruby_method_name}") << value
        else
          instance_variable_set("@_#{definition.name.to_ruby_method_name}", value)
        end        
      end
      
      # Check whether the XSD type of this XML node is an instance of
      # the XSD type passed as a parameter.
      # 
      # == Arguments
      # * <tt>xsd_type</tt>. An XSD type (probably ComplexTypeDefinition or SimpleTypeDefinition)
      #
      def is_instance_of?(xsd_type)
        # TODO: Handle inheritance
        @metaclass == xsd_type
      end
      
      private
      
      def initialize_variable(definition)
        if definition.multivalued? && ! instance_variable_get("@_#{definition.name.to_ruby_method_name}")
          instance_variable_set("@_#{definition.name.to_ruby_method_name}", [])
        end  
      end
      
    end
    
    
		# An XML parser based on an underlying XML Schema.
		# 
		# It uses a ParserWrapper-duck-typed compatible object 
		# to access to the XML file as a SAX parser. 
		#
    class XMLParser
    	
      # Creates a new XML parser.
      #
      # == Arguments
      # * <tt>parser_wrapper</tt>. The wrapper to access the XML file.
      # * <tt>schema</tt>. The underlying schema
      #
      def initialize(parser_wrapper, schema)
        @parser_wrapper = parser_wrapper
        @parser_wrapper.listener = self
        @schema = schema
      end
      
      # It starts parsing the file. 
      # It returns a XMLTree object which can be used to access
      # the parsed contents.
      def parse
        @stack = []
        @stack_nodes = []
                      
        @tree = XMLTree.new(nil)
        @parser_wrapper.start
        @tree        
      end
      
      def start_tag(node)
        if @stack.empty?
          parse_top_elements(node)
          raise "Invalid state" if @stack_nodes.size != 1
          @tree.root = @stack_nodes.first           
        else 
          parse_element(node)
        end
      end
      
      def end_tag(node)     
        @stack.pop
        @stack_nodes.pop
      end

    private
      def parse_top_elements(node)
        look_up_definition(@schema, node)        
      end
      
      def parse_element(node)        
        definition = look_up_definition(@stack.last, node)
      end
      
      def look_up_definition(xsd_element, node)
        definition = xsd_element.find_definition(node.name)
        raise "No element #{node.name} allowed" unless definition        
        
        needs_value = definition.is_attribute? || definition.is_simple_content? 
        value = needs_value ? node.text : nil
        xml_node = XMLTreeNode.new(@stack_nodes.last, definition, value)
        
        node.each_attribute do |name, value, prefix|
          next if prefix == 'xmlns'
          next if name   == 'noNamespaceSchemaLocation'
          xml_node.set(name, value)
          
          if xml_node.metaclass.property_by_name(name).is_id?
            @tree.add_by_id(value, xml_node)
          end
        end
        
        @stack.push(definition)
        @stack_nodes.push(xml_node)
      end
    end
  
  end
end