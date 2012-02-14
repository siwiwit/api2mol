
module Test
  module GrammarHelper
    include RubyTL::BNF
  
    # Grammar: 
    #   S -> aaSGd
    #   G -> gGa
    #   G -> dGg
    #
    # Tokens: a, d, g   
    #
    def simple_grammar
      grammar = RubyTL::BNF::Grammar.new
      grammar.tokens << createobj(Token, :name => :a, :regexp => /abc/.source)
      grammar.tokens << createobj(Token, :name => :d, :regexp => /def/.source)
      grammar.tokens << createobj(Token, :name => :g, :regexp => /ghi/.source)
      grammar.ignoredTokens << createobj(IgnoredToken, :name => 'whitespace', :regexp => /\s+/.source)
      
      grammar.rules << rule1 = createobj(Rule, :name => 'Start')
      rule1.left  = createobj(NoTerminal, :name => 'S')
      rule1.right << createobj(Terminal, :name => 'a')
      rule1.right << createobj(Terminal, :name => 'a')
      rule1.right << createobj(NoTerminal, :name => 'S')
      rule1.right << createobj(NoTerminal, :name => 'G')
      rule1.right << createobj(Terminal, :name => 'd')
      
      grammar.rules << rule2 = createobj(Rule, :name => 'G1')
      rule2.right << createobj(Terminal, :name => 'g')
      rule2.left = createobj(NoTerminal, :name => 'G')
      rule2.right << createobj(Terminal, :name => 'a')

      grammar.rules << rule3 = createobj(Rule, :name => 'G2')
      rule3.right << createobj(Terminal, :name => 'd')
      rule3.left = createobj(NoTerminal, :name => 'G')
      rule3.right << createobj(Terminal, :name => 'g')
      
      grammar
    end
  
    def identifier_grammar
      grammar = RubyTL::BNF::Grammar.new
      grammar.tokens << createobj(Token, :name => :names, :regexp => /names/.source)
      grammar.tokens << createobj(Token, :name => :colon, :regexp => /:/.source)
      grammar.tokens << createobj(Token, :name => :comma, :regexp => /,/.source)
      grammar.tokens << createobj(Token, :name => :id, :regexp => /\w+/.source)
      grammar.ignoredTokens << createobj(IgnoredToken, :name => 'whitespace', :regexp => /\s+/.source)
      grammar
    end
    
    # type   -> simple ;
    # type   -> ^ id ;
    # type   -> array of type
    # simple -> integer
    # simple -> char
    # simple -> 'lambda'
    def type_grammar
      grammar = RubyTL::BNF::Grammar.new
      grammar.tokens << createobj(Token, :name => :semicolon, :regexp => /;/.source)
      grammar.tokens << createobj(Token, :name => :hat, :regexp => /\^/.source)
      grammar.tokens << createobj(Token, :name => :array, :regexp => /array/.source)
      grammar.tokens << createobj(Token, :name => :of, :regexp => /of/.source)
      grammar.tokens << createobj(Token, :name => :integer, :regexp => /integer/.source)
      grammar.tokens << createobj(Token, :name => :char, :regexp => /char/.source)
      grammar.tokens << createobj(Token, :name => :id, :regexp => /\w+/.source)
      # TODO: If i don't specify ignored tokens, then it fails
      grammar.ignoredTokens << createobj(IgnoredToken, :name => 'whitespace', :regexp => /\s+/.source)

      grammar.rules << rule1 = createobj(Rule, :name => 'T1')
      rule1.left  =  createobj(NoTerminal, :name => 'Type')
      rule1.right << createobj(NoTerminal, :name => 'Simple')
      rule1.right << createobj(Terminal, :name => 'semicolon')

      grammar.rules << rule1 = createobj(Rule, :name => 'T2')
      rule1.left  =  createobj(NoTerminal, :name => 'Type')
      rule1.right << createobj(Terminal, :name => 'hat')
      rule1.right << createobj(Terminal, :name => 'id')

      grammar.rules << rule1 = createobj(Rule, :name => 'T3')
      rule1.left  =  createobj(NoTerminal, :name => 'Type')
      rule1.right << createobj(Terminal, :name => 'array')
      rule1.right << createobj(Terminal, :name => 'of')
      rule1.right << createobj(NoTerminal, :name => 'Type')
      
      
      grammar.rules << rule1 = createobj(Rule, :name => 'S4')
      rule1.left  =  createobj(NoTerminal, :name => 'Simple')
      rule1.right << createobj(Terminal, :name => 'integer')

      grammar.rules << rule1 = createobj(Rule, :name => 'S5')
      rule1.left  =  createobj(NoTerminal, :name => 'Simple')
      rule1.right << createobj(Terminal, :name => 'char')

      grammar.rules << rule1 = createobj(Rule, :name => 'S6')
      rule1.left  =  createobj(NoTerminal, :name => 'Simple')
      rule1.right << createobj(Lambda, {})
      
      grammar    
    end
    
    def createobj(klass, values)
      # TODO: Generated classes should inherit from EObjectImpl
      o = klass.new
      values.each_pair { |k, v| o.send("#{k}=", v) }
      o
    end  
  end
end