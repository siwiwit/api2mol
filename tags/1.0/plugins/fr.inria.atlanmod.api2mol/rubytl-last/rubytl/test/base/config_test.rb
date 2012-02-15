require 'rubytl_base_unit'

class ConfigTest < Test::Unit::TestCase
  include RubyTL::Base
  
  def test_add_uri_mapping    
    with_uri_mapping = Class.new do
      attr_reader :mapping
      def initialize(obj); end
      def add_mapping(mapping); @mapping = mapping; end
    end
    without_uri_mapping = Class.new do
      def initialize(obj); end
    end
    testConf = Class.new(Configuration)
    
    testConf.handler_klasses.clear
    testConf.handler_klasses << with_uri_mapping
    testConf.handler_klasses << without_uri_mapping 
        
    config = testConf.new
    config.add_uri_mapping("my_mapping")
    
    assert_equal "my_mapping", config.available_handlers.find { |a| a.kind_of?(with_uri_mapping) }.mapping
  end
  
end