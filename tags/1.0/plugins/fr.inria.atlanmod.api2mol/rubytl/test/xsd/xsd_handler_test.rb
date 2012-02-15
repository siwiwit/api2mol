require 'rubytl_base_unit'

class XSDHandlerTest < Test::Unit::TestCase
  include RubyTL::XSD

  def setup
    
  end

  def test_xsd_handler
    handler = HandlerXSD.new(@config)
    model_information = RubyTL::TestFiles.ship_order_xml_model
    handler.send(:create_empty_proxy, model_information.metamodel) do |schema, proxy|
      ['shipordertype', 'stringtype', 'inttype', 'dectype', 'orderidtype', 
       'shiptotype', 'itemtype', 'shipordertype'].each do |name|
       
        assert_equal schema.typeDefinitions.find { |e| e.name == name }, eval("proxy::#{name.capitalize}.real_klass")
      end
    end
    
    loaded_model = handler.load(model_information)
    proxy = loaded_model.proxy
    
    assert_equal 1, proxy::Shipordertype.all_objects.size
    assert_equal 2, proxy::Itemtype.all_objects.size
    
    shiporder = proxy::Shipordertype.all_objects.first
    assert_not_nil shiporder.orderperson
    assert_equal 'John Smith', shiporder.orderperson
    
    shiporder.orderperson = 'Jesus'
    assert_equal 'Jesus', shiporder.orderperson
    # TODO: Test attributes
  end
  
  def test_xsd_rumi_interface
    ctype = RubyTL::Xsd::ComplexTypeDefinition.new
    ctype.name = 'MyComplexType'      
    
    element_def = RubyTL::Xsd::ElementDefinition.new
    element_def.typeDefinition = ctype
      
    assert_equal ctype, element_def.rumi_type

    # Test object-level proxy
    handler = HandlerXSD.new(@config)
    model_information = RubyTL::TestFiles.test_xml_model
    loaded_model = handler.load(model_information)
    proxy = loaded_model.proxy

    proxy::TestType.all_objects.each do |test|
      assert   test.kind_of?(proxy::TestType)
      assert   test.respond_to?(:methodName)
      assert ! test.respond_to?(:inexistent_property)
      
      assert   test.respond_to?(:id)      
    end
    
    proxy::TestType.all_objects.each do |test|
      assert 'test1' == test.get('id') ||
             'test2' == test.get('id')
    end
    
    test = proxy::TestType.new
    assert   test.respond_to?(:methodName)
    assert ! test.respond_to?(:inexistent_property)
    assert   test.respond_to?(:id)
    
    test.id = "thing"
    assert_equal 'thing', test.get('id')
    
    assert_equal 3, proxy::TestType.rumi_all_properties.size

  end
  
  
end