require 'rubytl_base_unit'

class LogicalMapperTest < Test::Unit::TestCase
  def test_write
    text = %{
      This is a test text. 
      It should have three lines.
    }
        
    basepath = '/tmp/delete-test-dir'
    newfile  = 'mydir/thing.txt'
    mapper = RubyTL::LogicalMapper.new('.')
    mapper.write_file(newfile, text, basepath)
    
    File.open(File.join(basepath, newfile)) do |f|
      assert_equal text, f.read
    end
    
    FileUtils.rm_rf(basepath)
  end

  def test_eclipse_uri_resolver_for_windows
    resolver = RubyTL::EclipseURIResolver.new("\\home\\jesus\\\\test")
    assert_equal 'file:///home/jesus//test/test-file', resolver.resolve_as_local('test-file')
    assert_not_nil URI.parse(resolver.resolve_as_local('test-file'))

    # Test space replacement with %20.
    resolver = RubyTL::EclipseURIResolver.new("c:\\home\\jesus\\\\test")
    assert_equal 'file:///c:/home/jesus//test/test%20file', resolver.resolve_as_local('test file')
    assert_not_nil URI.parse(resolver.resolve_as_local('test-file'))
  end


end