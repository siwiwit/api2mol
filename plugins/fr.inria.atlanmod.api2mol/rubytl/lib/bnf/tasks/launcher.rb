

module RubyTL
  module BNF

    class Launcher < RubyTL::Base::Launcher
    
      def initialize(options = {})
        super(options)
        @parsed_file = options[:parsed_file]
        @visitor_file = options[:visitor_file] 
      end
    
      # Override the default context setup.
      def dsl_setup
        context = Module.new
        language_definition = RubyTL::BNF::LanguageDefinition.info 
        language_definition.create_dsl_in_context(context)
        context        
      end
      
      def load_dsl_text(context)      
        dsl_text = read_dsl_file()
        handle_dsl_exceptions(@dsl_file.file_path) do
          context.module_eval(dsl_text, @dsl_file.file_path || '')
        end
        loaded = context.execute_visitor_semantics
        @grammar = loaded.visitor.grammar
      end
      
      def execute_dsl(context)
        text_to_be_parsed = @parsed_file.read
        tree = handle_runtime_dsl_exceptions(@dsl_file.file_path, RubyTL::BNF::NoTokenFound) do          
          generator = RubyTL::BNF::ParserGeneratorLL.new(@grammar)
          File.open("/tmp/salida", "w") { |f| f.puts generator.generate }
          evaluator = generator.evaluator
          evaluator.evaluate(RubyTL::BNF::Lexer.new(@grammar, text_to_be_parsed))
          evaluator.tree
        end
        
        execute_visitor(tree) if @visitor_file
      end            

      def execute_visitor(tree)
        dsl_text = read_dsl_file(@visitor_file)
        visitor_klass = Class.new(RubyTL::Base::GenericVisitor)
        put_models_into_context(visitor_klass, @loaded_source, @loaded_target)        
        handle_dsl_exceptions(@visitor_file.file_path) do
          visitor_klass.module_eval(dsl_text, @visitor_file.file_path)
        end

        handle_runtime_dsl_exceptions(@visitor_file.file_path) do
          visitor = visitor_klass.new          
          tree.accept(visitor)
        end
      end 
    end
  
  end
end