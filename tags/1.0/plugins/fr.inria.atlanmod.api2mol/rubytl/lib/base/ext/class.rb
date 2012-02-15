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

class Symbol
  def to_proc
    Proc.new { |x| x.send(self) }
  end
end

class Object
    def deep_clone
      Marshal::load(Marshal.dump(self))
    end
end

class Module
  def one_use_method(name)
    args = name.to_s.include?('=') ? 'arg' : '*args, &block'
    self.class_eval %{
      alias_method '__one_use_aliased_method_#{name}', '#{name}'
      def #{name}(#{args})
      puts "kkk"
        result = __one_use_aliased_method_#{name}(#{args})
        puts result
        #class << self; self; end.send(:undef_method, '#{name}')
        #class << self; self; end.send(:undef_method, '__one_use_aliased_method_#{name}')
        result
      end
    }
  end
end
