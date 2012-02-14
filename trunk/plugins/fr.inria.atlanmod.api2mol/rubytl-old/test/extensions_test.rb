require 'rubytl_base_unit'

class ExtensionTests < Test::Unit::TestCase
  def self.load_plugin_impl(file, mod)
    File.open(File.join(RUBYTL_ROOT, 'rubytl', 'extensions', file)) do |f|
      mod.module_eval(f.read, f.path)
    end  
  end

  load_plugin_impl('syntax_extensions.rb', self)
  
  def test_invalid_keywords
    assert_raise(Plugins::InvalidKeywordName) { Plugins::SyntaxExtension::Keyword.new('my-keyword') }
    assert_raise(Plugins::InvalidKeywordName) { Plugins::SyntaxExtension::Keyword.new('spaced keyword') }    
    assert_raise(Plugins::InvalidKeywordName) { Plugins::SyntaxExtension::Keyword.new('') }       
    # assert_raise(Plugins::InvalidKeywordName) { Plugins::SyntaxExtension::Keyword.new('Konstante') }       

    # Valid keyword
    Plugins::SyntaxExtension::Keyword.new(:phase)
  end

  def test_extensions_dsl_keywords
    keyword = Plugins::SyntaxExtension::Keyword.new('test_keyword')
    keyword.instance_eval do
      scope 'refinement_rule', 'copy_rule'
      nested_elements :mandatory
      parameters :name, :refine
      callback :amethod
    end
    
    assert_equal 'test_keyword', keyword.name_
    assert_equal :mandatory, keyword.nested_elements_
    assert_equal 'name, refine', keyword.parameters_
    assert_equal ['refinement_rule', 'copy_rule'], keyword.scope_
    # assert_equal ::Plugins::LazyBlock, keyword.callback_
  end
  
  def test_default_keyword_scope
    keyword = Plugins::SyntaxExtension::Keyword.new('test_keyword')
    assert_equal ['transformation'], keyword.scope_
  end 
  
  def test_extension_is_detected
    syntax_definition1 = Class.new(Plugins::SyntaxExtension)
    syntax_definition2 = Class.new(Plugins::SyntaxExtension)

    assert_equal 2, Plugins::SyntaxExtension.extensions.size
    assert       Plugins::SyntaxExtension.extensions.include?(syntax_definition1)
    assert       Plugins::SyntaxExtension.extensions.include?(syntax_definition2)
  end
  
  def test_invalid_nested_elements_options
    keyword = Plugins::SyntaxExtension::Keyword.new('test_keyword')
    assert_raise(Plugins::InvalidOption) {
      keyword.instance_eval do
        nested_elements :invalid_option
      end
    }
  end
  
  def test_keyword_implementation
    keyword = Plugins::SyntaxExtension::Keyword.new('my_keyword')
    keyword.instance_eval do
      # scope 'refinement_rule', 'copy_rule'
      nested_elements :mandatory
      parameters :name, '*args'
      callback :the_callback
    end  
    
    assert_equal 'def self.my_keyword(name, *args)', keyword.method_header
  end
  
  def test_calling_filters
    test_class = Class.new
    ExtensionTests.load_plugin_impl('hooking_and_filtering.rb', test_class)    
    test_class.module_eval %{
      extend Plugins::Filtering  
      include Plugins::HookFilterHelper  
      define_filter :test_filter
      
      append_test_filter_filter :resolver
      append_test_filter_filter :with_block do
        # Nothing
      end
    
      attr_reader :count  
      def resolver
        @count ||= 0
        @count += 1
      end
    }
    
    assert_equal 2, test_class.test_filter_filter.size
    
    instance = test_class.new
    instance.call_filter(instance, :test_filter)
    instance.call_filter(instance, :test_filter)
    assert_equal 2, instance.count
    
    test_class.module_eval %{
      remove_test_filter_filter :with_block
    }
    
    assert_equal 1, test_class.test_filter_filter.size
    
  end
  
end