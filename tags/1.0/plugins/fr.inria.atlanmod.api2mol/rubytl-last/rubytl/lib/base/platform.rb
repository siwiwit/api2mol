RUBYTL_ROOT = File.join(File.dirname(__FILE__), '..')
$LOAD_PATH << RUBYTL_ROOT

class Platform
  class << self
    attr_writer :impl
    
    def method_missing(name, *args, &block)
      @impl.send(name, *args, &block)
    end
  end
end

  