$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require 'test/unit'
require 'rubytl'

TEST_ROOT = File.join(File.dirname(__FILE__))

# Load mocks
mocks_dir = File.join(File.dirname(__FILE__), "mocks")
Dir.entries(mocks_dir).each do |entry|
  require File.join(mocks_dir, entry) if entry =~ /rb$/
end

helpers_dir = File.join(File.dirname(__FILE__), "helpers")
Dir.entries(helpers_dir).each do |entry|
  require File.join(helpers_dir, entry) if entry =~ /rb$/
end

require File.join(File.dirname(__FILE__), "files", "files")

module RubyTL::CustomAssertions
  def assert_rubytl_exception(kind = RubyTL::Error.name)
    begin
      yield
    rescue => e
      klass = eval(kind)
      unless e.kind_of? klass
        puts $/
        puts e.backtrace
        fail("Expected #{kind} but #{e} was thrown")      
      end
      return
    end
    
    fail("No exception #{kind} raised")
  end
  
  require 'generator'
  def assert_tuples(expected, value)
    assert_equal expected.size, value.size

    ge = Generator.new(expected)
    gv = Generator.new(value)
    
    while ge.next?
      ve = ge.next
      vv = gv.next
      assert_equal ve.class, vv.class      
      assert_equal ve, vv
    end   
  end    
end

module RubyTL::ModelSetUps
protected
  def set_up_context
    RubyTL::TransformationContext.new
    #test_module = Module.new do
    #  extend RubyTL::ParameterHandling
    #  extend RubyTL::HelperLoading
    #  def self.transformation=(arg); end 
    #end  
  end
  
  def set_up_transformation
    test_module = set_up_context
    transformation = RubyTL::Transformation.new(test_module, set_up_repository)
    transformation
  end  
  
  def set_up_repository
    RubyTL::Repository.new(RubyTL::HandlerRMOF.new, TestURIResolver.new)
  end  

  def set_up_repository_rmof2
    RubyTL::Repository.new(RubyTL::HandlerRMOF2.new, TestURIResolver.new)
  end  
  
  def load_model_for_test(metamodel, model)
    repository = RubyTL::Repository.new(RubyTL::HandlerRMOF.new, TestURIResolver.new)    
    model_proxy = repository.model(model, metamodel)
  end
  
end

class Test::Unit::TestCase
  include RubyTL::CustomAssertions
  include RubyTL::ModelSetUps


  def packages(rubytl)
    return rubytl.sources[0].package, rubytl.targets[0].package
  end
  
  def metamodel(file)
    expand_file(file)
  end
  
  def model(file)
    expand_file(file)
  end
  
  def transformation(file)
    return expand_file(file) if file.include?('/')
    return expand_file(File.join('transformations', file))
  end

  def files_dir
    File.expand_path(File.join(File.dirname(__FILE__), 'files'))
  end

  def load_plugin_for_test(plugin)
    loader = RubyTL::PluginLoader.new
    loader.search_for_plugins
    loader.load_plugins([:default, plugin])
  end

private
  def expand_file(file)
    parts = file.split('/')      
    File.expand_path(File.join(files_dir, parts))
  end    
end

require 'ostruct'

class MockRecorder
  include Test::Unit::Assertions
  attr_reader :messages
  
  def initialize
    @expected = []
    yield(self) if block_given?
  end
  
  def record_mock(method_name, &block)
    mock = MockRecorder.new(&block)
    @expected << OpenStruct.new(:method_name => method_name,
                                :kind => :nested,
                                :result => mock)
  end

  def []=(method_name, value)
    @expected << OpenStruct.new(:method_name => method_name,
                                :kind => :normal,
                                :result => value)    
  end
  
  def method_missing(method, *args)
    if @expected.empty?
      flunk("Method #{method} not expected")
    end

    m = @expected.shift
    if m.method_name.to_s != method.to_s
      raise "Expected #{m.method_name} but got #{method}"
#      raise Test::Unit::AssertionFailedError.new("Expected #{m.method_name} but got #{method}")
#      flunk("Expected #{m.method_name} but got #{method}")
    end
    return m.result
  end
end

# A hack to resolve test:// uris
class String
  TEST_FILES = File.join(File.dirname(__FILE__), 'files')

  def to_repo
   f = self.sub('test://', '') 
   'file://' + File.join(TEST_FILES, f).windoze_uri  
  end
end