require 'rubytl_base_unit'

class PureVariantsTest < Test::Unit::TestCase
  include RubyTL

  def setup
    @config = RubyTL::Base::Configuration.new
  end

  def test_parse_consul_model_xsd
    parser = XSD::XSDParser.new(XML::ParserWrapper.new(File.new(File.join(XSD_MODELS, 'ConsulModel.xsd'))))
    schema = parser.parse
  end   

  def test_parse_feature_model
    parser = XSD::XSDParser.new(XML::ParserWrapper.new(File.new(File.join(XSD_MODELS, 'ConsulModel.xsd'))))
    schema = parser.parse
    
    parser = XSD::XMLParser.new(XML::ParserWrapper.new(File.new(TestFiles.test_xfm.file_path)), schema)
    tree = parser.parse
    
    relation = tree.root.elements.element.first.relations.first.relation.first
    target   = relation.target.first
    assert_not_nil target.value
  end   
  
  def test_pure_variants_handler
    handler = PureVariants::HandlerPureVariants.new(@config)
    
    assert    handler.support?(TestFiles.test_vdm_model)
    assert ! handler.support?(TestFiles.class_source_model)
    
    loaded_model = handler.load(TestFiles.test_vdm_model)
    
    assert loaded_model.kind_of?(Base::LoadedModel)
    proxy = loaded_model.proxy
    
    proxy.respond_to?(:TestMandatory)
    proxy.respond_to?(:TestOptional)  
    
    assert_equal false, proxy.TestMandatory.selected?  
    assert_equal true,  proxy.TestOptional.selected?
  end
   
   
end