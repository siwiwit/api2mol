require 'rubytl_base_unit'

class RMOFHandlerTest < Test::Unit::TestCase
  include RubyTL
  include RubyTL::Base  
  include RubyTL::Mock
  include ECoreTestMetamodels

  def setup
    @config = RubyTL::Base::Configuration.new
#    @model_info_1 = ModelInformation.new('MM1', Resource.new('/tmp/mm.ecore'), Resource.new('/tmp/m.xmi'))
#    @model_info_2 = ModelInformation.new('MM2', Resource.new('http://uri.not/registered'), Resource.new('/tmp/m.xmi'))
#    @model_info_ecore = ModelInformation.new('MM2', Resource.new('http://www.eclipse.org/emf/2002/Ecore'), Resource.new('/tmp/result.ecore'))

    setup_simple_classifiers_metamodel    
    @empty_model             = RMOF::Model.new('test', [])
    @strategy_provider       = RubyTL::Base::StrategyProvider.new
    @builder_for_empty_model = RubyTL::Base::RmofProxyBuilder.new([RubyTL::Base::NamespaceMetamodelBinding.new('Simple', @simple_metamodel)], 
                                                                  @empty_model, @strategy_provider)  
  end

  def test_support
    model_info_1 = ModelInformation.new('MM1', Resource.new('/tmp/mm.ecore'), Resource.new('/tmp/m.xmi'))
    model_info_2 = ModelInformation.new('MM2', Resource.new('http://uri.not/registered'), Resource.new('/tmp/m.xmi'))
    model_info_ecore = ModelInformation.new('MM2', Resource.new('http://www.eclipse.org/emf/2002/Ecore'), Resource.new('/tmp/result.ecore'))
        
    handler = SimpleRMOFHandler.new(@config)
    
    assert handler.support?(model_info_1)    
    assert ! handler.support?(model_info_2)    
    assert handler.support?(model_info_ecore)
    
    multi1       = MultiModelInformation.new(Resource.new('/tmp/test.xmi'))
    multi1.model_informations << model_info_1
    multi1.model_informations << model_info_ecore
    
    multi2       = MultiModelInformation.new(Resource.new('/tmp/test.xmi'))
    multi2.model_informations << model_info_1
    multi2.model_informations << model_info_2
        
    assert   handler.support?(multi1)    
    assert ! handler.support?(multi2)
  end
  
  
  def test_build_metamodel_empty_proxy
    result = @builder_for_empty_model.empty_proxy
    
    assert_not_nil result
    assert_equal 1, result.proxys.size
    assert_equal 5, result.proxys.first.classifiers.size
  end
  
  def test_object_instantiation
    metaclass = @simple_metamodel_Root
    proxy     = RubyTL::Base::MetaclassProxy.new(metaclass)

    obj = proxy.new
    assert obj.kind_of?(RMOF::ModelObject)
    assert_equal 1, proxy.all_objects.size
  end
  
  def test_all_objects
    test_source = lambda { |assertions|
      obj     = RMOF::ModelObject.new(@simple_metamodel_B)
      model   = RMOF::Model.new('test', [obj])
      model.objects << obj
      builder = RubyTL::Base::RmofProxyBuilder.new([RubyTL::Base::NamespaceMetamodelBinding.new('NB', @simple_metamodel)], 
                                                   model, @strategy_provider)  
       
      builder_result = builder.filled_proxy
      assert_equal 1, builder_result.proxys.size
      proxy = builder_result.proxys.first
      
      assertions.call(proxy, "test target")
    }
    
    test_target = lambda { |assertions| 
      builder_result = @builder_for_empty_model.empty_proxy
      assert_equal 1, builder_result.proxys.size
      
      proxy = builder_result.proxys.first
      obj = proxy::B.new
      assertions.call(proxy, "test target")
    }
    
    assertions = lambda { |proxy, msg|    
      assert_equal 1, proxy::A.all_objects.size, msg 
      assert_equal 1, proxy::B.all_objects.size, msg
    }

    test_source.call(assertions)
    test_target.call(assertions)
  end
  
  def test_all_objects_across_packages
    fail("TODO")
  end
  
  def test_all_objects_across_referenced_packages
    fail("TODO")
  end

  def test_rumi_support_at_metamodel_level
    eclass = ECore::EClass.new
    eclass.name = 'MyEClass'
  
    eref = ECore::EReference.new
    eref.eType = eclass
    
    assert_equal eclass, eref.rumi_type    
  end
  
  def test_rumi_support_at_model_level_creation
    setup_class_metamodel
    strategy_provider = RubyTL::Base::StrategyProvider.new
    strategy_provider.adapting_strategies << RubyTL::Base::AdaptToRUMI.new
    classifier = RubyTL::Base::MetaclassProxy.new(@class_Classifier, strategy_provider)
    ptype      = RubyTL::Base::MetaclassProxy.new(@class_PType, strategy_provider)
    klass      = RubyTL::Base::MetaclassProxy.new(@class_Class, strategy_provider)
        
    obj_ptype = ptype.new
    assert   obj_ptype.kind_of?(ptype)      
    assert   obj_ptype.respond_to?(:name)
    assert ! obj_ptype.respond_to?(:inexistent_property)
        
    assert_equal 2, klass.rumi_all_properties.size
  end
    
  def test_different_model_ids_strategy
    # This will be implemented as an strategy to give optionality
    fail("TODO")
  end
    
  def test_decorator_in_source_model
    fail("TODO: Test overriding conflicts")
  end
  
  def test_decorator_in_target_model
    setup_class_metamodel
    empty_model             = RMOF::Model.new('test', [])
    strategy_provider       = RubyTL::Base::StrategyProvider.new
    builder_for_empty_model = RubyTL::Base::RmofProxyBuilder.new([RubyTL::Base::NamespaceMetamodelBinding.new('ClassM', @class_metamodel)], empty_model, strategy_provider)  
    result = builder_for_empty_model.empty_proxy
   
    proxy = result.proxys.first
    
    proxy::Classifier.decorate(Proc.new do
      def test_decorate_in_classifier
        "ok"
      end
    end)

    # This decorator is introduced to test whether it conflicts with subclasses
    # when overriding.
    proxy::NamedElement.decorate(Proc.new do
      def test_decorate_in_classifier
        "bad"
      end
    end)        
    
    proxy::Class.decorate(Proc.new do
      def test_decorate_in_class
        "ok"
      end

      def test_decorate_in_classifier
        "class ok"
      end
    end)

    assert_equal "ok", proxy::Class.new.test_decorate_in_class
    assert_raise(RMOF::FeatureNotExist) {
      proxy::PrimitiveType.new.test_decorate_in_class
    }

    assert_equal "ok", proxy::PrimitiveType.new.test_decorate_in_classifier
    assert_equal "class ok", proxy::Class.new.test_decorate_in_classifier  
    
    # Test that decorators are added in cross-referenced classes
  end    
private
  def create_empty_proxy
    
  end
end
