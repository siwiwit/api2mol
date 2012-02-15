
module Test
  class PrintableMock
    include RubyTL::Base::ObjectPrint
    
    Property = Struct.new(:name)
    attr_reader :rumi_all_properties

    def initialize
      @rumi_all_properties = []
    end
    
    def metaclass
      self
    end
    
    def get(name)
      self.send(name)
    end
    
    def add_property(property) 
      self.instance_eval %{
        def #{property.name}; @#{property.name}; end
        def #{property.name}=(v); @#{property.name} = v; end
      }
      @rumi_all_properties << property
    end
  end
end