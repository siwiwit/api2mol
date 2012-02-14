require 'base_unit'
include RMOF

require 'rmof/meta/ecore/helper'

# Test if the simple ECore bootstrapping implementation of the
# ECore metamodel works as expected.
class ECoreBootstrapTest < Test::Unit::TestCase

  def test_epackage
    assert_equal [ECore::ENamedElement], ECore::EPackage.eSuperTypes
    %w{name nsURI nsPrefix eClassifiers}.each do |name|      
      assert ECore::EPackage.eAllStructuralFeatures.select { |e| e.name == name }.size == 1
    end
  
    epackage = ECore::EPackage.new
    epackage.name     = 'Relational'
    epackage.nsURI    = 'http://test.relational'
    epackage.set('nsPrefix', 'relational')
        
    assert_equal 'Relational', epackage.get('name')
    assert_equal 'http://test.relational', epackage.nsURI
    assert_equal 'relational', epackage.eGet(ECore::EPackage.getEStructuralFeature('nsPrefix'))

  end
  
  def test_eattribute 
    eattribute = ECore::EAttribute.new
    eattribute.eType = ECore::EString
    
    assert_equal eattribute.type, eattribute.eType
  end
  
  
  def test_containers_for_generated_metamodel
    reference = ECore::EPackage.all_references.first
    assert_equal ECore::EPackage, reference.eContainingClass
    assert_equal ECore, ECore::EPackage.ePackage    
  end
  
  def test_ePackage_inverse_relationship
    package = ECore::EPackage.new(:name => 'TestMetamodel')
    package.eClassifiers << test_class = ECore::EClass.new(:name => 'TestClass')
    
    assert_equal package, test_class.ePackage
  end

  def test_opposites_for_generated_ecore_metamodel
    test_package  = ECore::EPackage.new(:name => 'TestPackage')
    test_class    = ECore::EClass.new(:name => 'TestClass')
    another_class = ECore::EClass.new(:name => 'AnotherTestClass')

    test_package.eClassifiers << test_class
    test_class.eStructuralFeatures << feature = ECore::EAttribute.new(:name => 'testFeature', :eType => ECore::EInt)
    another_class.ePackage = test_package
    
    assert       test_package.eClassifiers.include?(test_class)
    assert_equal test_package, test_class.ePackage
    assert       test_class.eStructuralFeatures.include?(feature)
    assert_equal test_class, feature.eContainingClass
    assert       test_package.eClassifiers.include?(another_class)
    
    # Try to change the package of class
    other_package = ECore::EPackage.new(:name => 'OtherPackage')

    test_class.ePackage = other_package
    # other_package.eClassifiers << test_class

    assert        other_package.eClassifiers.include?(test_class)    
    assert       ! test_package.eClassifiers.include?(test_class)    
    assert_equal other_package, test_class.ePackage
  end

  def test_multivalued_reference_collections_are_created
    feature = ECore::EPackage.getEStructuralFeature('eClassifiers')
    assert feature.kind_of?(ECore::EReference)

    assert_not_nil ECore::EPackage.new.eSubpackages
    assert_not_nil ECore::EClass.new.eStructuralFeatures
  end
 
  def test_eIDAttribute
    klass = ECore::EClass.new(:name => 'TestClass')    
    klass.eStructuralFeatures << ECore::EAttribute.new(:name => 'an_attribute', :eType => ECore::EInt)
    klass.eStructuralFeatures << id1 = ECore::EAttribute.new(:name => 'id1', :eType => ECore::EString, :iD => true)
    klass.eStructuralFeatures << id2 = ECore::EAttribute.new(:name => 'id2', :eType => ECore::EInt, :iD => true)
    
    assert_equal true, id1.iD
    assert_equal true, id2.iD    
    assert_equal id1, klass.eIDAttribute
  end
  
  def test_object_lookup_for_generated_metamodels
    ecore = ECORE_METAMODEL.root_elements.first
    assert_not_nil ecore.lookup_object('EFeatureMapEntry')
    assert_not_nil ecore.lookup_object('EClass')
  end
end
