
module RubyTL
  module BNF
    class Lambda; end # TODO: Load the metamodel before this file
    LAMBDA = Lambda.new()

    module QueryFunctions
    
      def all_symbols
        result = []
        self.rules.map { |r| [r.left] + r.right }.flatten.
                   each { |s| include_if_necessary(s, result) }
        result
      end

      def all_terminals
        self.all_symbols.select { |s| s.kind_of?(Terminal) }
      end
      
      def all_no_terminals
        self.all_symbols.select { |s| s.kind_of?(NoTerminal) }
      end
    
      def productions_with_left_part(symbol)
        name = symbol.respond_to?(:name) ? symbol.name : symbol.to_s
        self.rules.select { |r| r.left.name == name }
      end
    
    private
      def include_if_necessary(symbol, list)
        list << symbol unless list.find { |s| s == symbol }
      end
    
    end

    # Functions to compute "first", "follow"
    # and "predict" for LL grammars.
    module FunctionsLL
    
      # First_1(alfa)
      # 
      # It returns a hash whose keys are the grammar
      # symbols. For each grammar symbol a list containing
      # terminal symbols is created.
      def first_table
        FirstTable.new(self)
      end
      
      def gen_if_table(first_table)
        GenIfTable.new(self, first_table)
      end
    end    
    
    class FirstTable < Hash
      def initialize(grammar)
        super()
        @grammar = grammar
        init_table
      end

      def for_symbol_sequence(symbol_list)                
        result = []
        symbol_list.each_with_index do |s, idx|
          first = self[s.name]
          first.reject { |s| s == LAMBDA }.reject { |s| result.include?(s) }.each do |s| 
            yield(s, symbol_list[idx + 1..-1]) if block_given?
            result << s
          end
          break if not first.include?(LAMBDA)
        end
        result << LAMBDA if symbol_list.all? { |s| self[s.name].include?(LAMBDA) }
        result
      end
      
    private
      def init_table
        @done = {}
        @grammar.all_terminals.each    { |s| self[s.name] = first_for_terminal(s) }
        @grammar.all_no_terminals.each { |s| self[s.name] = first_init_no_terminal(s) }
        @grammar.all_no_terminals.each { |s| first_fill(s) }         
      end          

      # Creates the First function for a terminal symbol
      def first_for_terminal(symbol)
        return [symbol] 
      end

      # X : NoTerminal, and X -> lambda, then add lambda to result, else
      # the result is just and emptly list
      def first_init_no_terminal(symbol)
        return [LAMBDA] if @grammar.productions_with_left_part(symbol).
                               any? { |p| p.right.size == 1 && p.right.first.kind_of?(Lambda) }        
        return []
      end

      # If X : NoTerminal, then look for a Terminal       
      def first_fill(symbol)
        return if @done[symbol.name] == true
        @done[symbol.name] == 'doing'
        
        first = self[symbol.name]
        productions = @grammar.productions_with_left_part(symbol)
        productions.each do |p|
          p.right.inject(true) do |is_previous_lambda, s| 
            next  if s.kind_of?(Lambda)
            break if not is_previous_lambda

            sfirst = partial_first(s)
            sfirst.reject { |fs| fs.kind_of?(Lambda) }.
                   reject { |fs| first.include?(fs) }.
                   each   { |fs| first << fs }
            #first << s if not first.include?(s)

            self[s.name].include?(LAMBDA) 
          end
  
          # TODO: Test this situation, may there is a case not handled (review the algorithm)
          if ! first.include?(LAMBDA)
            first << LAMBDA if p.right.all? { |s| self[s.name].include?(LAMBDA) }
          end
        end
        
        @done[symbol.name] = true
      end

      def partial_first(symbol)
        return self[symbol.name] if symbol.kind_of?(Terminal)
        raise "Left recursive grammar in symbol #{symbol.name}" if @done[symbol.name] == 'doing'
        first_fill(symbol)
        return self[symbol.name]      
      end
    end
    
    class GenIfTable < Hash
      EAT = '(eat)'
      
      def initialize(grammar, first_table)
        @grammar = grammar
        @first_table = first_table        
        init_table
      end
      
    private
      def init_table        
        @grammar.rules.each do |p|
          self[p] = {}
          p.right.each do |s|
            next if s.kind_of?(Lambda)
            
            first = @first_table[s.name]
            if s.kind_of?(Terminal)
              first.each { |fs| next if fs.kind_of?(Lambda); self[p][fs.name] = EAT }
            else
              first.each { |fs| next if fs.kind_of?(Lambda); self[p][fs.name] = s }
            end            
          
            break if not first.find { |fs| fs.kind_of?(Lambda) }
          end  
        end
      end
    end
    
  end
end