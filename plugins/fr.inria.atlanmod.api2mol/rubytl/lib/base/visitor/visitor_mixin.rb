module RubyTL
  module Base
    module VisitorMixin
      attr_reader :current_node
    
      def call_if_exist(method_name)
        self.send(method_name) if self.respond_to?(method_name)
      end
        
      def call_in_out(in_method_name, out_method_name, node)          
        change_current_node(node) do
          self.call_if_exist(in_method_name)
          yield    
          self.call_if_exist(out_method_name)
        end            
      end        
      
      def change_current_node(node)
        old_node, @current_node = @current_node, node
        yield
        @current_node = old_node          
      end      
      
      def associate(node, object)
        node_associations[node] = object
      end

      def store(object)
        associate(self.current_node, object)
      end

      def retrieve(node)
        node_associations[node]
      end
      
      
      # Abbreviation for: current_node.attributes,
      # but it returns an AttributesProxy object
      def attrs
        AttributesProxy.new(self.current_node.attributes)
      end
      
      # Abbreviation for: current_node.parent
      def parent
        self.current_node.parent
      end
      
    private
      def node_associations
        @node_associations ||= {}
      end             
    end
      
    class AttributesProxy
      def initialize(attributes)
        @attributes = attributes
      end
      
      def method_missing(method, *args)
        @attributes[method.to_s]
      end
      
      def [](name)
        @attributes[name]
      end
    end  
  end    
end                