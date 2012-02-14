require 'rubytl_base_unit'

class ResourceTest < Test::Unit::TestCase
  include RubyTL::Base
  
  def test_resource_factory
    resource = Resource.new('C:\DOCUME~\Jesus\CONFIG~1\Temp\ruby2xmi14357.temp.rakefile')
    assert resource.kind_of?(FileResource)
    assert resource.is_local_resource?

    resource = Resource.new('C:\Data\EHU\Projects\08Austin\04.SourceCode\AGE\HarvestedGPL\models\base.rb')
    assert resource.kind_of?(FileResource)
    assert resource.is_local_resource?
    
    resource = Resource.new('http://gts.inf.um.es/myuri')
    assert resource.kind_of?(UriResource)
    assert resource.is_uri?
    assert 'http://gts.inf.um.es/myuri', resource.uri_string
    
    resource = Resource.new('platform:/plugin/gts.rubytl.jruby.emf/test/gts/rubytl/jruby/emf/data/Test.ecore')
    assert resource.kind_of?(UriResource)
    assert resource.is_uri?
    assert 'platform:/plugin/gts.rubytl.jruby.emf/test/gts/rubytl/jruby/emf/data/Test.ecore', resource.uri_string    
    
    resource = Resource.new('memory://mymodel')
    assert resource.kind_of?(MemoryResource)
    assert resource.is_uri?
    assert 'memory://mymodel', resource.uri_string

    resource = Resource.new('metamodels/algo.ecore')
    assert resource.kind_of?(FileResource)
    assert resource.is_local_resource?
    
    resource = Resource.new('metamodels\algo.ecore')
    assert resource.kind_of?(FileResource)
    assert resource.is_local_resource?
  end
  
  def test_file_resource_extension
    resource = Resource.new('/tmp/my.resource.ecore')
    assert_equal 'ecore', resource.file_extension

    resource = Resource.new('/tmp/noextension')
    assert_equal '', resource.file_extension
    
    resource = Resource.new('/tmp/stange..case')
    assert_equal 'case', resource.file_extension    
  end
  
  def test_file_path
    resource = Resource.new('/tmp/my.resource.ecore')
    assert_equal '/tmp/my.resource.ecore', resource.file_path

    resource = Resource.new('/tmp/../my.resource.ecore')
    assert_equal '/my.resource.ecore', resource.file_path
  end
  
  def test_workspace_creating_file_resources
    workspace = Workspace.new('/home/jesus/rubytl-test')
    resource = workspace.create_resource('metamodels/mymetamodel.ecore')  
    assert_equal '/home/jesus/rubytl-test/metamodels/mymetamodel.ecore', resource.file_path

    workspace = Workspace.new('/home/jesus/rubytl-test')
    resource = workspace.create_resource('/tmp/rakefile')    
    assert_equal '/tmp/rakefile', resource.file_path
  end
  
  def test_workspace_detects_absolute_paths_before_joining_in_windows
    workspace = Workspace.new('C:\\Documents and Settings\\Jesus')
    resource = workspace.create_resource('C:\DOCUME~\Jesus\CONFIG~1\Temp\ruby2xmi14357.temp.rakefile')
  
    assert_equal 'C:\DOCUME~\Jesus\CONFIG~1\Temp\ruby2xmi14357.temp.rakefile', resource.file_path
  end
  
  def test_helper_uris
    workspace = Workspace.new('/home/jesus/rubytl-test')
    resource = workspace.create_resource('helper://my_library')  
    
    assert resource.kind_of?(HelperResource)
    assert resource.is_local_resource?
    assert_equal '/home/jesus/rubytl-test/helpers/my_library.rb', resource.file_path
  end
  
end