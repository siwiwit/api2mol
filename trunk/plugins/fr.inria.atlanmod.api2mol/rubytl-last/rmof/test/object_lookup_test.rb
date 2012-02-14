require 'base_unit'
include RMOF

# This is for testing uri_fragments and this stuff
# 
class ObjectLookupTest < Test::Unit::TestCase
  include TestMetamodels
  # TODO: Test removing references

  # Test 1..1 relationship with containment
  def test_references_1_1_containment_compute_uri
    description = @customer_description.new_instance
    description.value = 'a description'

    assert_equal '#/', description.compute_uri_fragment

    customer = @customer.new_instance
    customer.description = description

    assert_equal '#/', customer.compute_uri_fragment

    model = Model.new('test://customer', [customer])
    
    assert_equal '#//@description', description.compute_uri_fragment
    assert_equal '@description', 
                 customer.uri_segment(@customer.property('description'), description)
  end

  # Test that 1:1 references have the form '@reference', instead of
  # 1:n references, that are '@reference.position'
  def test_references_1_1_lookup_object
    description = @customer_description.new_instance
    description.value = 'a description'
    customer = @customer.new_instance
    customer.description = description

    assert_equal description, customer.lookup_object('@description')
  end

  #def test_lookup_for_multiple_roots
  # TODO: See serializer test ...   
  #end

private
  def setup
    setup_shop_metamodel
  end

end
