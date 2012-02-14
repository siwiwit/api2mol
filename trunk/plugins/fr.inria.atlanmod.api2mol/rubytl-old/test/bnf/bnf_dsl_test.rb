require 'rubytl_base_unit'

class VisitorHelperMock
  include RubyTL::BNF::VisitorHelper
end

class BNFTest < Test::Unit::TestCase
  include RubyTL::LowLevelDSL
 
  def test_symbol_recognition
    klass = Class.new do
      include RubyTL::BNF::VisitorHelper
      def create_lambda(sym, idx);      'lam_' + sym; end
      def create_repetition(sym, idx);  'rep_' + sym; end
      def create_optional(sym, idx);    'opt_' + sym; end
      def create_no_terminal(sym, idx); 'vn_'  + sym end
      def create_terminal(sym, idx);    'vt_'  + sym end
    end
    
    assert_equal 'rep_NoTerm', klass.new.create_symbol('NoTerm*', 0)
    assert_equal 'rep_term', klass.new.create_symbol('term*', 0)
    assert_equal 'opt_NoTerm', klass.new.create_symbol('NoTerm?', 0)
    assert_equal 'opt_term', klass.new.create_symbol('term?', 0)

    assert_equal 'vn_NoTerm', klass.new.create_symbol('NoTerm', 0)
    assert_equal 'vt_term', klass.new.create_symbol('term', 0)    

    assert_equal 'lam_lambda', klass.new.create_symbol('lambda', 0)
    assert_equal 'lam_lambda', klass.new.create_symbol('', 0)
    assert_equal 'lam_lambda', klass.new.create_symbol(nil, 0)
  end
  
  def test_extract_position
    helper = VisitorHelperMock.new
    name, position = helper.extract_position('S', 0)
    
    assert_equal 'S', name
    assert_equal '0', position
    
    # TODO: More tests...
  end

  def test_visitor_creates_proper_structure
    dsl = load_family_dsl
    visitor = dsl.execute_visitor_semantics.visitor
    
    grammar = visitor.grammar
  
    assert grammar.kind_of?(RubyTL::BNF::Grammar)
    assert_equal 6, grammar.rules.size
    
    # Rules
    ruleS = grammar.rules[0]
    assert_equal 'S', ruleS.left.name 
    assert_equal 1, ruleS.right.size
    
    ruleF = grammar.rules[1]
    assert_equal 'Family', ruleF.left.name 
    assert_equal 5, ruleF.right.size
    
    # Tokens
    assert_equal 3, grammar.tokens.size
    assert_equal 1, grammar.ignoredTokens.size
    
    assert_equal(/\w+/.source, grammar.tokens[0].regexp)
    assert_equal 'id', grammar.tokens[0].name

    assert_equal 'family', grammar.tokens[1].regexp
    assert_equal 'family', grammar.tokens[1].name

    assert_equal(/\s+/.source, grammar.ignoredTokens[0].regexp)
    assert_equal 'whitespace', grammar.ignoredTokens[0].name
  end
    
private


  def load_family_dsl
    info = RubyTL::BNF::LanguageDefinition.info
    dsl = create_dsl_evaluator(info)
    dsl.class_eval %{          
       rule :S        => 'Family*'
       rule :Family   => %w| family { Parents Children } |
       rule :Parents  => %w| parents id(father) - id(mother) |
       rule :Children => %w| children ChildrenList |
       rule :ChildrenList => %w| id |
       rule :ChildrenList => %w| Children , id |
       
       token :id      => /\\w+/ 
       token :family  => 'family'
       token :parents => 'parents'
       
       ignore :whitespace => /\\s+/
    }  
    dsl
  end

  
  def create_dsl_evaluator(evaluator_info)
    context = Module.new
    evaluator_info.create_dsl_in_context(context)
  end    
end