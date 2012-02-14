
module RubyTL
  module BNF
  
    # TODO: Check that all no terminals specified in the grammar 
    # are defined as tokens...
    class ParserGeneratorLL
      START_FUNCTION_NAME  = 'parsing_start'
      START_FUNCTION       = File.join(File.dirname(__FILE__), 'templates', 'start_function.erb')      
      NO_TERMINAL_FUNCTION = File.join(File.dirname(__FILE__), 'templates', 'no_terminal_function.erb')      
    
      attr_reader :grammar, :first_table, :gen_if_table, :symbol
      attr_reader :first_proc
      
      def initialize(grammar)
        @grammar = grammar
        @first_table  = grammar.first_table
        @gen_if_table = grammar.gen_if_table(first_table) 
      end
    
      def generate 
        @first_proc = proc_name(@grammar.rules.first.left)
        
        start   = apply_template START_FUNCTION
        parsing = @grammar.all_no_terminals.map do |no_terminal|
          @symbol = no_terminal
          apply_template NO_TERMINAL_FUNCTION
        end

        ([start] + parsing).join($/)
      end
      
      def evaluator(text = nil)
        text = text || generate
        GeneratedParserEvaluator.new(@grammar, text, START_FUNCTION_NAME)
      end
      
    private
      def proc_name(symbol); 'parse_' + symbol.name end
    
      def apply_template(filename)
        erb = ERB.new(read_template(filename), nil, '-')
      	erb.result(binding)      
      end
      
      def read_template(filename) 
        File.open(filename) { |f| f.read }
      end

      # TODO: DO A TEST CASE
      # This only works if the grammar is LL(1)
      # TODO: Be careful with children traversing. The problem is related to
      #       the fact that the first call can be ignored if the Vn contain lambda,
      #       so children.size cannot be the expected. 
      def sequence_calls(production, terminal, rest)
        
        genif = @gen_if_table[production][terminal.name]
        raise "Error: Production #{production}, Terminal: #{terminal.name}" unless genif
        
        first_match = if genif == RubyTL::BNF::GenIfTable::EAT
            'create_tnode(lexer.eat, node)'
          else
            "add_rnode(#{proc_name(genif)}, node)"
          end
        
        ([first_match] + rest.map do |s| 
          s.kind_of?(Terminal) ? "create_tnode(lexer.match('#{s.name}'), node)" : "add_rnode(#{proc_name(s)}, node)"
        end).join('; ')
      end
    end
  
    class GeneratedParserEvaluator      
      attr_reader :tree
      
      def initialize(grammar, text, start_method)
        @grammar = grammar
        @start_method = start_method
        self.instance_eval text
      end
      
      attr_reader :lexer
      
      def evaluate(lexer)
        @lexer = lexer
        self.send(@start_method)
      end
    
      def create_tnode(token, parent)
        node = RubyTL::CST::TNode.new        
        node.kind = token.kind
        node.value = token.match
        parent.children << node
        node
      end
      
      def add_rnode(node, parent)
        parent.children << node
        node
      end
    end
    
  end
end