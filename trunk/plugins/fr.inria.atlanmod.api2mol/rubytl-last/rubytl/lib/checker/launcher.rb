
module RubyTL
  module Checker
  
    # Creates a new instance of the Checker launcher. 
    #
    # == Example (new style)
    #
    #     launcher = Checker::Launcher.new(:source_models   => [ShouldBindModel.new(...), OverridingModel.new('...'),
    #                                     :target_models   => [ShouldBindModel.new(...)] },
    #                                     :validation_file => 'class2table/class2table.rb')
    #
    # == Arguments (new style)
    # * <tt>:source_models</tt>. An array of LaunchingModels, that are the source models.
    # * <tt>:validation_file</tt>. The validation definition written in the DSL defined by the Checker::DSL
    #  
    class Launcher < RubyTL::Base::Launcher
      
      attr_reader :errors_by_invariant
    
      def initialize(options = {})
        super(options)
      end
  
      # Loads the DSL by creating a dynamic module, used as +context+,
      # and including the RubyTL::Keywords module.
      def dsl_setup
        context = Module.new do            
          module_eval("extend RubyTL::Checker::DSL") 
          extend RubyTL::HelperLoading       
        end
        context.load_helper_set(@config.workspace, context)                
        return context
      end  
      
      def load_dsl_text(context)      
        dsl_text = read_dsl_file()
        handle_dsl_exceptions(@dsl_file.file_path) do
          File.open(@dsl_file.file_path, 'r') do |f|
            context.module_eval(dsl_text, @dsl_file.file_path)
          end        
        end
      end

      def execute_dsl(context)
        @errors_by_invariant = check_errors(context)
        @global_errors = check_global_errors(context)
      end

      def validation_has_errors?
        ! ( errors_by_invariant.empty? && @global_errors.empty? ) 
      end

      def print_errors(io)
        @global_errors.each { |e| io << e + $/ }
        @errors_by_invariant.each_value do |error_list|
          error_list.each do |error|          
            io << "Invariant #{error} not passed for #{error.objects.size} instances. They are:" + $/
            io << error.objects.map { |o| "\t#{o.metaclass.rumi_qualified_name} = { #{o} }" }.join($/) + $/
          end
        end
      end

    private
      def check_global_errors(context)
        context.__globals__.select { |g| g.any_error? }.map { |g| g.errors }.flatten
      end 
 
      def check_errors(context)
        validation_contexts = context.__contexts__
        validation_contexts.map { |c| c.errors.select { |e| not e.empty? } }.flatten.group_by { |e| e.invariant.name }
      end
    
      #def load_models(context)
      #  repository = RubyTL::Repository.new(RubyTL::DualHandler.new(@model_mappings), @resolver)
      #  @sources.each { |model| model.bind_as_source(repository, context) }
      #  repository
      #end
    end
  end
end
