

module RMOF

  # A module with facility methods to check types
  #
  module TypeChecking
    
    # Check if the assignment of this property can be done. 
    #
    # If the property is a reference then +value+ should be an object
    # whose metaclass is the same class of a subclass of the property
    # type.
    #
    # == Arguments
    # * <tt>property</tt>
    # * <tt>value</tt>
    #
    def check_assignment(property, value)
      return check_reference_assignment(property, value)   if property.is_reference?
      # return check_enumeration_assignment(property, value) if property.is_attribute?
      return check_datatype_assignment(property, value)    if property.is_attribute?
      raise "It should not get here"
    end

    def check_reference_assignment(property, value)
      return true if value.nil?
      return true if compatibility_test(property.type, value.metaclass)
      raise TypeCheckError.new("Property #{property.name}(#{property.type.name}) incompatible with #{value.metaclass.name}")
    end

    def check_datatype_assignment(property, value)
      raise TypeCheckError.new("Nil values are not allowed for primitive types") if value.nil?
      return true
    end

    def is_instance_of?(metaclass)
      compatibility_test(metaclass, self.metaclass)
    end
    
  private
    def compatibility_test(left_metaclass, right_metaclass)
      return ([right_metaclass] + right_metaclass.all_super_types).any? do |metaclass|
        metaclass == left_metaclass      
      end
    end  
  end
end