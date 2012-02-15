require 'rubytl_base_unit'

class MD_12_5_Test < Test::Unit::TestCase
  include RubyTL::UML2::Parsers

  def test_stereotypes
    adapter = RMOF::ECore::FileModelAdapter.new(RUBYTL_REPOSITORY)
    parser  = ParserMD_12_5.new(File.new(model_resource('modeling.mdxml').file_path), adapter)
    model   = parser.parse

    data = model.root_elements.first
    assert_equal 'Data', data.name

    reservation = data.ownedMember.select { |m| m.kind_of?(RubyTL::MD_12_5::Uml2::Package) }.
                                   find { |m| m.name = 'Reservation' }
    assert_not_nil reservation

    profile = reservation.packageImport.find { |m| m.kind_of?(RubyTL::MD_12_5::Uml2::ProfileApplication) }
    assert_not_nil profile
    assert_equal 'SimpleBusiness', profile.importedProfile.name
    
    obj = model.root_elements.last
    assert_not_nil obj
    assert RubyTL::MD_12_5::Uml2::Class == obj.base_Class.metaclass
    assert_equal 'MakeReservationPO', obj.base_Class.name 
  end

private
  def model_resource(name)
    RubyTL::Base::Resource.new(File.join(RubyTL::TestFiles::MODELS_ROOT, 'md_12_5', name))
  end
  
end