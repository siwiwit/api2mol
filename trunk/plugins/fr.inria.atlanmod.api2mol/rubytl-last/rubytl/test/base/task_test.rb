require 'rubytl_base_unit'

class TaskTest < Test::Unit::TestCase
  class MockTastLib < RubyTL::Base::BaseTaskLib
    def define; end
    def as_resource(str)
      @config ||= RubyTL::Base::Configuration.new
      @config.workspace.create_resource(str)
    end    
  end
  
  def test_collect_actual_models    
    result = []
    task   = MockTastLib.new('test')
    
    model_def = {
      :namespaces => { 
        'Test1' => 'test1.ecore',
        'Test2' => 'test2.ecore'
      },
      :model => 'my_model.xmi'      
    }
    
    classic_model_def = {
      :package => 'PTest', 
      :metamodel => 'test.ecore',
      :model => 'my_model.xmi'
    }
    
    # Test classic model defs
    task.send(:actual_collect_models, classic_model_def, result = [])
    assert_equal 1, result.size
    assert result.first.kind_of?(RubyTL::Base::ModelInformation)
    assert_equal 'PTest', result.first.namespace
    
    # Test multimodels are properly created
    task.send(:actual_collect_models, model_def, result = [])
    assert_equal 1, result.size
    assert result.first.kind_of?(RubyTL::Base::MultiModelInformation)
    assert_equal 2, result.first.model_informations.size
    assert result.first.model_informations.any? { |m| m.namespace == 'Test1' }
    assert result.first.model_informations.any? { |m| m.namespace == 'Test2' }
    
    # Test namespaces / package conflict
    model_def.merge!({:package => 'Test'})
    begin
        task.send(:actual_collect_models, model_def, result)
        fail("No exception raised")
    rescue RubyTL::Base::ModelDefinitionError => e
      fail("No proper exception") if e.message != "Not allowed namespaces & namespace/package"
    end
  end
  
end