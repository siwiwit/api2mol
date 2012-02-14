module TestMetamodels

  #
  # == Main package
  # 
  #                          ------------
  #   -------------          |  Person  |
  #   | ShopModel |          ------------
  #   -------------              /_\   /_\
  #          o                    |      \ 
  #          |                    |       \----|
  #        -------- 1      * ------------    ------------    1  -------------------
  #        | Shop |----------| Employee |    | Customer |-----> | CustDescription |
  #        --------          ------------    ------------       -------------------
  #             |                  | boss      o
  #             |-------------------           |
  #               bossOf                       |
  #                                            |
  #    ---------        *  -------- *          | 
  #    | Order |o----------| Item |-------------           
  #    ---------     items --------   consideredItems
  #                         |   ^
  #            relatedItems ----|
  #
  # == Subpackage (ShopKinds)
  #  
  #              -------- _
  #              | Shop | \|-----------
  #              --------              \
  #            /_\                      \
  #            /                         \
  #   ----------------     1              ----------
  #   | Supermarket  |------------------> | Bakery |
  #   ----------------     bakerySection  ----------
  # 
  def setup_shop_metamodel
    # TODO: If I don't do this, test_serialize_shop_metamodel would fail if run isolated
    RMOF::ECore::FileModelAdapter.new.resolve_uri('http://www.eclipse.org/emf/2002/Ecore')
 
    package = ECore::EPackage.new(:name => 'ShopTest')
    package.nsURI = 'http://shop/metamodel'
    package.nsPrefix = 'shop'
        
        
    order    = ECore::EClass.new(:name => 'Order') do |order|
      order.eStructuralFeatures << ECore::EAttribute.new(:name => 'id', :eType => ECore::EInt)      
    end
    order.eSuperTypes << ECore::EModelElement

    item     = ECore::EClass.new(:name => 'Item') do |item|
      item.eStructuralFeatures << ECore::EAttribute.new(:name => 'name', :eType => ECore::EString)   
      item.eStructuralFeatures << ECore::EReference.new(:name => 'relatedItems', :eType => item, :upperBound => -1)   
      item.eStructuralFeatures << ECore::EAttribute.new(:name => 'numberOfItems', :eType => ECore::EInt, :defaultValue => 1)       
    end
    special_item = ECore::EClass.new(:name => 'SpecialItem') do |special_item|
      special_item.eSuperTypes << item
      special_item.eStructuralFeatures << ECore::EAttribute.new(:name => 'bonus', :eType => ECore::EInt)  
    end 
    person   = ECore::EClass.new(:name => 'Person', :abstract => true) do |person|
      person.eStructuralFeatures << ECore::EAttribute.new(:name => 'name', :eType => ECore::EString)
      person.eStructuralFeatures << ECore::EAttribute.new(:name => 'age', :eType => ECore::EInt)
    end
    employee = ECore::EClass.new(:name => 'Employee') do |employee|
      employee.eSuperTypes << person
    end 
    customer_description = ECore::EClass.new(:name => 'CustomerDescription') do |desc|
      desc.eStructuralFeatures << ECore::EAttribute.new(:name => 'value', :eType => ECore::EString)
    end
    customer = ECore::EClass.new(:name => 'Customer') do |customer|
      customer.eSuperTypes << person
      customer.eStructuralFeatures << ECore::EReference.new(:name => 'description', :upperBound => 1, 
                                                            :eType => customer_description, :containment => true)
    end 
    shop = ECore::EClass.new(:name => 'Shop') do |shop|
      shop.eStructuralFeatures << ECore::EAttribute.new(:name => 'name', :eType => ECore::EString, :iD => true)
    end
    address = ECore::EClass.new(:name => 'Address') do |address|
      address.eStructuralFeatures << ECore::EAttribute.new(:name => 'street', :eType => ECore::EString)
    end    
    shop.eStructuralFeatures << ECore::EReference.new(:name => 'address', :eType => address,
                                                      :upperBound => 1)  
  
    shop_has_employees = ECore::EReference.new(:name => 'employees', :upperBound => -1, :eType => employee)
    employee_has_a_job = ECore::EReference.new(:name => 'job', :upperBound => 1, :eType => shop)
    shop_has_employees.eOpposite = employee_has_a_job
    employee_has_a_job.eOpposite = shop_has_employees
    shop.eStructuralFeatures << shop_has_employees
    employee.eStructuralFeatures << employee_has_a_job

    # This is a redundant bidirectional relationship, just intended to test
    shop_has_a_boss = ECore::EReference.new(:name => 'boss', :upperBound => 1, :eType => employee)
    boss_of_shop    = ECore::EReference.new(:name => 'bossOf', :upperBound => 1, :eType => shop)

    shop_has_a_boss.eOpposite = boss_of_shop
    boss_of_shop.eOpposite = shop_has_a_boss
    shop.eStructuralFeatures << shop_has_a_boss
    employee.eStructuralFeatures << boss_of_shop
  
    # To test 1:N relationships without opposite and without containment
    # we can assume that a person has 1 or more addresses
    person.eStructuralFeatures << ECore::EReference.new(:name => 'addresses', :upperBound => -1, :eType => address)
 
    order_has_items = ECore::EReference.new(:name => 'items', :upperBound => -1, :eType => item)
    item_of_order   = ECore::EReference.new(:name => 'owner', :upperBound => 1, :eType => order)
    order_has_items.containment = true
    item_of_order.eOpposite = order_has_items
    order_has_items.eOpposite = item_of_order
    
    order.eStructuralFeatures << order_has_items
    item.eStructuralFeatures << item_of_order
     
    # Customer.consideredItems relationship
    consideredItems = ECore::EReference.new(:name => 'consideredItems', :upperBound => -1, :eType => item)
    consideredItems.containment = true
    customer.eStructuralFeatures << consideredItems

    # A top level element to aggregate them all
    shop_model = ECore::EClass.new(:name => 'ShopModel') do |model|
      model.eStructuralFeatures << ECore::EReference.new(:name => 'shops', :eType => shop, :upperBound => -1, :containment => true)
      model.eStructuralFeatures << ECore::EReference.new(:name => 'persons', :eType => person, :upperBound => -1, :containment => true)
    end

    [address, order, item, special_item, person, employee, customer, customer_description, shop, shop_model].each { |c| 
      package.eClassifiers << c
    }

    # Subpackage definition     
    subpackage = ECore::EPackage.new(:name => 'ShopKinds')
    subpackage.nsURI = 'http://shop/metamodel/shopkinds'
    subpackage.nsPrefix = 'shopkinds'

    bakery = ECore::EClass.new(:name => 'Bakery') do |bakery|
      bakery.eSuperTypes << shop
    end

    supermarket = ECore::EClass.new(:name => 'Supermarket') do |supermarket|
      supermarket.eSuperTypes << shop
    end 
    supermarket.eStructuralFeatures << bakRef = ECore::EReference.new(:name => 'bakerySection', :upperBound => 1,                                                             
                                            :eType => bakery, :containment => true)
    bakery.eStructuralFeatures << supRef = ECore::EReference.new(:name => 'owner', :upperBound => 1, :eType => supermarket, :containment => false)
    bakRef.eOpposite = supRef
    supRef.eOpposite = bakRef
        
    [bakery, supermarket].each do |c|
      subpackage.eClassifiers << c
    end
    package.eSubpackages << subpackage    
     
    @model = Model.new(package.nsURI, [package])
    @package, @shop, @address = package, shop, address
    @person, @employee = person, employee
    @item, @order, @customer, @customer_description = item, order, customer, customer_description
    @special_item, @shop_model = special_item, shop_model
    
    @subpackage = subpackage
    @supermarket, @bakery = supermarket, bakery
  end

  def setup_cross_reference_metamodel
    package = ECore::EPackage.new(:name => 'CrossReference')
    package.nsURI = 'http://cross/reference'
    package.nsPrefix = 'cross'

    root = ECore::EClass.new(:name => 'Root') do |order|
      order.eStructuralFeatures << ECore::EReference.new(:name => 'references', :eType => ECore::EObject, :upperBound => -1)
      order.eStructuralFeatures.last.containment = false

      order.eStructuralFeatures << ECore::EReference.new(:name => 'contained', :eType => ECore::EObject, :upperBound => -1)
      order.eStructuralFeatures.last.containment = true
    end

    [root].each { |c| 
      package.eClassifiers << c
    }

    @reference_metamodel = Model.new(package.nsURI, [package])
    @cross_references_root = root
  end


  def setup_datatypes_metamodel
    # TODO: If I don't do this, test_serialize_shop_metamodel would fail if run isolated
    RMOF::ECore::FileModelAdapter.new.resolve_uri('http://www.eclipse.org/emf/2002/Ecore')
 
    package = ECore::EPackage.new(:name => 'DataTypeTest')
    package.nsURI = 'http://test/datatypes'
    package.nsPrefix = 'datatypes'
        
    my_string = ECore::EDataType.new(:name => 'MyString') do |string|
      string.instanceClassName = 'java.lang.String'
    end
    my_integer = ECore::EDataType.new(:name => 'MyInteger') do |string|
      string.instanceClassName = 'java.lang.Integer'
    end

    
    sentence = ECore::EClass.new(:name => 'Sentence') do |sentence|
      sentence.eStructuralFeatures << ECore::EAttribute.new(:name => 'description', :eType => my_string, :upperBound => 1)
      sentence.eStructuralFeatures << ECore::EAttribute.new(:name => 'strings', :eType => my_string, :upperBound => -1)
      sentence.eStructuralFeatures << ECore::EAttribute.new(:name => 'numbers', :eType => my_integer, :upperBound => -1)
    end
    
    
    [my_string, my_integer, sentence].each do |c|
      package.eClassifiers << c
    end

    @datatypes_metamodel = Model.new(package.nsURI, [package])
    @sentence = sentence
  end
end

