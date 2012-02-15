
module RubyTL
  module Rtl

    module TraceableConfiguration
      # Sets the metaclass that will be used to instantiate these
      # kinds of objects.
      def proxy_for(metaclass)
        @proxy_for = metaclass
      end            
 
      # Returns the metaclass that is proxied by this traceable.     
      def proxy_for_get
        @proxy_for
      end    
      
      def method_missing(method, *args, &block)
        @proxy_for.send(method, *args, &block)
      end
      
      def all_objects
        @all_objects ||= []
      end
      #- rumi_model_id
      #- rumi_conforms_to?(metaclass)
      #- rumi_property_by_name          
    end
  
    class TraceableMetaclass      
      extend TraceableConfiguration
            
      # Creates a new traceable metaclass
      def initialize(*args)
        @object = self.metaclass.new
        self.class.all_objects << self
      end
      
      # Returns the 'proxied' metaclass
      def metaclass
        self.class.proxy_for_get
      end
      
      #alias_method :old_method_missing, :method_missing
      def method_missing(method, *args, &block)
        @object.send(method, *args, &block)
      end

      def kind_of?(metaclass)
        @object.rumi_kind_of?(metaclass)
      end
      
      def is_a?(metaclass)
        @object.rumi_kind_of?(metaclass)
      end
      
      def ==(object)
        @object == object
      end
#        - rumi_model_id
#  - rumi_conforms_to?(metaclass)
#  - rumi_property_by_name    
    end
  end
end