
module RubyTL
  module CST
    module InOutName
      def in_name; 'in_' + self.kind.to_s; end
      def out_name; 'out_' + self.kind.to_s; end      
    end
  
    class Tree

      def accept(visitor)
        visitor.call_in_out(:start, :finish, self) do
          self.root.each { |node| node.accept(visitor) } 
        end
      end
    
    end
    
    class TNode
      include InOutName

      def accept(visitor)
        visitor.call_in_out(in_name, out_name, self) { }
      end    
    end
    
    class RNode
      include InOutName
      
      def accept(visitor)
        visitor.call_in_out(in_name, out_name, self) do
          self.children.each { |node| node.accept(visitor) } 
        end
      end    
    end
    
  end
end