require 'base_unit'
include RMOF


# Test model adapters.
#
# Unfortunately this test depends on ECore parsing to
# load metamodels. 
# TODO: Look for ways to define metamodels without parsing
#
class AdapterTest < Test::Unit::TestCase
  include TestMetamodels
  
  def test_recursive_uri
    adapter = RMOF::ECore::FileModelAdapter.new
    adapter.add_mapping('http://my_ecore', RMOF::ECore::FileModelAdapter::ECORE_FILE)
    adapter.add_mapping('http://logical/uri', '/tmp/afile')
    
    assert_equal File.expand_path(RMOF::ECore::FileModelAdapter::ECORE_FILE),
                 adapter.send(:resolve_uri_recursively, 'http://my_ecore').filename
    assert_equal File.expand_path('/tmp/afile'), adapter.send(:resolve_uri_recursively, 'http://logical/uri').filename
    assert_nil   adapter.send(:resolve_uri_recursively, 'http://it_does_not_exist')
    
    assert_equal '/tmp/cosa', adapter.send(:resolve_file_uri, 'file:///tmp/cosa').filename
  end
  
  def test_can_handle
    adapter = RMOF::ECore::FileModelAdapter.new
    assert adapter.can_handle?('http://www.eclipse.org/emf/2002/Ecore')
    assert_not_nil adapter.resolve_uri('http://www.eclipse.org/emf/2002/Ecore')
    
    setup_shop_metamodel
    adapter.add_loaded('/home/jesus/project/metamodels/Shop.ecore', @model)
    assert adapter.can_handle?('/home/jesus/project/metamodels/Shop.ecore')
    # assert_not_nil adapter.resolve_uri('/home/jesus/project/metamodels/Shop.ecore')
    # assert_equal @model, adapter.resolve_uri('/home/jesus/project/metamodels/Shop.ecore')
    # TODO: These assertions doesn't work. Improve resolve_uri 
  end
  
  def test_uri_in_win32
    # raise "TODO"
    # TODO: Try to use c:\ in some place...
  end
  
  def test_compute_relative_file_path
    adapter = RMOF::ECore::FileModelAdapter.new
    adapter.add_mapping('http://logical/uri', '/home/jesus/project/metamodels/TestMM.ecore')
    
    assert_equal 'metamodels/TestMM.ecore', adapter.compute_relative_path('http://logical/uri', '/home/jesus/project/my_model.xmi')
    assert_equal '../metamodels/TestMM.ecore', adapter.compute_relative_path('http://logical/uri', '/home/jesus/project/models/my_model.xmi')
    assert_equal nil, adapter.compute_relative_path('http://invalid_uri', '/home/jesus/file')

    # Attention: if a directory is given, the result may be weird...
    assert_equal 'jesus/project/metamodels/TestMM.ecore', adapter.compute_relative_path('http://logical/uri', '/home/jesus')
  end

  def test_compute_relative_file_path_with_loaded
    setup_shop_metamodel
      
    adapter = RMOF::ECore::FileModelAdapter.new
    adapter.add_loaded('/home/jesus/project/metamodels/Shop.ecore', @model)
  
    assert_equal 'metamodels/Shop.ecore', adapter.compute_relative_path(@model.uri, '/home/jesus/project/my_model.xmi')
    assert_equal '../metamodels/Shop.ecore', adapter.compute_relative_path(@model.uri, '/home/jesus/project/models/my_model.xmi')  
  end

end