require 'rubytl_base_unit'

class EUML_2_1_0 < Test::Unit::TestCase
  include RubyTL::UML2::Parsers

  def test_stereotypes
    adapter = RMOF::ECore::FileModelAdapter.new(RUBYTL_REPOSITORY)
    parser  = EUml2_1_0.new(File.new(model_resource('mymodel.uml').file_path), adapter)
    model   = parser.parse

    assert_equal 2, model.root_elements.size
    
    package = model.root_elements.first
    assert package.kind_of?(RubyTL::UML2_1_0::Uml::Package)
    assert_equal 'MyPackage', package.name
    
    myClass = package.packagedElement.first  
  
    stereo = model.root_elements[1]
    assert_equal myClass, stereo.base_Class
#puts stereo.metaclass.eReferences.first.name
#puts stereo.metaclass
#puts stereo.ownedAttribute   
    #assert_equal RubyTL::UML2_1_0::Uml::Stereotype, stereo.metaclass
  end

private
  def model_resource(name)
    RubyTL::Base::Resource.new(File.join(RubyTL::TestFiles::MODELS_ROOT, 'euml_2_1_0', name))
  end
  
end