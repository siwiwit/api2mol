require 'rubytl_base_unit'


class RuleTest < Test::Unit::TestCase
  include RubyTL::Rtl
  include RuleCreationHelper

  def setup
    @test_phase = PrimitivePhase.new('pphase')
    TestMetamodels.clean_all
  end

  def test_top_rule_execute_at_top_level_single_instance    
    top_rule = create_rule(TopRule)    
    top_rule.from_part = FromPart.new([TestMetamodels::Family::Man])
    top_rule.to_part   = ToPart.new([TestMetamodels::Tree::Node])  
    
    man1 = TestMetamodels::Family::Man.new
    man2 = TestMetamodels::Family::Man.new
    
    class << top_rule 
      attr_reader :results
      def apply(source, target)
        @results ||= []
        @results << target
      end
    end
    
    top_rule.execute_at_top_level     
        
    # Is trace propertly set?
    assert_equal top_rule.results[0], top_rule.status.transformed_by_source_using_rule(man1, top_rule)    
    assert_equal top_rule.results[1], top_rule.status.transformed_by_source_using_rule(man2, top_rule)        
  end

  def test_top_rule_execute_at_top_level_multiple_instance
    fail("TODO: test_top_rule_execute_at_top_level_multiple_instance")
  end

  def test_rule_pass_filter
    # Test single instances
    rule = DefaultRule.new(@test_phase, 'single_instance')
    rule.filter_part = FilterPart.new(Proc.new { |man| man.name == 'luis'})
    
    luis  = TestMetamodels::Family::Man.new(:name => 'luis')
    jesus = TestMetamodels::Family::Man.new(:name => 'jesus')
    
    assert rule.pass_filter?(luis)
    assert ! rule.pass_filter?(jesus)
    
    # With tuples
    rule = DefaultRule.new(@test_phase, 'with_tuples')
    rule.filter_part = FilterPart.new(Proc.new { |obj| ! obj.kind_of?(Tuple) })
    
    assert rule.pass_filter?(Tuple.new(luis))

    
    # Multiple instances
    rule = DefaultRule.new(@test_phase, 'multiple_instance')
    rule.filter_part = FilterPart.new(Proc.new { |man1, man2| man1.name == 'luis' && man2.name == 'jesus'})
    
    luis  = TestMetamodels::Family::Man.new(:name => 'luis')
    jesus = TestMetamodels::Family::Man.new(:name => 'jesus')
    
    assert rule.pass_filter?([luis, jesus])
    assert ! rule.pass_filter?([jesus, luis])    
  end
  
  def test_rule_create_and_link_no_binding
    rule = create_man2nodes_rule(DefaultRule)
    
    luis  = TestMetamodels::Family::Man.new(:name => 'luis')
    
    # Create a new element
    result = rule.create_and_link(luis)
    assert_equal 2, result.size
    assert       result[0].kind_of?(TestMetamodels::Tree::Node)
    assert       result[1].kind_of?(TestMetamodels::Tree::ExtendedNode)    
    rule.send(:register_already_transformed, luis, result)
    
    # Return the transformed element
    repeated_result = rule.create_and_link(luis)
    assert_equal 2, repeated_result.size
    assert_equal result, repeated_result
    
    # Is trace propertly set?
    assert_equal repeated_result, rule.status.transformed_by_source_using_rule(luis, rule)
  end
  
  def test_copy_rule_create_and_link_no_binding
    rule = create_man2nodes_rule(CopyRule)
    
    luis  = TestMetamodels::Family::Man.new(:name => 'luis')
    
    # Create a new element
    result = rule.create_and_link(luis)
    assert_equal 2, result.size
    assert       result[0].kind_of?(TestMetamodels::Tree::Node)
    assert       result[1].kind_of?(TestMetamodels::Tree::ExtendedNode)    
    
    # Return the transformed element
    repeated_result = rule.create_and_link(luis)
    assert_equal 2, result.size
    assert_not_equal  result, repeated_result    

    # Is trace propertly set?
    trace = rule.status.transformed_by_source_using_rule(luis, rule)
    assert_equal 4, trace.size
    assert trace.include?(result[0]) && trace.include?(result[1]) &&
           trace.include?(repeated_result[0]) && trace.include?(repeated_result[1]) 
  end
  
  def test_rule_conformance
    m_rule = create_man2single_node_rule(DefaultRule)
    w_rule = create_woman2single_node_rule(DefaultRule)
    
    man1 = TestMetamodels::Family::Man.new
    node = TestMetamodels::Tree::Node.new
    b = BindingAssignment.new(man1, node, 'subchilds')

    assert  m_rule.source_conforms_to?(TestMetamodels::Family::Man)
    assert  m_rule.target_conforms_to?(TestMetamodels::Tree::Node)

    assert_not_nil w_rule.conforms_to?(b)
    assert ! w_rule.conforms_to?(b)
    assert   m_rule.conforms_to?(b)
  
    # TODO: Test inheritance: is it really necessary? test conformance for each handler
  end
  
  def test_binding_assignment
    man1 = TestMetamodels::Family::Man.new
    man2 = TestMetamodels::Family::Man.new
    root = TestMetamodels::Tree::Root.new
    node = TestMetamodels::Tree::Node.new
    
    b = BindingAssignment.new(man1, root, 'childs')
    assert_equal man1, b.source_instance
    assert_equal root, b.target_instance
    assert       b.feature.kind_of?(TestMetamodels::MetaFeature)
    assert_equal 'childs', b.feature.name   
    assert_equal TestMetamodels::Tree::Node, b.feature.rumi_type 
    assert_equal TestMetamodels::Tree::Node, b.target_type
    assert_equal TestMetamodels::Family::Man, b.source_type    
    assert ! b.directly_assignable?
    
    b = BindingAssignment.new(node, root, 'childs')
    assert b.directly_assignable?    
  end
  
  def test_binding_assignment_enumerable
    man1 = TestMetamodels::Family::Man.new
    man2 = TestMetamodels::Family::Man.new
    man3 = TestMetamodels::Family::Man.new
    root = TestMetamodels::Tree::Root.new

    b = BindingAssignment.new([man1, man2, man3], root, 'childs')
    
    results = []
    b.homogenize_enumerable_binding do |single_binding|
      results << single_binding
    end
    
    assert_equal man1, results[0].source_instance
    assert_equal man2, results[1].source_instance
    assert_equal man3, results[2].source_instance

    results.each { |rb| assert_equal root, rb.target_instance }
    results.each { |rb| assert_equal 'childs', rb.feature.name }
  end
end