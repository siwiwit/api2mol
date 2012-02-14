
module RubyTL
  module Rtl
    class TraceQueryError < RubyTL::BaseError; end
  
    class TraceQuery
    
      def initialize(input_value, transformation)
        @input_value = input_value
        @transformation = transformation
      end
        
      def select_from(type)
        result = []
        @input_value.each do |element|
          targets = collect_transformed_by_source(element)
          targets.select { |t| t.kind_of?(type) }.each do |t|
            if x = yield(element, t)
              result << t
            end
          end
        end
        result
      end
      
      def all(type)
        targets = collect_transformed_by_source(@input_value)
        filter_by_type(targets, type) 
      end

      def all!(type)
        results = all(type)
        raise TraceQueryError.new("No results") if results.size == 0
        results
      end
            
      def one(type, &block)
        results = collect_for_one(type, &block)
        results.first
      end

      def one!(type, &block)
        results = collect_for_one(type, &block)
        raise TraceQueryError.new("No results")       if results.size == 0
        raise TraceQueryError.new("Too many results") if results.size > 1
        results.first
      end
            
      def one?(type, &block)
        results = collect_for_one(type, &block)
        return results.size == 1
      end
      
      def some?(type, &block)
        results = collect_for_one(type, &block)
        return results.size >= 1        
      end
    
    private
      def collect_for_one(type, &block)
        targets = collect_transformed_by_source(@input_value)
        results = filter_by_type(targets, type) 
        results = results.select(&block) if block_given?
        results        
      end
      
    protected
      
      def filter_by_type(targets, type)
        raise TraceQueryError.new("There is no results") unless targets
        targets.select { |t| t.rumi_kind_of?(type) }
      end
    
      def collect_transformed_by_source(input_value)
        internal = @transformation.status.transformed_by_source(input_value)  
        external = @transformation.status.transformed_by_resuming_source(input_value)
        external.each do |e| e.extend(RubyTL::Rtl::ExternalTraceQueryModelObjectInterface) end
        return external unless internal
        return internal + external 
        # TODO: Improve performance
      end
    
    end
  end
end

module RubyTL
  module Rtl
    # An extension of ModelObjectInterface for thouse external model objects
    # that came from the trace
    # I'm not sure if this is a good solution or just a hack
    module ExternalTraceQueryModelObjectInterface
      include RubyTL::RumiRMOF::ModelObjectInterface

      def metaclass
        self.instance_variable_get('@metaclass')
      end
      
      def rumi_kind_of?(klass)
        klass = klass.real_klass if klass.respond_to?(:real_klass)
        self.is_instance_of?(klass)
      end
    end
  end
end    
      
