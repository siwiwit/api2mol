require 'rubytl_base_unit'


class ExtraTypesTest < Test::Unit::TestCase
  include RubyTL::Rtl

  def setup
  end

  def test_collection_creation
    seqMan   = Types::CollectionFactory.create_sequence(TestMetamodels::Family::Man)  
    seqWoman = Types::CollectionFactory.create_sequence(TestMetamodels::Family::Woman)  

    assert seqMan.kind_of?(Types::CollectionProxy)
    assert seqWoman.kind_of?(Types::CollectionProxy)
    
    seq1 = seqMan.new
    seq2 = seqWoman.new
    assert_equal TestMetamodels::Family::Man, seq1.metaclass.metaclass
    assert_equal TestMetamodels::Family::Woman, seq2.metaclass.metaclass
    
    seq1 << TestMetamodels::Family::Man.new
    seq1 << TestMetamodels::Family::Man.new
  
    assert_equal 2, seq1.size
    assert_equal 0, seq2.size
  end
  
  def test_collection_rumi_interface
    seqMan = Types::CollectionFactory.create_sequence(TestMetamodels::Family::Man) 
    
    assert   seqMan.rumi_conforms_to?(TestMetamodels::Family::Man)
    assert ! seqMan.rumi_conforms_to?(TestMetamodels::Family::Woman)
  end
  
end