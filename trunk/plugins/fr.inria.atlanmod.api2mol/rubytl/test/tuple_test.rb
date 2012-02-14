require 'rubytl_base_unit'

class TupleTest < Test::Unit::TestCase

  # Test the tuple constructor
  def test_tuple_constructor
    tuple1 = Tuple.new(1, 2, 3)
    tuple2 = Tuple[1, 2, 3]
    
    (0..2).each do |x| 
      assert tuple1[x] == tuple2[x]
    end
  end
  
  # Test what happens if trying to access an element whose index
  # is out of range.
  def test_out_of_range
    tuple = Tuple.new('x', 'y')

    assert_equal 'x', tuple[0]
    assert_equal 'y', tuple[1]
    assert_raise(Tuple::OutOfRange) { tuple[-1] }
    assert_raise(Tuple::OutOfRange) { tuple[2] }
    assert_raise(Tuple::OutOfRange) { tuple[1000] }    
  end
  
  # Test tuple flattening  
  def test_flatten
    assert_equal [1, 2, 3, 4, 5, 6, 7], 
                 Tuple[1, 2, Tuple[3, 4, 5], Tuple[Tuple[6, 7]]].flatten.values    
    assert_equal [], 
                 Tuple[].flatten.values
    assert_equal ['a'], 
                 Tuple['a'].flatten.values                
    assert_equal [1, 2, 3], 
                 Tuple[Tuple[], Tuple[1, 2, 3]].flatten.values                
  end
  
  
  # Test tuple equality properties: two tuples are equal if their flattening
  # is the same
  def test_equality
    assert_equal     Tuple[1, 2, 3], Tuple[1, 2, 3]
    assert_not_equal Tuple[1, 2, 3], Tuple[3, 2, 1]
    assert_equal     Tuple[1, 2, 3], Tuple[1, Tuple[2, 3]]
    assert_equal     Tuple[[1, 2], 3], Tuple[1, Tuple[2, 3]]    
  end
  
  # Test if the type of tuples is correct.
  def test_tuple_type
    assert_equal    Tuple[Fixnum, Fixnum, Fixnum], Tuple[1, 2, 3].tuple_type
    assert_equal    Tuple[Fixnum, Fixnum, String], Tuple[1, 2, 'a'].tuple_type    
    assert_equal    Tuple[Class, Class], Tuple[Fixnum, String].tuple_type        
    assert_equal    Tuple[4, 5].tuple_type, Tuple[1, 2].tuple_type
  end
  
  # Test that two tuples that are equal should be the same key
  # when used in a hash.
  def test_tuples_in_hash
    hash   = Hash.new
    tuple1 = Tuple[1, 2, 3]
    tuple2 = Tuple[1, 2, 3]
    hash[tuple1] = true
    
    assert_equal tuple1.hash, tuple2.hash
    assert       tuple1.eql?(tuple2)
    assert       tuple2.eql?(tuple1)
    assert       hash[tuple2] == true
  end
end