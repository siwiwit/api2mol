require 'rubytl_base_unit'

# Test extensions made to the string class
class StringTest < Test::Unit::TestCase

  def test_ruby_constant_names
  
    assert_equal 'Correct', 'Correct'.to_ruby_constant_name
    assert_equal 'Downcase', 'downcase'.to_ruby_constant_name
    assert_equal 'ItHasSpaces', 'It has spaces'.to_ruby_constant_name
    assert_equal 'ItHasSpaces', 'it has spaces'.to_ruby_constant_name # TODO: What happen if there is a naming collision
    assert_equal 'Striped', '  striped '.to_ruby_constant_name

    # TODO: Who should raise an "Invalid constant name"
  end
  
  def test_ruby_method_name
  
    assert_equal 'my_method', 'my-method'.to_ruby_method_name
    assert_equal 'my_method', 'my.method'.to_ruby_method_name
  end

  
end