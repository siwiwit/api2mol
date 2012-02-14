




# A block to be used in filters...
class LazyBlock
  def initialize(method_name, &block)
    @method_name = method_name
    @block = block
  end
  
  def use_method?(method_name)
    @method_name.to_s == method_name.to_s
  end
  
  def call(object, *args, &block)
    if @block == nil
      object.method(@method_name).call(*args, &block)
    else
      block = @block
      object.instance_eval do 
        block.call(*args) 
      end
    end
  end
end






