require 'base_unit'
require 'stringio'
include RMOF


# Test parsing of ecore files.
class SerializerTest < Test::Unit::TestCase
  include TestMetamodels

  def setup
    @test_io = $stderr
    # @test_io = StringIO.new
  end

  def test_attribute_serialization
    package = ECore::EPackage.new(:name => 'TestMetamodel')

    package.nsURI = 'http://www.example.com/TestMetamodel'
    package.nsPrefix = 'testMetamodel'
    model = Model.new(package.nsURI, [package])
    
    serializer = RMOF::ECore::Serializer.new(model)
    serializer.serialize(@test_io)
    
    xml = serializer.instance_variable_get('@result')
    # TODO: Better test
  end
  
  def test_containment_reference_serialization
    package = ECore::EPackage.new(:name => 'TestMetamodel')
    package.nsURI = 'http://www.example.com/TestMetamodel'
    package.nsPrefix = 'testMetamodel'    
    package.eClassifiers << ECore::EClass.new(:name => 'TestClass')
    package.eClassifiers << ECore::EClass.new(:name => 'TestCase')   
    
    model = Model.new(package.nsURI, [package])

    serializer = RMOF::ECore::Serializer.new(model)
    xml_document = serializer.serialize(@test_io)
    
    # Is package properly serialized?
    results = REXML::XPath.match(xml_document, '/ecore:EPackage')
    package_element = results.first
    
    assert_equal 1, results.size
    assert_equal 'TestMetamodel', package_element.attributes['name']
    assert_equal 'testMetamodel', package_element.attributes['nsPrefix']
    assert_equal 'http://www.eclipse.org/emf/2002/Ecore', package_element.attributes['xmlns:ecore']
    assert_equal 'http://www.example.com/TestMetamodel', package_element.attributes['nsURI']

    # Is classifier properly serialized?
    results = REXML::XPath.match(xml_document, '/ecore:EPackage/eClassifiers')
    test_class = results[0]
    test_case  = results[1]
    
    assert_equal 2, results.size
    assert_equal 'TestClass', test_class.attributes['name']
    assert_equal 'ecore:EClass', test_class.attributes['xsi:type']

    assert_equal 'TestCase', test_case.attributes['name']
    assert_equal 'ecore:EClass', test_case.attributes['xsi:type']
  end
  
  def test_serialize_shop_metamodel
    setup_shop_metamodel
    
    serializer = RMOF::ECore::Serializer.new(@model)
    xml_document = serializer.serialize(@test_io)

    results = REXML::XPath.match(xml_document, "/ecore:EPackage/eClassifiers/eStructuralFeatures[@name='items']")
    items_reference = results.first
    assert_equal 1, results.size
    assert_equal '#//Item/owner', items_reference.attributes['eOpposite']
    assert_equal '#//Item', items_reference.attributes['eType']

    results = REXML::XPath.match(xml_document, "/ecore:EPackage/eClassifiers[@name='Order']")
    order_eclass = results.first
    assert_equal 1, results.size
    assert       order_eclass.attributes['ePackage'].nil?
    assert_equal "ecore:EDataType http://www.eclipse.org/emf/2002/Ecore#//EInt", REXML::XPath.match(order_eclass, "eStructuralFeatures[@name='id']").first.attributes['eType']

    # Test subpackages generations
    results = REXML::XPath.match(xml_document, "/ecore:EPackage/eSubpackages[@name='ShopKinds']/eClassifiers")
    assert_equal 2, results.size
  end
  
  # Test the serialization of a model that use containment
  # references to model a item - order relationship.
  def test_serialize_orders_containment
    setup_shop_metamodel
    
    order = @order.new_instance
    order.id = '347'
    order.items << @item.new_instance(:name => 'Item1')
    order.items << @item.new_instance(:name => 'Item2')
    order.items << @special_item.new_instance(:name => 'Item3', :bonus => 10)

    model = Model.new('http://test/shop', [order])

    serializer = RMOF::ECore::Serializer.new(model)
    xml_document = serializer.serialize(@test_io)

    # Test root element
    results = REXML::XPath.match(xml_document, '/shop:Order')
    root = results.first    
    assert_equal 1, results.size
    assert_equal '347', root.attributes['id']
    assert_equal @package.nsURI, root.attributes["xmlns:#{@package.nsPrefix}"]

    results = REXML::XPath.match(xml_document, '/shop:Order/items')
    assert_equal 3, results.size
    assert results[0..1].all? { |r| r.attributes.size == 1 }  
    assert_equal 'Item1', results[0].attributes['name']
    assert_equal 'Item2', results[1].attributes['name']
    assert_equal 'Item3', results[2].attributes['name']
    assert_equal 'shop:SpecialItem', results[2].attributes['xsi:type']
  end

  
  # Test serialization of a model based on a metamodel dynamically created 
  # using non-containment references
  def test_serialize_employees_non_containment
    setup_shop_metamodel
    
    shop_model = @shop_model.new_instance
    test_shop = @shop.new_instance
    test_shop.name = 'Testing Stuff'
    test_shop.employees << marco  = @employee.new_instance(:name => 'Marco',  :age => 32)
    test_shop.employees << helena = @employee.new_instance(:name => 'Helena', :age => 29)
    shop_model.shops << test_shop
    shop_model.persons << marco
    shop_model.persons << helena

    model = Model.new('http://test/shop', [shop_model])

    serializer = RMOF::ECore::Serializer.new(model)
    xml_document = serializer.serialize(@test_io)

    # Test root element
    results = REXML::XPath.match(xml_document, '/shop:ShopModel')
    root = results.first    
    assert_equal 1, results.size
    assert_equal @package.nsURI, root.attributes["xmlns:#{@package.nsPrefix}"]

    results = REXML::XPath.match(root, 'persons')
    person1 = results[0]
    person2 = results[1]
    assert_equal 2, results.size
    assert_equal 'Testing Stuff', person1.attributes['job']
    assert_equal 'Testing Stuff', person2.attributes['job']
  
    results = REXML::XPath.match(root, 'shops')
    shop = results.first
    assert_equal 1, results.size
    assert_equal '#//@persons.0 #//@persons.1', shop.attributes['employees']
  end

  # Test multiple root elements are serialized using an XMI tag
  #
  def test_serialize_multiple_root_elements
    setup_shop_metamodel
    
    order1 = @order.new_instance
    order1.id = 'Order1'
    order1.items << @item.new_instance(:name => 'Item1_order1')
    order1.items << @item.new_instance(:name => 'Item2_order1') 

    order2 = @order.new_instance
    order2.id = 'Order2'

    order3 = @order.new_instance
    order3.id = 'Order3'
    order3.items << @item.new_instance(:name => 'Item1_order3') 

    order3.items.last.relatedItems << order1.items.last

    model = Model.new('http://test/shop', [order1, order2, order3])

    serializer = RMOF::ECore::Serializer.new(model)
    xml_document = serializer.serialize(@test_io)

    # Test root element
    results = REXML::XPath.match(xml_document, '/xmi:XMI/shop:Order')
    assert_equal 3, results.size
    
    item_xml = REXML::XPath.match(xml_document, '/xmi:XMI/shop:Order/items[@relatedItems]')    
    assert_equal 1, item_xml.size
    relatedItemPath = item_xml.first.attributes['relatedItems']
    
    assert_equal '#/0/@items.1', relatedItemPath
  end

  def test_serialize_cross_references_multiple_roots
    setup_cross_reference_metamodel
    setup_shop_metamodel
    
    order1 = @order.new_instance
    order1.id = 'Order1'
    order1.items << @item.new_instance(:name => 'Item1_order1')
    order1.items << @item.new_instance(:name => 'Item2_order1') 
    order2 = @order.new_instance
    model = Model.new('http://test/shop', [order1, order2])      
    
    root = @cross_references_root.new_instance
    root.references << order1
    root.references << order2
    referenced_model = Model.new('http://references', [root])
    
    serializer = RMOF::ECore::Serializer.new(referenced_model)
    xml_document = serializer.serialize(@test_io)    
    
    fail("Not implemented")
  end

  def test_serialize_cross_references_one_root
    setup_cross_reference_metamodel
    setup_shop_metamodel
    
    order1 = @order.new_instance
    order1.id = 'Order1'
    order1.items << @item.new_instance(:name => 'Item1_order1')
    order1.items << @item.new_instance(:name => 'Item2_order1') 
    model = Model.new('http://test/shop', [order1])      
    
    root = @cross_references_root.new_instance
    root.references << order1
    root.references << order1.items[1]
    referenced_model = Model.new('http://references', [root])
    
    serializer = RMOF::ECore::Serializer.new(referenced_model)
    xml_document = serializer.serialize(@test_io)    
    
    results = REXML::XPath.match(xml_document, '/cross:Root/references')
    assert_equal 2, results.size
    assert_equal 'http://test/shop#/', results[0].attributes['href']
    assert_equal 'http://test/shop#//@items.1', results[1].attributes['href']
  end
  
  # Test serialization of xsi:schemaLocation for contained objects 
  # whose metaclass belongs to a referenced metamodel
  def test_serialize_cross_references_contained
    setup_cross_reference_metamodel
    setup_shop_metamodel
    
    # Instances of the main package
    order1 = @order.new_instance
    order1.id = 'order1'
    order2 = @order.new_instance
    order2.id = 'order2'
    # Instances of a subpackage
    supermarket = @supermarket.new_instance
    bakery = @bakery.new_instance
    
    root = @cross_references_root.new_instance
    root.contained << order1
    root.contained << order2
    root.contained << supermarket
    root.contained << bakery
    referenced_model = Model.new('http://references', [root])
    
    adapter = RMOF::ECore::FileModelAdapter.new
    adapter.add_mapping('http://shop/metamodel', '/some_project/metamodels/Shop.ecore')
    serializer = RMOF::ECore::Serializer.new(referenced_model, adapter)
    def @test_io.path; '/some_project/models/test.xmi'; end
    xml_document = serializer.serialize(@test_io)    
    
    results = REXML::XPath.match(xml_document, '/cross:Root/contained')
    assert_equal 4, results.size
    assert_equal 'shop:Order', results[0].attributes['xsi:type']
    assert_equal 'shop:Order', results[1].attributes['xsi:type']
    assert_equal 'shopkinds:Supermarket', results[2].attributes['xsi:type']
    assert_equal 'shopkinds:Bakery', results[3].attributes['xsi:type']
    
    assert_equal 'http://shop/metamodel', 
                 xml_document.root.attributes['xmlns:shop']                    
    assert_equal 'http://shop/metamodel/shopkinds', 
                 xml_document.root.attributes['xmlns:shopkinds']

    assert xml_document.root.attributes['xsi:schemaLocation'].include?('http://shop/metamodel')
    assert xml_document.root.attributes['xsi:schemaLocation'].include?('../metamodels/Shop.ecore')
    assert xml_document.root.attributes['xsi:schemaLocation'].include?('http://shop/metamodel/shopkinds')
    assert xml_document.root.attributes['xsi:schemaLocation'].include?('../metamodels/Shop.ecore#//ShopKinds')
  end
  
  def test_multivalued_datatypes
    setup_datatypes_metamodel
    
    # Test multivalued datatypes
    sentence = @sentence.new_instance
    sentence.strings << 'this'
    sentence.strings << 'is'
    sentence.strings << 'a'
    sentence.strings << 'sentence'
    
    sentence.numbers << 0
    sentence.numbers << 5
    sentence.numbers << 10    
    
    sentence.description = 'This is a description'
    
    datatypes_model = Model.new('http://references', [sentence])

    adapter = RMOF::ECore::FileModelAdapter.new
    serializer = RMOF::ECore::Serializer.new(datatypes_model, adapter)
    xml_document = serializer.serialize(@test_io)    

    results = REXML::XPath.match(xml_document, '/datatypes:Sentence')
    assert_equal 1, results.size
    assert_equal 'This is a description', results.first.attributes['description']
  
    results = REXML::XPath.match(xml_document, '/datatypes:Sentence/strings')
    assert_equal 4, results.size

    results = REXML::XPath.match(xml_document, '/datatypes:Sentence/numbers')
    assert_equal 3, results.size
  end
  
  # TODO: Test xsi:type with subpackages...
end