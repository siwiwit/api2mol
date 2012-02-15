
module RubyTL
  module BNF
    
    # Definition of a language intended to specify "parseable" BNF
    # grammars.
    # 
    # == Example
    # 
    # The following language can be defined using a BNF
    # grammar expressed with this DSL
    # 
    # Language example:
    #  
    #  family {
    #    parents luis - margarita
    #    children jesus, isabel
    #  }
    #   
    # 
    # Grammar:
    # 
    #  rule :S        => 'Family*'
    #  rule :Family   => %w| family { Parents Children } |
    #  rule :Parents  => %w| parents id(father) - id(mother) |
    #  rule :Children => %w| children ChildrenList |
    #  rule :ChildrenList => %w| id |
    #  rule :ChildrenList => %w| Children , id |
    #  
    #  token :id      => /\w+/ #/\\w+/
    #  token :family  => 'family'
    #  token :parents => 'parents'
    #
    class LanguageDefinition < RubyTL::LowLevelDSL::DslDefinition    
      class InvalidRule < RubyTL::BaseError; end
      class InvalidPair < RubyTL::BaseError; end
    
      keyword('rule')   { param :hash, :hash, :one }
      keyword('token')  { param :hash, :hash, :one }
      keyword('ignore') { param :hash, :hash, :one }
      keyword('pair') { param :hash, :hash, :one }
    
      root_composition do
        contain_keyword 'rule'
        contain_keyword 'token'
        contain_keyword 'ignore'
        contain_keyword 'pair'
      end
    
      visitor_semantics do
        attr_reader :grammar
        
        def start
          @grammar = RubyTL::BNF::Grammar.new
          associate current_node, @grammar
        end
        
        def in_rule
          left, right = left_right_get(current_node)
          rule = RubyTL::BNF::Rule.new
          rule.name  = left.to_s + ' -> ' + [*right].map { |s| s.to_s }.join(' ') 
          rule.left  = create_no_terminal(left.to_s, 0)
          create_right_part(rule, right)
          @grammar.rules << rule        
        end
        
        def in_token
          left, right = left_right_get(current_node)
          @grammar.tokens << create_token(left, right, RubyTL::BNF::Token)
        end

        def in_ignore
          left, right = left_right_get(current_node)
          @grammar.ignoredTokens << create_token(left, right, RubyTL::BNF::IgnoredToken)        
        end

        def in_pair
          left, right = left_right_get(current_node)
          start, close = right[0], right[1]
          raise InvalidPair(left.to_s) unless start && close 
          @grammar.pairTokens << token = create_token(left, start, RubyTL::BNF::PairToken)
          token.endRegexp = close        
        end

        def left_right_get(node)
          rule_hash = node.attributes['hash']
          raise InvalidRule('Invalid number of hash pairs') if rule_hash.size != 1
          left, right = nil, nil
          rule_hash.each_pair { |left, right| }
          return left, right
        end
           
        include VisitorHelper        
      end
    end
    
    module VisitorHelper
      def create_token(left, right, token_klass)
        token = token_klass.new
        token.name    = left.to_s
        token.regexp  = right.respond_to?(:source) ? right.source : right.to_s
        token      
      end
    
      def create_right_part(rule, list)
        list = [*list]
        list.each_with_index do |sym, idx|
          rule.right << create_symbol(sym.to_s, idx)
        end
      end
    
      def create_symbol(sym, idx)
        # TODO: Complex regular expression to check structure
        case sym 
        when nil           then create_lambda('lambda', idx)
        when ''            then create_lambda('lambda', idx)
        when /^lambda$/    then create_lambda(sym, idx)
        when /(.+)\*$/     then create_repetition($1, idx)
        when /(.+)\?$/     then create_optional($1, idx)
        when /^[A-Z][^\*\?]+$/ then create_no_terminal(sym, idx)
        when /^[^\*\?]+$/ then create_terminal(sym, idx)
        else raise "Invalid symbol '#{sym}'"
        end
      end
      
      def create_lambda(sym, idx)
        RubyTL::BNF::Lambda.new
      end
      
      def create_repetition(sym, idx)
        name, position = extract_position(sym, idx)
        rep = RubyTL::BNF::Repetition.new
        rep.positionIdentifier = position
        rep.symbol = create_symbol(name, position)
        rep
      end
    
      def create_optional(sym, idx)
        name, position = extract_position(sym, idx)
        opt = RubyTL::BNF::Optional.new
        opt.positionIdentifier = position
        opt.symbol = create_symbol(name, position)
        opt      
      end
    
      def create_no_terminal(sym, idx)
        name, position = extract_position(sym, idx)
        vn = RubyTL::BNF::NoTerminal.new
        vn.positionIdentifier = position
        vn.name = name
        vn
      end
      
      def create_terminal(sym, idx)
        name, position = extract_position(sym, idx)
        vt = RubyTL::BNF::Terminal.new
        vt.positionIdentifier = position
        vt.name = name
        vt      
      end
      
      def extract_position(sym, idx)
        sym =~ /^([^\*\?\(\)]+)(\(\w+\))?$/
        return $1, ($2 || idx.to_s)
      end
    end

  end
end