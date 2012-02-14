require 'rubytl_base_unit'


class ParserTest < Test::Unit::TestCase
  include RubyTL::BNF
  include Test::GrammarHelper
 
  def setup
    @simple_grammar = simple_grammar
    @identifier_grammar = identifier_grammar
  end
 
  def test_equal_symbol
    assert createobj(Terminal, :name => :a) == createobj(Terminal, :name => :a)
    assert ! (createobj(Terminal, :name => :a) == createobj(Terminal, :name => :b))
    assert ! (createobj(Terminal, :name => :a) == createobj(NoTerminal, :name => :a))
    
    assert Lambda.new == Lambda.new
    assert [Lambda.new, Object.new].include?(Lambda.new)
  end
 
  def test_all_symbols
    list = @simple_grammar.all_symbols

    assert_equal 5, list.size
    assert_not_nil list.find { |s| s.name == 'S' }
    assert_not_nil list.find { |s| s.name == 'a' }
    assert_not_nil list.find { |s| s.name == 'd' }
    assert_not_nil list.find { |s| s.name == 'G' }
    assert_not_nil list.find { |s| s.name == 'g' }
  end
  
  def test_first_table
    table = @simple_grammar.first_table
    
    assert_equal 5, table.size
    
    # Expected table:
    # First(a) = { a }, First(d) = { d }, First(g) = { g }
    # First(S) = { a }
    # First(G) = { g, d }
    assert_equal 1, table['a'].size
    assert_equal 1, table['d'].size
    assert_equal 1, table['g'].size
    assert_equal 'a', table['a'].first.name
    assert_equal 'd', table['d'].first.name
    assert_equal 'g', table['g'].first.name

    assert_equal 1, table['S'].size
    assert_equal 2, table['G'].size    

    assert_equal 'a', table['S'].first.name
    assert       table['G'].find { |s| s.name == 'g' }
    assert       table['G'].find { |s| s.name == 'd' }    
  end


  def test_first_table_with_lambdas
    # type   -> simple ;
    # type   -> ^ id
    # type   -> array of type
    # simple -> integer
    # simple -> char
    # simple -> 'lambda'
    table = type_grammar.first_table
    
    assert_equal 5, table['Type'].size
    assert_equal 3, table['Simple'].size        
    
    assert       table['Type'].find { |s| s.name == 'semicolon' }
    assert       table['Type'].find { |s| s.name == 'hat' }
    assert       table['Type'].find { |s| s.name == 'array' }
    assert       table['Type'].find { |s| s.name == 'integer' }
    assert       table['Type'].find { |s| s.name == 'char' }
    
    assert       table['Simple'].find { |s| s.kind_of?(Lambda) }
    assert       table['Simple'].find { |s| s.name == 'integer' }
    assert       table['Simple'].find { |s| s.name == 'char' }
    
  end
  
  def test_for_symbol_sequence
    grammar = type_grammar
    table   = grammar.first_table


    # Symbol sequence: simple ;        
    result = table.for_symbol_sequence(grammar.rules[0].right)
    assert_equal 3, result.size
    assert       result.find { |s| s.name == 'integer' }
    assert       result.find { |s| s.name == 'char' }
    assert       result.find { |s| s.name == 'semicolon' }
  end
  
  def test_gen_if_table
    grammar = type_grammar
    table   = grammar.gen_if_table(type_grammar.first_table)
    
    # There are 6 productions
    assert_equal 6, table.size 

    # 0: type   -> simple ;
    assert_equal 3, table[grammar.rules[0]].size
    assert_equal createobj(NoTerminal, :name => 'Simple'), table[grammar.rules[0]]['integer']
    assert_equal createobj(NoTerminal, :name => 'Simple'), table[grammar.rules[0]]['char']
    assert_equal GenIfTable::EAT, table[grammar.rules[0]]['semicolon']

    # 1: type   -> ^ id
    assert_equal 1, table[grammar.rules[1]].size
    assert_equal GenIfTable::EAT, table[grammar.rules[1]]['hat']

    # 2: type   -> array of type
    assert_equal 1, table[grammar.rules[2]].size
    assert_equal GenIfTable::EAT, table[grammar.rules[2]]['array']

    # 3: simple -> integer
    assert_equal 1, table[grammar.rules[3]].size
    assert_equal GenIfTable::EAT, table[grammar.rules[3]]['integer']

    # 4: simple -> char
    assert_equal 1, table[grammar.rules[4]].size
    assert_equal GenIfTable::EAT, table[grammar.rules[4]]['char']
    
    # 5: simple -> 'lambda'
    assert_equal 0, table[grammar.rules[5]].size
  end
  
  def test_parser_generator
    grammar = type_grammar
    generator = RubyTL::BNF::ParserGeneratorLL.new(grammar)
    
    text = generator.generate

    assert text.include?("def parse_Type")
    assert text.include?("def parse_Simple")
    assert text.include?("add_rnode(parse_Simple, node); create_tnode(lexer.match('semicolon'), node)")
    # TODO: How to test the result of the text generation?

    evaluator = generator.evaluator(text)
    evaluator.evaluate(RubyTL::BNF::Lexer.new(grammar, "integer;"))
    evaluator.evaluate(RubyTL::BNF::Lexer.new(grammar, "array of array of char ;"))
    evaluator.evaluate(RubyTL::BNF::Lexer.new(grammar, ";"))

    # Test that parser create CST structure
    evaluator.evaluate(RubyTL::BNF::Lexer.new(grammar, "array of array of char ;"))
    assert_not_nil evaluator.tree
    
    assert_equal 1, evaluator.tree.root.size
    type1 = evaluator.tree.root.first
    
    assert_equal 3, type1.children.size
    assert_equal 'array', type1.children[0].kind
    assert_equal 'of', type1.children[1].kind
    assert_equal 'Type', type1.children[2].kind
    
    type2 = type1.children[2]
    assert_equal 3, type2.children.size
    assert_equal 'array', type1.children[0].kind
    assert_equal 'of', type1.children[1].kind
    assert_equal 'Type', type1.children[2].kind

    type3 = type2.children[2]
    assert_equal 2, type3.children.size
    assert_equal 'Simple', type3.children[0].kind
    assert_equal 'semicolon', type3.children[1].kind
    
    assert_equal 1, type3.children[0].children.size
    assert_equal 'char', type3.children[0].children.first.kind  
  end
    
end