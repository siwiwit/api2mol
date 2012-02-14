require 'rubytl_base_unit'


class EngineTest < Test::Unit::TestCase
  include RubyTL::Rtl
  include RuleCreationHelper

  RuleMock = Struct.new(:name)
  
  def setup
    TestMetamodels.clean_all
  end

  def test_phase_rule_integration_with_top_rule
    transformation = Transformation.new('my_transformation')
    transformation.phases << phase1 = PrimitivePhase.new('pphase1')
    top_rule = create_man2nodes_rule(TopRule, phase1)
    
    (1..3).each { TestMetamodels::Family::Man.new }
    
    transformation.start
    
    assert_equal 3, TestMetamodels::Tree::Node.all_objects.size
    assert_equal 3, TestMetamodels::Tree::ExtendedNode.all_objects.size    
  end

  def test_transformation_status_call_stack
    status = RubyTL::Rtl::TransformationStatus.new
    rule1 = Object.new
    rule2 = Object.new
    rule3 = Object.new
    
    status.push_rule(rule1)
    assert_equal rule1, status.stack.first
    assert_equal rule1, status.current_rule
    assert_equal 1, status.stack.size
    
    status.push_rule(rule2)
    assert_equal rule2, status.current_rule
    assert_equal 2, status.stack.size
    
    assert_equal rule2, status.pop_rule
    assert_equal rule1, status.current_rule
    assert_equal 1, status.stack.size
    
    status.push_rule(rule3) do
      assert_equal rule3, status.current_rule
      assert_equal 2, status.stack.size      
    end
    assert_equal rule1, status.current_rule
    assert_equal 1, status.stack.size
  end

  def test_status_trace       
    status = RubyTL::Rtl::TransformationStatus.new
    rule1, rule2 = RuleMock.new('rule1'), RuleMock.new('rule2')
    source1, source2 = Object.new, Object.new
    target1, target2, target3 = Object.new, Object.new, Object.new
    
    status.add_trace([source1], [target1], rule1)
    assert_equal [target1], status.transformed_by_source(source1)
    assert_equal [target1], status.transformed_by_source_using_rule(source1, rule1)

    status.add_trace([source1], [target2], rule2)
    assert_equal [target1, target2], status.transformed_by_source(source1)
    assert_equal [target1], status.transformed_by_source_using_rule(source1, rule1)
    assert_equal [target2], status.transformed_by_source_using_rule(source1, rule2)

    status.add_trace([source2], [target3], rule2)
    assert_equal [target3], status.transformed_by_source(source2)
    assert_equal [target3], status.transformed_by_source_using_rule(source2, rule2)
  end

  def test_status_change_phase
    status = RubyTL::Rtl::TransformationStatus.new
    phase1, phase2 = Object.new, Object.new
  
    status.change_phase(phase1) do
      assert_equal phase1, status.current_phase
      status.change_phase(phase2) do
        assert_equal phase2, status.current_phase
      end    
      assert_equal phase1, status.current_phase      
    end
  end

=begin
  # It test situations like table.columns = a_column is correctly
  # handled.
  def test_binding_assigment_with_the_same_type
    # raise "Not tested yet"
    # TODO:
  end  
  
  # The following extension points should exist in the algorithm 
  #
  #
  #
  def test_algorithm_extension_points
    # TODO:
  end
  
  def test_rule_extension_points
    # TODO:
  end
  
  def test_syntax_extension_points
    # TODO:
  end
=end

  
end