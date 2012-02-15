# Load RubyTL
# $LOAD_PATH << File.join(File.dirname(__FILE__), '..')

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'test', 'rubytl_base_unit')

require 'test/unit'

def dir_entries(dir, regex = nil)
  Dir.entries(dir).each do |entry|
    if not ['.', '..'].include?(entry) 
      if regex == nil || (entry =~ regex)     
        yield(File.join(dir, entry))
      end
    end
  end
end


module TestHelper
  def transformation(root, filename)
    File.join(File.dirname(root), filename) 
  end


  def set_plugin_path(file)
    @plugin_dir = File.dirname(file)
    #ModelLoader.current = DefaultModelLoader.new
    #ModelLoader.current.model_path.push(File.dirname(file))
  end
  
  def plugin_file(file)
    File.join(@plugin_dir, file)
  end

#  def plugin_file(base, file)
#    File.join(File.dirname(base), file)
#  end
  
end

dir_entries(File.dirname(__FILE__)) do |entry|
  if File.directory?(entry) and File.exists?(File.join(entry, 'tests'))
    dir_entries(File.join(entry, 'tests'), /^test(\w|\.)*rb$/) do |entry|
      require entry
    end
  end
end

