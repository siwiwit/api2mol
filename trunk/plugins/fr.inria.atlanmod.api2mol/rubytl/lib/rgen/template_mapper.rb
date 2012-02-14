require 'pathname'

module RubyTL

  # This class is in charge of mapping logical resource names
  # to physical ones.
  class TemplateMapper
    attr_reader :base_dir
    attr_reader :workspace
    
    def initialize(workspace)
      @workspace = workspace
      @base_dir = workspace.root_path
    end

    def map_file(filename)
      workspace.create_resource(filename).file_path
      #return filename if Pathname.new(filename).absolute?
      #return File.join(@base_dir, filename)
    end
  
    def open_file(filename, open_options = "r")  
      File.open(map_file(filename), open_options) do |f|
        yield(f)
      end
    end

    # Read a template given a logical name.
    #
    def read_template(logical)
      open_file(logical) { |f| f.read }
    end

    # Write a string to a file. The file name it is supposed to
    # be a logical name.
    # It creates any intermediate directory needed to store the file.
    # 
    def write_file(logical, str, codebase = nil) 
      filename = if codebase.nil? then map_file(logical)
                 else File.join(codebase, logical) end
      path = Pathname.new(filename)
      path.dirname.mkpath

      open_file(filename, "w") { |f| f.write(str) }
    end  
  end
  
end