require 'rubytl_base_unit'


class AlgorithmTest < Test::Unit::TestCase
  include RubyTL::Rtl
  include RuleCreationHelper

  def setup
    @status = TransformationStatus.new
    @config = Preparable::Config.new(Algorithm, nil, @status)
    @test_phase = PrimitivePhase.new('test_pphase')
  end

  def test_entry_point_rules
    phase = PrimitivePhase.new('myphase')
    alg = Algorithm.new(phase, @config)
    alg.tlogger = TLogger.new(:stop)   

    # In-place mock for status
    class << @status
      attr_reader :changed_phase    
      def change_phase(phase)
        @changed_phase = phase
      end
    end
    
    alg.apply_entry_point_rules
    assert_equal phase, @status.changed_phase
  end

  def test_select_entry_point_rules
    phase = PrimitivePhase.new('myphase')
    alg = Algorithm.new(phase, @config)
    alg.tlogger = TLogger.new(:stop)   
     
    # Test empty transformation
    assert_raise(EmptyPhaseError) { alg.select_entry_point_rules }
    
    # Create three rules, no top_rule    
    rule1 = DefaultRule.new(phase, 'rule1')
    rule2 = DefaultRule.new(phase, 'rule2')
    rule3 = CopyRule.new(phase,    'rule3')
        
    selected = alg.select_entry_point_rules
    assert_equal [rule1], selected     

    # Create a top rule
    rule4 = TopRule.new(phase,    'rule4')
    selected = alg.select_entry_point_rules
    assert_equal [rule4], selected 

    # Create another top rule
    rule5 = TopRule.new(phase,    'rule5')
    selected = alg.select_entry_point_rules
    assert_equal [rule4 ,rule5], selected 
  end
  
  def test_conforming_rules
    alg = Algorithm.new(@test_phase, @config)
    alg.tlogger = TLogger.new(:stop)     
    m_rule = create_man2single_node_rule(DefaultRule)
    w_rule = create_woman2single_node_rule(DefaultRule)
    
    man1 = TestMetamodels::Family::Man.new
    node = TestMetamodels::Tree::Node.new
    b = BindingAssignment.new(man1, node, 'subchilds')
    
    assert_equal [m_rule], alg.select_conforming_rules(b, [w_rule, m_rule])
    assert_raise(RubyTL::Rtl::ConflictingRulesError) {
      alg.select_conforming_rules(b, [m_rule, w_rule, m_rule])
    }
  end

  def test_evaluate_available_rules  
    alg = Algorithm.new(@test_phase, @config)
    alg.tlogger = TLogger.new(:stop)     

    # Test rule creating one target element
    m_rule = create_man2single_node_rule(DefaultRule)
  
    man1 = TestMetamodels::Family::Man.new
    man2 = TestMetamodels::Family::Man.new
    node = TestMetamodels::Tree::Root.new
    b = BindingAssignment.new(man1, node, 'childs')

    alg.evaluate_available_rules(b, [m_rule])
    assert_equal 1, node.childs.size
        
    b = BindingAssignment.new(man2, node, 'childs')
    alg.evaluate_available_rules(b, [m_rule])
    assert_equal 2, node.childs.size
    
    # Test rule creating several target elements
    m_nodes_rule = create_man2nodes_rule(DefaultRule)
    node = TestMetamodels::Tree::Root.new    
    b = BindingAssignment.new(man1, node, 'childs')
    alg.evaluate_available_rules(b, [m_nodes_rule])
    
    assert_equal 2, node.childs.size
    assert_equal 1, node.childs.select { |n| n.class == TestMetamodels::Tree::Node }.size        
    assert_equal 1, node.childs.select { |n| n.class == TestMetamodels::Tree::ExtendedNode }.size
    
    # Test evaluating several rules together
    node = TestMetamodels::Tree::Root.new
    b = BindingAssignment.new(man1, node, 'childs')
    alg.evaluate_available_rules(b, [m_nodes_rule, m_rule])
    
    assert_equal 3, node.childs.size
    assert_equal 2, node.childs.select { |n| n.class == TestMetamodels::Tree::Node }.size        
    assert_equal 1, node.childs.select { |n| n.class == TestMetamodels::Tree::ExtendedNode }.size
  
    # Test no rules
    node = TestMetamodels::Tree::Root.new
    b = BindingAssignment.new(man1, node, 'childs')
    
    assert_raise(NoRuleFoundError) { alg.evaluate_available_rules(b, []) }
  end  

  def test_resolve_binding
    alg = Algorithm.new(@test_phase, @config)
    alg.tlogger = TLogger.new(:stop)     
    m_rule = create_man2single_node_rule(DefaultRule)
    w_rule = create_woman2single_node_rule(DefaultRule)

    man1 = TestMetamodels::Family::Man.new
    man2 = TestMetamodels::Family::Man.new
    node = TestMetamodels::Tree::Root.new
    b = BindingAssignment.new(man1, node, 'childs')

    alg.resolve_binding(b)    
    assert_equal 1, node.childs.size    
  end  

  
end