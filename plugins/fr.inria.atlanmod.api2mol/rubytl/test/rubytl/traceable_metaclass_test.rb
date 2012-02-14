require 'rubytl_base_unit'


class TraceableMetaclassTest < Test::Unit::TestCase
  include RubyTL::Rtl

  def setup
    TestMetamodels.clean_all
  end

  def test_traceable_do_not_conflict
    traceable = Class.new(TraceableMetaclass)
    traceable.proxy_for TestMetamodels::Family::Man
    
    # Test two or more traceables do not conflict
    traceable2 = Class.new(TraceableMetaclass)
    traceable2.proxy_for TestMetamodels::Family::Woman
    
    assert_nil TraceableMetaclass.proxy_for_get
    assert_equal TestMetamodels::Family::Man, traceable.proxy_for_get
    assert_equal TestMetamodels::Family::Woman, traceable2.proxy_for_get
  end

  def test_traceable_instances
    traceable = Class.new(TraceableMetaclass)
    traceable.proxy_for TestMetamodels::Family::Man

    man = traceable.new  
    man.name = 'homer'
    
    assert_equal 'homer', man.name
    assert_equal TestMetamodels::Family::Man, man.metaclass
    assert       man.kind_of?(TestMetamodels::Family::Man)
    assert       man.is_a?(TestMetamodels::Family::Man)
    assert     ! man.kind_of?(TestMetamodels::Family::Woman)
    
    TestMetamodels::Family::Man.new
    man2 = traceable.new  
    assert_equal 2, traceable.all_objects.size
  end

  def test_traceable_metaclass
    traceable = Class.new(TraceableMetaclass)
    traceable.proxy_for TestMetamodels::Tree::ExtendedNode

    assert       traceable.rumi_conforms_to?(TestMetamodels::Tree::Node)
    assert       traceable.rumi_conforms_to?(TestMetamodels::Tree::ExtendedNode)
  end
  
  def test_integration_with_rmof2
    handler = RubyTL::HandlerRMOF2.new(@config)
    memory_model = RubyTL::TestFiles.relational_target_model
    
    result = handler.new_model(memory_model)    

    traceable = Class.new(TraceableMetaclass)
    traceable.proxy_for result.proxy::Column
    
    table = result.proxy::Table.new
    table.cols << traceable.new
    table.cols << traceable.new
        
    assert_equal '#//@cols.0', table.cols.first.compute_uri_fragment
    assert_equal '#//@cols.1', table.cols.last.compute_uri_fragment    
  end

end