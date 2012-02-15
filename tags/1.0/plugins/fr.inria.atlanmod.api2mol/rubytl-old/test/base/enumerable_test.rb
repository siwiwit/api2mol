require 'rubytl_base_unit'

# Test extensions made to the enumerable module.
class EnumerableTest < Test::Unit::TestCase

  # Test the cross product between enumerables
  def test_cross_product      
    assert_tuples [Tuple[1, 3], Tuple[1, 4], Tuple[2, 3], Tuple[2, 4], Tuple[3, 3], Tuple[3, 4]],
                  [1, 2, 3] ** [3, 4]    

    assert_tuples [Tuple[1, 2, 5], Tuple[1, 2, 6], Tuple[3, 4, 5], Tuple[3, 4, 6]],
                  [Tuple[1, 2], Tuple[3, 4]] ** [5, 6]
  end
  
  def test_cross_on_empty
    assert_tuples [Tuple[1], Tuple[2]],
                  [] ** [1, 2]

    assert_equal TupleArray, ([] ** [1, 2]).class
    assert_equal TupleArray, ([1, 2] ** []).class    
  end

  def test_cross_and_plus
    assert_tuples [Tuple[1, 3], Tuple[2, 3], Tuple[4, 5]],
                  ([1, 2] ** [3]) + ([4] ** [5])

    assert_equal TupleArray, (([1, 2] ** [3]) + ([4] ** [5])).class
  end
  
  def test_permutations
    assert_equal number_of_permutations( 3, 1), (['a', 'b', 'c'] ** 1).size
    assert_tuples [Tuple['a'], Tuple['b'], Tuple['c']], 
                  ['a', 'b', 'c'] ** 1
    assert_equal number_of_permutations( 3, 2), (['a', 'b', 'c'] ** 2).size
    assert_tuples [Tuple['a', 'b'], Tuple['a', 'c'], Tuple['b', 'a'], Tuple['b', 'c'], Tuple['c', 'a'], Tuple['c', 'b']], 
                  ['a', 'b', 'c'] ** 2
    assert_equal number_of_permutations( 3, 3), (['a', 'b', 'c'] ** 3).size
    assert_equal number_of_permutations(20, 4), ((1..20).to_a ** 4).size
    assert_equal number_of_permutations(30, 3), ((1..30).to_a ** 3).size    
  end
  
  def test_tuple_size
    assert_equal 1, [].tuple_size
    assert_equal 3, TupleArray.new(3).tuple_size
    assert_equal 2, ([1, 2, 3] ** [3, 4]).tuple_size
    assert_equal 3, ([1, 2, 3] ** [3, 4] ** [5, 6]).tuple_size    
    assert_equal 2, ((1..10).to_a ** 2).tuple_size        
  end
  
  def test_custom_permutations_upto
    permutation_count = Hash.new(0)
    r = [1, 2, 3, 4, 5].custom_permutations_upto(3) do |values|
      permutation_count[values.size] += 1
    end
    assert_equal 0                            , permutation_count[1]
    assert_equal number_of_permutations(5, 2) , permutation_count[2]
    assert_equal number_of_permutations(5, 3) , permutation_count[3]
    assert_equal 0                            , permutation_count[4]    
  end
  
protected
  def number_of_permutations(n, k)
    minor = n - k + 1
    (minor..n).inject(1) { |x, y| x * y }
  end
  
end