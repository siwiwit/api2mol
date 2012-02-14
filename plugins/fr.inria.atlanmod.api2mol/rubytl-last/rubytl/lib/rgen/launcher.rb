

module RubyTL
  module RGen

    class Launcher < RubyTL::Base::Launcher
    
      def initialize(options = {})
        super(options)
        @codebase = options[:codebase] || @config.workspace.root_path
      end

#      tocode = RubyTL::Templating::ModelToCode.new(@collected_sources, @@logical_mapper, @codebase)
   
#          handle_dsl_exceptions(f) do
#            @@logical_mapper.open_file(f) { |f| tocode.bind_and_eval(f) }                    
#          end
    
      # Override the default context setup.
      def dsl_setup
        mapper = RubyTL::TemplateMapper.new(@config.workspace)
        context = RubyTL::Templating::ModelToCode.create_dsl_module(mapper, @codebase, @parameters)
        language_definition = RubyTL::Templating::LanguageDefinition.info 
        language_definition.create_dsl_in_context(context)
        context        
      end
      
      def load_dsl_text(context)      
        dsl_text = read_dsl_file()
        handle_dsl_exceptions(@dsl_file.file_path) do
          context.module_eval(dsl_text, @dsl_file.file_path || '')
        end
        loaded = context.execute_visitor_semantics               
        context.instance_variable_set("@transformation", loaded.visitor.transformation) # TODO: Do it in other way
      end
      
      def execute_dsl(context)
        handle_runtime_dsl_exceptions(@dsl_file.file_path) do
          context.start_transformation(@dsl_file.file_path)
        end
      end            
 
    end
  
  end
end