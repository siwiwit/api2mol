
module RubyTL
  module XML
    class ParserWrapper
      attr_accessor :listener
      
      def initialize(io_or_string)
        @io_or_string = io_or_string
      end
      
      def start
        @document = REXML::Document.new(@io_or_string)
        parse_node(@document.root, nil) #.elements.each do |element|
#          parse_node(element, nil)
#        end
      end
    
      def parse_node(element, parent)
        node = new_node(element, parent)
        @listener.start_tag(node)
        element.elements.each do |e|
          parse_node(e, node)
        end
        @listener.end_tag(node)      
      end
    
    private
      def new_node(element, parent)
        RexmlNode.new(element, parent)
      end
    end
  end

end

module RubyTL
  module XML
    
    # Wrapper for REXML nodes
    class RexmlNode
      attr_reader :parent
    
      def initialize(node, parent)
        @node = node
        @parent = parent
      end
      
      def prefix
        @node.prefix
      end
      
      def name
        @node.name
      end
      
      def match(name, prefix)
        @node.prefix == prefix && @node.name == name 
      end      
      
      def has_attribute?(name)
        @node.attributes[name] != nil
      end
      
      def attribute_value(name)
        @node.attributes[name]
      end 
      
      def each_attribute
        @node.attributes.each_attribute do |attribute|
          #next if namespace_exclude.include?(attribute.prefix)
          yield(attribute.name, attribute.value, attribute.prefix)
        end
      end
      
      def text
        @node.text
      end
    end
  end  
end