
def validate_model(name, &block)
  RubyTL::Checker::ValidateTask.new(name, &block)
end

module RubyTL
  module Checker
    class ValidateTask < RubyTL::Base::BaseTaskLib
      attr_accessor :name
      attr_reader :collected_sources
      attr_reader :collected_filename
      
      def initialize(name, &block)
        @collected_sources = []
        @collected_filename = nil
        @stop_on_error = false
        super(name, &block)  
      end
  
      # Specification of the validation file to be executed. 
      #
      # == Example
      #
      #    task.validation_file 'file:///tmp/class2table.rb'
      #
      def validation_file(value)
        @collected_filename = as_resource(value)
      end
             
      def stop_on_error(stop = true)
        @stop_on_error = stop
      end           
             
      def define
        define_task(name) do
          self.evaluate_validation
        end
      end
  
      def evaluate_validation
        # TODO: Check values
        additional = { :dsl_file   => @collected_filename } 
        launcher   = RubyTL::Checker::Launcher.new(input_values.merge(additional))
        launcher.evaluate
  
        #if launcher.errors_by_invariant.size > 0
        #  launcher.errors_by_invariant.each_value do |error_list|
        #    error_list.each do |error|          
        #      puts "Invariant #{error} not passed for #{error.objects.size} instances. They are:" + $/
        #      puts error.objects.map { |o| "\t#{o.metaclass.rumi_qualified_name} = { #{o} }" }.join($/)
        #    end
        #  end
        if launcher.validation_has_errors?
          launcher.print_errors($stdout)
          error = ValidationNotPassed.new
          error.dsl_filename = self.collected_filename
          raise error if @stop_on_error
        else
          puts "Validation performed OK"
        end
        
      end
  
    end
    
    class ValidationNotPassed < RubyTL::BaseError
      include BacktraceHandling  
      attr_accessor :dsl_filename
      def initialize
        super("Validation not passed")
      end
    end
  end
end
