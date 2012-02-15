
module RubyTL
  module Base
    
    # This is the base class for launchers. Each component should define
    # its own launcher.
    #
    class Launcher
      include RubyTL::Base::ExceptionHandling
      
      attr_reader :config
      attr_reader :loaded_source, :loaded_target
      
      # 
      # == Arguments
      # It receives a hash with options. Some options are optional or
      # compulsory depending on the subclass...
      # 
      # * <tt>:source_modes</tt>.  A list of of RubyTL::Base::ModelInformation objects
      # * <tt>:target_models</tt>. A list of of RubyTL::Base::ModelInformation objects
      # * <tt>:dsl_file</tt>. The DSL file to be launched, represented with a Resource.
      # * <tt>:config</tt>. User defined configuration
      #
      def initialize(options = {})
        @sources  = (options[:source_models] || []).dup
        @targets  = (options[:target_models] || []).dup  
        @dsl_file = options[:dsl_file]   
        @config   = options[:config] || RubyTL::Base::Configuration.new
        #@config   = @config.clone_with_additional_path(File.dirname(@dsl_file))
        @parameters = options[:parameters] || {}
      end

      # It evaluates the DSL but does not start its execution. Therefore,
      # the execute_dsl and serialize_target_models methods are not executed.
      def evaluate_dsl_only
        context                        = dsl_setup
        @loaded_source, @loaded_target = load_models  
        
        put_models_into_context(context, @loaded_source, @loaded_target)  
        load_dsl_text(context)
        context				
      end
      
      # The evaluation of an embedded DSL is performed in the
      # following steps:
      # 
      # 0. Setting up a context to evaluate the DSL
      # 1. Load source and target models
      # 2. Load files (transformation, templates, or whatever)
      # x. Serialize target models (if any)
      # 
      # If there are target models, they can be accessed after calling "evaluate"
      # by calling "target_result"
      # 
      def evaluate
        context = evaluate_dsl_only
        execute_dsl(context)
        serialize_target_models(@loaded_target)
      end
      
      def duplicate_for_importation(dsl_file, options = {})
        launcher = self.dup
        options.each do |key, value|
          next if key == :name_mappings
          launcher.send("#{key}=", value)
        end
        
        launcher.dsl_file = @config.workspace.create_resource(dsl_file)
        
        # This is a bit of a hack, for two reasons:
        #  First: The only operation of a NameMapping is put_into_context (it works because of duck-typing)
        #  Second: I'm not differentiating between source and target name mappings. This has some sense, because they are going to be serialized by the LoadedModel they come from...
        name_mappings = options[:name_mappings]
        if name_mappings && ! name_mappings.empty?
          launcher.instance_variable_set('@name_mappings', name_mappings)
          def launcher.load_models; return [@name_mappings, []]; end
        else
          def launcher.load_models; return [@loaded_source, @loaded_target]; end
        end
        def launcher.serialize_target_models(target_models); end # Avoid serialization
        launcher
      end
      
      protected
      
      # Sets the DSL file to be executed. Intended only for duplication
      # purposes.
      def dsl_file=(dsl_file)
        @dsl_file = dsl_file
      end
      
      def dsl_setup
        raise "Implemented by subclass"
      end
      
      def put_models_into_context(context, source_models, target_models)
       (source_models + target_models).each { |m| m.put_into_context(context) }
      end
      
      def load_dsl
        raise "Implemented by subclass"
      end
      
      def execute_dsl(context)
        raise "Implemented by subclass"
      end
      
      def serialize_target_models(target_models)
        target_models.select { |m| m.serializable? }.each do |model|
          model.serialize
        end
        additional_serialization if self.respond_to?(:additional_serialization)
      end
      
      def load_models
        repository = RubyTL::Base::Repository.new(@config.available_handlers, create_strategy_provider)
        loaded_sources = @sources.map { |model| 
          handle_repository_exceptions(model) { repository.load_source_model(model) }
        }
        loaded_targets = @targets.map { |model| 
          handle_repository_exceptions(model) { repository.load_target_model(model) }
        }
        load_additional_models(repository) if self.respond_to?(:load_additional_models)
        return loaded_sources, loaded_targets
      end
            
      private
      
      def create_strategy_provider
        RubyTL::Base::StrategyProvider.new
      end
      
      def read_dsl_file(file = @dsl_file)
        #raise RubyTL::TransformationNotExist.new(@transformation) unless File.exist?(filename)
        file.read
      rescue => e
        raise ReadError.new(e.message)
      end
      
    end
  
    class ReadError < RubyTL::BaseError; end     
  end
end