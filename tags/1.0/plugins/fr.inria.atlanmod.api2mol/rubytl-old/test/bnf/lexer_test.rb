require 'rubytl_base_unit'


class LexerTest < Test::Unit::TestCase
  include RubyTL::BNF
  include Test::GrammarHelper
 
  def setup
    @simple_grammar = simple_grammar
    @identifier_grammar = identifier_grammar
  end
 
  def test_simple_tokens
    lexer = RubyTL::BNF::Lexer.new(@simple_grammar, "abc   def ghi")
    
    token = lexer.next_token
    assert_equal 'a', token.kind
    assert_equal 'abc', token.match
    assert_equal 'd', lexer.next_token.kind
    assert_equal 'g', lexer.next_token.kind
  end
  
  def test_pair_tokens_for_comments
    grammar = RubyTL::BNF::Grammar.new
    grammar.pairTokens << createobj(PairToken, :name => :commented_line, :regexp => /--/, :endRegexp => /\n/.source)
    grammar.pairTokens << createobj(PairToken, :name => :commented, :regexp => /\/\*/, :endRegexp => /\*\//.source)
  
    lexer = RubyTL::BNF::Lexer.new(grammar, "/* cosa */")
    token = lexer.next_token
    assert_equal 'commented', token.kind
    assert_equal '/* cosa */', token.match
    
    lexer = RubyTL::BNF::Lexer.new(grammar, "-- cosa \n")
    assert_equal 'commented_line', lexer.next_token.kind    
  end
  
  def test_language_with_identifiers
    lexer = RubyTL::BNF::Lexer.new(@identifier_grammar, "names : jesus, luis, names")

    assert_equal 'names', lexer.next_token.kind
    assert_equal 'colon', lexer.next_token.kind
    assert_equal 'id', lexer.next_token.kind
    assert_equal 'comma', lexer.next_token.kind
    assert_equal 'id', lexer.next_token.kind
    assert_equal 'comma', lexer.next_token.kind
    assert_equal 'names', lexer.next_token.kind
  end

  def test_rollback
    lexer = RubyTL::BNF::Lexer.new(@simple_grammar, "abc   def ghi")
    
    assert_equal 'a', lexer.next_token.kind  
    lexer.rollback
    assert_equal 'a', lexer.next_token.kind  
    assert_equal 'd', lexer.next_token.kind
    lexer.rollback
    lexer.rollback
    assert_equal 'a', lexer.next_token.kind
    assert_equal 'd', lexer.next_token.kind
    assert_equal 'g', lexer.next_token.kind
  end
  
  def test_lexer_in_multiple_lines
    lexer = RubyTL::BNF::Lexer.new(@simple_grammar, "asdff \nabc def ghi")
    assert_raise(RubyTL::BNF::NoTokenFound) { lexer.look_ahead }
  end
  
  def test_lookahead
    lexer = RubyTL::BNF::Lexer.new(type_grammar, "integer ; array of char")
    
    assert_equal 'integer', lexer.look_ahead.kind
    assert_equal 'integer', lexer.look_ahead.kind
    lexer.eat
    assert_equal 'semicolon', lexer.look_ahead.kind
    assert_equal 'semicolon', lexer.next_token.kind
    
    assert_equal 'array', lexer.next_token.kind
    assert_equal 'of', lexer.next_token.kind
    assert_equal 'char', lexer.next_token.kind
  end
  
  def test_tokens_are_properly_split
    lexer = RubyTL::BNF::Lexer.new(type_grammar, "arrayofchar")

    assert_equal 'id', lexer.next_token.kind
  end
end