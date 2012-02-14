require 'rubytl_base_unit'

# Test whether the parser is properly integrated with the
# model handler, so that it can be used in a transformation.
class EUML_2_1_0_Integration < Test::Unit::TestCase
  include RubyTL::UML2::Parsers
  include RubyTL::Base

  def test_load_uml_model
    handler = RubyTL::HandlerRMOF2.new(@config)
    model   = ModelInformation.new('UML2',
                                   Resource.new('http://www.eclipse.org/uml2/2.1.0/UML'),
                                   model_resource('mymodel.uml'))
    result  = handler.load(model)  
  end

private
  def model_resource(name)
    RubyTL::Base::Resource.new(File.join(RubyTL::TestFiles::MODELS_ROOT, 'euml_2_1_0', name))
  end
  
end