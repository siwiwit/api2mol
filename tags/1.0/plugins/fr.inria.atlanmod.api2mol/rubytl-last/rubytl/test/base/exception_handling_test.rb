require 'rubytl_base_unit'


class ExceptionHandlingTest < Test::Unit::TestCase

  def test_exception_backtrace
    my_mock = Class.new do
      include RubyTL::BacktraceHandling
      public :split_element
    end
    my_mock.new.split_element('/home/jesus/project/file.rb:34:in my_method') do |file, line, function|
      assert_equal '/home/jesus/project/file.rb', file
      assert_equal '34', line
      assert_equal 'in my_method', function
    end
    
    my_mock.new.split_element('/home/jesus/age-test/age/workspace/plsql-wrappers/transformations/wrapper2java.rb:213') do |file, line, function|
      assert_equal '/home/jesus/age-test/age/workspace/plsql-wrappers/transformations/wrapper2java.rb', file
      assert_equal '213', line
      assert_equal '', function
    end

    
    
    my_mock.new.split_element('C:\\Documents and Settings\\Jesus\\Project\\file.rb:34:in my_method') do |file, line, function|
      assert_equal 'C:\\Documents and Settings\\Jesus\\Project\\file.rb', file
      assert_equal '34', line
      assert_equal 'in my_method', function
    end 
  end  
end