require 'base_unit'
include RMOF

class ModelObjectTest < Test::Unit::TestCase
  include TestMetamodels
  # TODO: Test removing references

  def test_features_does_not_exist
    assert_raise(RMOF::FeatureNotExist) { @shop.new_instance.attribute_that_not_exist }
    assert_raise(RMOF::FeatureNotExist) { @shop.new_instance.attribute_that_not_exist = 'something' }
  end
  
  def test_inheritance
    item  = @item.new_instance
    special_item = @special_item.new_instance
    
    assert item.is_instance_of?(@item)
    assert special_item.is_instance_of?(@special_item)
    assert special_item.is_instance_of?(@item)    
  end
  
  def test_default_value
    item  = @item.new_instance    
    assert_equal 1, item.numberOfItems
    
    item2 = @item.new_instance(:numberOfItems => 3)
    assert_equal 3, item2.numberOfItems
  end
  
  def test_type_checking_for_references
    item  = @item.new_instance
    order = @order.new_instance
    
    # correct assignment
    item.owner = order
    
    # invalid assignment
    assert_raise(RMOF::TypeCheckError) { item.owner = @item.new_instance }    
  end
  
  def test_type_checking_for_multivalued_references
    item1  = @item.new_instance
    item2  = @item.new_instance
    order = @order.new_instance
    
    assert order.items.kind_of?(Array)
    order.set('items', item1)    
    assert order.items.kind_of?(Array)
    assert order.items.size == 1
    assert order.items.include?(item1)
    
    order.items = item2  
    assert order.items.kind_of?(Array)
    assert order.items.size == 2
    assert order.items.include?(item2)
  end
  
  def test_references_1_1_no_opposite
    test_shop = @shop.new_instance
    test_shop.name = 'Testing Articles'
    test_shop

    shop_address = @address.new_instance
    shop_address.street = 'Testing Street 5, 3'

    test_shop.address = shop_address
    
    assert_equal shop_address, test_shop.address
    assert_equal 'Testing Street 5, 3', test_shop.address.street
  end
  
  # Test 1..1 bidirectional relationships without containment
  def test_references_1_1_opposite_non_containment
    test_shop = @shop.new_instance
    test_shop.name = 'Testing Articles'
    boss = @employee.new_instance
  
    test_shop.boss = boss
    assert_equal boss, test_shop.boss 
    assert_equal test_shop, boss.bossOf
  end

  # Test 1..1 relationship with containment
  def test_references_1_1_containment
    description = @customer_description.new_instance
    description.value = 'a description'

    customer = @customer.new_instance
    customer.description = description
    
    assert_not_nil description.__container__
    assert_equal customer, description.__container__

    customer.description = nil
    assert description.__container__ == nil
  end

  # Test 1..1 relationship with opposite and containment 
  def test_references_1_1_opposite_and_containment
    supermarket = @supermarket.new_instance
    bakery      = @bakery.new_instance
    supermarket.bakerySection = bakery

    assert_equal bakery, supermarket.bakerySection
        
    assert_not_nil bakery.owner
    assert_not_nil bakery.__container__
    
    assert_equal supermarket, bakery.__container__
    assert_equal supermarket, bakery.owner
  end
  

  # Test 1..n bidirectional relationships without containment
  def test_references_1_n_opposite_non_containment
    test_shop = @shop.new_instance
    test_shop.name = 'Testing Articles'
    peter = @employee.new_instance
    maria = @employee.new_instance
    andy  = @employee.new_instance
    
    test_shop.employees << peter
    test_shop.employees << maria
    andy.job = test_shop
    
    # Test adding object
    assert test_shop.employees.class == RMOF::InverseResolvingList
    assert test_shop.employees.include?(peter)
    assert test_shop.employees.include?(maria)
    assert test_shop.employees.include?(andy)
    assert test_shop.employees.size == 3
    assert_equal test_shop, peter.job
    assert_equal test_shop, maria.job
    assert_equal test_shop, andy.job   
    
    # Test setting nulls
    peter.job = nil
    assert_nil peter.job
    assert     ! test_shop.employees.include?(peter)
  end

  # This is a regression test to catch the bug first seen when
  # the parse set the same value in one and in another.
  def test_setting_same_value_in_both_ends
    test_shop = @shop.new_instance
    test_shop.name = 'Testing Articles'

    john = @employee.new_instance
    test_shop.employees << john
    assert       test_shop.employees.include?(john)

    john.job = test_shop
    
    assert       test_shop.employees.include?(john)
    assert_equal test_shop, john.job
  end
  
  # Test 1..n non-bidirectional relationships
  def test_references_1_n_no_opposite
    address1 = @address.new_instance
    address2 = @address.new_instance
    person = @employee.new_instance
    person.addresses << address1
    person.addresses << address2
    
    assert person.addresses.include?(address1)
    assert person.addresses.include?(address2)    
  end 

  # Test a 1..n bidirectional containment association
  def test_references_1_n_containment
    order = @order.new_instance
    item1 = @item.new_instance
    item2 = @item.new_instance
    
    item1.owner = order
    order.items << item2

    assert order.items.include?(item1)
    assert order.items.include?(item2)
    assert_equal order, item1.owner
    assert_equal order, item2.owner    
    
    # Now, test that the container is properly changed
    # between object of the same classs
    another_order = @order.new_instance
    item1.owner = another_order
    
    assert   another_order.items.include?(item1)
    assert ! order.items.include?(item1)
    assert_equal another_order, item1.owner    
    
    # Since contained objects are implicity bidirectional
    # (because of the container), this should hold...
    item3 = @item.new_instance
    order.items << item3
    assert_equal order, item3.owner
    
    customer = @customer.new_instance
    customer.consideredItems << item3    
    
    assert customer.consideredItems.include?(item3)
    assert ! order.items.include?(item3)
    assert item3.owner != order
    assert item3.owner == nil    
    
    # Sets the container twice
    item4 = @item.new_instance
    item4.owner = order
    item4.owner = order
    
    assert_equal order, item4.owner
    assert order.items.include?(item4)
    assert_equal 1, order.items.select { |i| i == item4 }.size
  end

  def test_regression_container_variable_is_properly_set
    order = @order.new_instance
    item1 = @item.new_instance
    item2 = @item.new_instance
    
    item1.owner = order

    assert order == item1.__container__  
    assert_equal @order.getEStructuralFeature('items'), item1.__container_reference__
  end

  def test_structural_features_inheritance
    @item.all_structural_features.each do |feature|
      @special_item.all_structural_features.include?(feature)
    end
    
    # special_item, bonus is inherited
    special = @special_item.new_instance
    special.name  = 'a name'
    special.bonus = 200
    special.owner = @order.new_instance
    
    assert_equal 'a name', special.name
    assert_equal 200, special.bonus
  end

  def test_abstract_classes_are_not_instantiated
    # Whenever an abstract class is instantiated, an exception should be raised
    assert_raise(RMOF::AbstractClassCannotBeInstantiated) { @person.new_instance }
    assert_raise(RMOF::AbstractClassCannotBeInstantiated) { ECore::EModelElement.new }
  end

  def test_datatypes
    setup_datatypes_metamodel
    
    # Test multivalued datatypes
    sentence = @sentence.new_instance
    sentence.strings << 'this'
    sentence.strings << 'is'
    sentence.strings << 'a'
    sentence.strings << 'sentence'
  
    assert_equal 'this is a sentence', sentence.strings.join(' ')
  
    # TODO: Test errors when datatypes are incompatible
  end

private
  def setup
    setup_shop_metamodel
  end

end
