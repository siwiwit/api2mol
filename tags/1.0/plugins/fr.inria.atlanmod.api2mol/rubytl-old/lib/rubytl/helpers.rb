def log
  
end

class Class
  def cattr_reader(*cvs)
    cvs.each do |cv|
      class_eval %Q[
          def self.#{cv}; @@#{cv} end
        ]
    end
  end    

  def cattr_writer(*cvs)
    cvs.each do |cv|
      class_eval %Q[
          def self.#{cv}=(value); @@#{cv} = value end
        ]
    end
  end    
  
  def cattr_accessor(*cvs)
    cattr_reader(*cvs)
    cattr_writer(*cvs)
  end
end

class String    
  def underscore
    # From ActiveRecord
    self.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').downcase
  end
end

# A block to be used in filters...
class LazyBlock
  def initialize(method_name, &block)
    @method_name = method_name
    @block = block
  end
  
  def use_method?(method_name)
    @method_name == method_name
  end
  
  def call(object, *args)
    object.method(@method_name).call(*args) if @method_name != nil
    block = @block
    object.instance_eval do 
      block.call(*args) 
    end if @method_name == nil
  end
end


class Class
   def define_block_method(name, &block)
     internal_name = :"_#{name}"

     module_eval %{
       def #{name}(*args, &block)
         #{internal_name}(args, block)
       end
     }

     define_method(internal_name, &block)
     return block
   end
end

class Array

  # Returns a hash containing arrays as values
  #
  def group_by
    result = {}
    self.each do |value|
      group = yield(value)
      result[group] ||= []
      result[group] << value
    end
    result
  end

  def stringify
    self.map { |v| v.to_s }
  end
end

