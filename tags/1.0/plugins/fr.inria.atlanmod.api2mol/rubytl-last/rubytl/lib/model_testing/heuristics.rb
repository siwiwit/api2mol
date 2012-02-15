
module RubyTL
  module ModelTesting

    class ComparisionError
      def initialize(text)
        @text = text
      end
      
      def to_s
        @text
      end
    end

    module ClassTraversing
      def traverse(target, expected)
        # TODO: Traverse subpackages        
        target.proxy.proxy_classes.each do |pct|
          pce = expected.proxy.const_get(pct.name)
          yield(pct, pce)
        end      
      end
    end
      
    module NumberOfObjects
      include ClassTraversing
      
      ERROR = "Different number of objects for class {1}. {2} expected but was {3}"
      
      def same_number_of_objects(target, expected)
        traverse(target, expected) do |pct, pce|
          pcts = pct.all_objects.size
          pces = pce.all_objects.size
          add_error(ERROR, pct.name, pcts, pces) if pcts != pces 
        end
      end
    end
  
    module KeyComparision
      include ClassTraversing
      
      def same_key_same_properties(target, expected)
        
      end
    end
  
    module Heuristics
      include NumberOfObjects
      include KeyComparision
    
      def compare(target, expected)
        target.each do |model|
          e = expected.find { |m| m.model_information.namespace == model.model_information.namespace }
          compare_m2m(model, e)
        end
      end

      def errors
        @errors ||= []      
      end
          
    private
      def compare_m2m(target, expected)
        same_number_of_objects(target, expected)
        same_key_same_properties(target, expected)
      end
      
      def add_error(text, *args)
        self.errors << ComparisionError.new(text.substitute(*args))
      end
    end
  
  end  
end