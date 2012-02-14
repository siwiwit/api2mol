

module RubyTL
  module Rtl
  
  
    module Preparable
      Config = Struct.new(:algorithm_klass, :extension, :status)
    
      # Prepare an element to be executed. Mixed elements are in charge of
      # propagating the values to contained elements. 
      #
      def prepare(options = {})
        prepared = set_prepared_values(options)
        contained_preparables.each { |p| p.prepare(prepared) }
      end

      def contained_preparables
        []
      end

      def pack_configuration
        Config.new(self.algorithm_klass, self.extension, self.status)
      end

      # Algorithm class used by phases executing rules
      attr_accessor :algorithm_klass
      
      # Extension points
      attr_accessor :extension
      
      # Global transformation status
      attr_accessor :status
    
    private
      
      def set_prepared_values(options = {})
        self.extension       = options[:extension]
        self.algorithm_klass = options[:algorithm_klass] || RubyTL::Rtl::Algorithm                
        self.status          = options[:status] || RubyTL::Rtl::TransformationStatus.new
        return {
          :algorithm_klass => algorithm_klass,
          :extension => extension,          
          :status    => status
        }       
      end          
    end
  end
end