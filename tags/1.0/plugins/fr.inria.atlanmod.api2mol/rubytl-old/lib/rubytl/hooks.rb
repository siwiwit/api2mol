
module RubyTL
  module Rtl
    
    # This is class represents a hook to specify the type to be created by a rule. 
    # When it is filled with a concrete type all creation operations will 
    # yield to instantiation objects of the concrete type.
    class MetaclassFactoryHook
      attr_reader :name
      attr_reader :base_type
    
      def initialize(hookname, base_type)
        @name  = hookname.to_s
        @base_type = base_type
      end
      
      def concrete_type=(concrete_type)
        raise InvalidConcreteType.new("Invalid concrete type for hook #{@name}") unless is_compatible?(concrete_type)
        @concrete_type = concrete_type
      end
      
      def method_missing(name, *args, &block)
        type = @concrete_type || @base_type
        type.send(name, *args, &block)
      end
    
    private
      def is_compatible?(ctype)
        return false if ctype.abstract   # TODO: I should'n use .real_klass to check all_super_types.include?
        return true  if ctype.all_super_types.include?(@base_type.real_klass) || ctype == @base_type
        return false
      end
    end
    
    class InvalidConcreteType < RubyTL::BaseError; end
    
  end
end