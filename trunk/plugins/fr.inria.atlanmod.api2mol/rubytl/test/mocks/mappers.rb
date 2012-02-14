
module Test
  class TemplateMapperMock < RubyTL::TemplateMapper
    attr_reader :written_files
    
    def initialize(*args)
      super(*args)
      @written_files = {}
    end
  
    def write_file(logical, str, codebase = nil)
      @written_files[logical] = str
    end
  end
end

=begin
class BaseTestLogicalMapper < RubyTL::TemplateMapper
  attr_reader :files
  
  def initialize(base)
    super(base)
    @files = {}
  end

  # Custom mock methods
  def add_file(file, string)
    @files[file] = StringIO.new(string)
  end
end

class TestWriteLogicalMapper < BaseTestLogicalMapper 
  def open_file(filename, tags = "r", &block)
    if tags == "w"
      @files[filename] = StringIO.new('', "w")
      # @files[filename].reopen('', tags)
      block.call(@files[filename])
#      @files[filename].close_write
    else
      super(filename, tags, &block)
    end      
  end
end
=end