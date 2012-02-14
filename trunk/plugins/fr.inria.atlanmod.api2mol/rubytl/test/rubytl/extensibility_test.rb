require 'rubytl_base_unit'


class ExtensibilityTest < Test::Unit::TestCase
  include RubyTL::Rtl

  # Test the extension object is properly set in all the containment hierarchy
  def test_extensible_transformation
    transformation   = Transformation.new('test_transformation')
    transformation.phases << CompositePhase.new('cphase')
    transformation.phases << pphase = PrimitivePhase.new('pphase')    
    drule = DefaultRule.new(pphase, 'drule')
    trule = TopRule.new(pphase, 'trule')
    crule = CopyRule.new(pphase, 'crule')

    extension_object = Object.new
    
    transformation.prepare(:extension => extension_object)    
    assert_equal extension_object, transformation.extension

    transformation.phases.each { |p| assert_equal extension_object, p.extension }
    pphase.rules { |r| assert_equal extension_object, r.extension }
  end
  
end