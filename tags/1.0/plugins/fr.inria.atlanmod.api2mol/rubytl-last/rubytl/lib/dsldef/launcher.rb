
module RubyTL
  module LowLevelDSL
    module LauncherMixin
      def create_new_dsl_context
        context = Class.new(RubyTL::LowLevelDSL::DslDefinition)
        context.extend(RubyTL::ParameterHandling)
        context.extend(RubyTL::HelperLoading)
        context.load_helper_set(@config.workspace, context)
        context.parameter_set(@parameters)
        context                
      end
      
      def load_dsl_text_from_file(context, dsl_file)
        dsl_text = read_dsl_file(dsl_file)
        handle_dsl_exceptions(dsl_file.file_path) do
          context.module_eval(dsl_text, dsl_file.file_path || '')
        end        
      end
      
      def execute_dsl_program(context, dsl_definition, dsl_program)
        evaluator = create_program_tree(context, dsl_definition, dsl_program)
        create_abstract_syntax(evaluator, dsl_definition)     
      end
      
      def create_program_tree(context, dsl_definition, dsl_program)
        evaluator = nil
        handle_dsl_exceptions(dsl_program.file_path) do
          evaluator = context.info.create_dsl_in_context(context)
          context.module_eval(read_dsl_file(dsl_program), dsl_program.file_path || '')          
        end
        evaluator
      end
      
      # It returns a +LoadedProgram+ object, which is the result
      # of requesting the evaluation of the tree created by the
      # evaluator.
      def create_abstract_syntax(evaluator, dsl_definition)
        handle_dsl_exceptions(dsl_definition.file_path) do
          evaluator.execute_visitor_semantics(self)
        end        
      end
    end
    
    class Launcher < RubyTL::Base::Launcher
      include LauncherMixin
      
      def initialize(options = {})
        super(options)
        @executed_file = options[:executed_file] 
      end
    
      # Override the default context setup.
      def dsl_setup
        create_new_dsl_context
      end
      
      def load_dsl_text(context)
        load_dsl_text_from_file(context, @dsl_file)      
      end
      
      def execute_dsl(context)
        execute_dsl_program(context, @dsl_file, @executed_file)
      end 
    end

    class FamilyLauncher < RubyTL::Base::Launcher
      include LauncherMixin
      
      def initialize(options = {})
        super(options)
        @dsl_programs = options[:dsl_programs] 
        @loaded_definitions = {}
        @loaded_programs = {}
      end
    
      # Overriding default evaluate to handle several dsl programs
      # at once.
      def evaluate
        @loaded_source, @loaded_target = load_models
        
        executions = @dsl_programs.map do |program, definition|
          context = create_new_dsl_context
          put_models_into_context(context, @loaded_source, @loaded_target)
          load_dsl_text_from_file(context, definition)
          evaluator = create_program_tree(context, definition, program)
          @loaded_definitions[program.file_path] = evaluator          
          lambda {
            create_abstract_syntax!(evaluator, program, definition)      
          }
        end
        executions.each { |e| e.call }
        serialize_target_models(@loaded_target)
      end      
      
      def load_program_tree(program_uri, definition_uri)
        resource   = @config.workspace.create_resource(program_uri)
        definition = @config.workspace.create_resource(definition_uri)
        evaluator  = @loaded_definitions[resource.file_path]
        raise NoLoadedProgram.new("Program #{program_uri} not loaded") unless evaluator
        
        return create_abstract_syntax!(evaluator, resource, definition)
      end
    
    private
      def create_abstract_syntax!(evaluator, program, definition)
        unless @loaded_programs[program.file_path]
          loaded_model = create_abstract_syntax(evaluator, definition)
          @loaded_programs[program.file_path] = loaded_model                                      
        end      
        return @loaded_programs[program.file_path]
      end
    end

    class NoLoadedProgram < RubyTL::BaseError; end;      
  end
end
