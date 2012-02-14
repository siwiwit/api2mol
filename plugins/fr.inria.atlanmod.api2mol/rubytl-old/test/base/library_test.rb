require 'rubytl_base_unit'

LIBRARY_DIR = File.join(RUBYTL_ROOT, 'library')
QUERY_FILE  = File.join(LIBRARY_DIR, 'util', 'query')

class LibraryTest < Test::Unit::TestCase
  include RubyTL
  include RubyTL::Base  
  include RubyTL::Mock

  def setup
    @config = RubyTL::Base::Configuration.new
  end

  def test_query    
    handler = SimpleRMOFHandler.new(@config)
    library_model = RubyTL::TestFiles.library_source_model
    result = handler.load(library_model, nil)    
    raise "TODO"
    assert_equal 'Library', result.proxy.package_name    
  end
  
  def test_java
    mod = Module.new
    mod.instance_eval @config.workspace.create_resource('library://gpl/java').read
    
    assert_equal 'ecoreFile', "ecore-file".to_var_naming_convention
    assert_equal 'ecoreFile', "ecore--file".to_var_naming_convention
    assert_equal 'ecoreFile', "ecore_file".to_var_naming_convention    
    assert_equal 'ecoreFile', "ecore__file".to_var_naming_convention
  end
end
