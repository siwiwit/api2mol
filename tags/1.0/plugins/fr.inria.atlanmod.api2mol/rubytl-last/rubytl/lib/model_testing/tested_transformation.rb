$VERBOSE=nil # TO AVOID ALREADY INITIALIZED CONSTANT :-S

module RubyTL
  module ModelTesting
    MetamodelInformation = Struct.new(:namespace, :resource)
    ModelInformation     = Struct.new(:namespace, :resource)

    # This class represents a model-to-model transformation to
    # be tested.
    #  
    class BaseTestedTransformation
      
      # Creates a new transformation that is going to be tested.
      # It receives the source and target metamodels as MetamodelInformation
      # objects, and a transformation file as a Resource.
      # 
      # == Arguments
      # * <tt>source_metamodels</tt>
      # * <tt>target_metamodels</tt>
      # * <tt>transformation_file</tt>
      #
      def initialize(config, source_metamodels, target_metamodels, transformation_file)
        @config            = config
        @source_metamodels = source_metamodels
        @target_metamodels = target_metamodels
        @transformation_file = transformation_file
        @single_test_cases = {}        
      end

      def add_test(single_test)        
        @single_test_cases[single_test.name] = single_test
      end
      
      def do_test(name)
        @single_test_cases[name].do_test(self)
      end
      
      def execute(inputs)
        raise "Input doesn't match source metamodels" if inputs.size != @source_metamodels.size
        source_models = create_models_from_metamodels(inputs, @source_metamodels)
        target_models = @target_metamodels.map do |target|
          resource = RubyTL::Base::Resource.new("memory://#{target.namespace}")
          RubyTL::Base::ModelInformation.new(target.namespace, target.resource, resource)        
        end

        launcher = get_launcher_class.new(:config => @config, :source_models => source_models, 
                                             :target_models => target_models,
                                             :dsl_file      => @transformation_file)
        launcher.evaluate
        return launcher.loaded_source, launcher.loaded_target
      end
      
      def load_expected(expected)
        repository = RubyTL::Base::Repository.new(@config.available_handlers)
        models = create_models_from_metamodels(expected, @target_metamodels)
        models.map { |model| repository.load_source_model(model) }
      end
    
    private
      def create_models_from_metamodels(models, metamodels)
        models.reject { |input| input.resource.respond_to?(:empty?) && input.resource.empty? }. 
               map do |input|
          metamodel = metamodels.select { |m| m.namespace == input.namespace }.first
          raise "No metamodel #{input.namespace} defined" unless metamodel 
          
          RubyTL::Base::ModelInformation.new(input.namespace, metamodel.resource, input.resource)
        end      
      end
      
    end
  
    class RubyTLTestedTransformation < BaseTestedTransformation
      def get_launcher_class
        RubyTL::Rtl::Launcher
      end
    end  

    class WalkTestedTransformation < BaseTestedTransformation
      def get_launcher_class
        RubyTL::Walker::Launcher
      end
    end  
  
    class SingleTestCase
      include RubyTL::ModelTesting::Heuristics
      attr_reader :name
      attr_accessor :sentences_block
      
      def initialize(name, inputs, expected)
        @name = name
        @inputs = inputs
        @expected = expected
      end
      
      def do_test(transformation)        
        source, target = transformation.execute(@inputs)
        if not @expected.empty?
          # Try to compare automatically
          expected       = transformation.load_expected(@expected)
          compare(target, expected)
          #self.errors.each { |e| $stderr << e.to_s + $/}
          if self.errors.size > 0
            raise HeuristicError.new(self.errors)
          end
        end
        
        if @sentences_block
          require 'runit/assert'          
          context = ::Kernel
          context.send :extend, RUNIT::Assert
          (source + target).each { |m| m.put_into_context(context) }
          context.module_eval(&@sentences_block)
        end  
      rescue Test::Unit::AssertionFailedError => e
        raise e if $debug_mode      
        # This is a very quick (and nasty) way of filtering the trace
        last = e.backtrace.last.split(':')[0]
        backtrace = e.backtrace.select { |l| l.split(':')[0] == last }
        exception = Exception.new(e.message.gsub($/, ' '))
        exception.set_backtrace backtrace unless $debug_mode
        raise exception
      rescue RubyTL::RubySyntaxError, RubyTL::EvaluationError => e
        raise e if $debug_mode
        backtrace = []
        e.print_error(backtrace, e.filenames)
        exception = Exception.new
        exception.set_backtrace backtrace         
        raise exception      
      end
    end
    
    class HeuristicError < Test::Unit::AssertionFailedError
      def initialize(errors)
        @errors = errors      
      end
      
      def backtrace
        @errors.map { |e| e.to_s }
      end
    end
    
  end
  
  
  
end