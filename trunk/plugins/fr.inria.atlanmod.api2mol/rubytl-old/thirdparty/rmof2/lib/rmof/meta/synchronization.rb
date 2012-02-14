module RMOF
  module InverseResolvers

    
    # It performs all actions needed to keep synchronized a bidirectional
    # association when a value is set in the "one part of the relationship".
    # Notice, that the opposite end upper bound can be either 0..1 or 0..N.
    #
    # == Example
    #    
    #   ------------  orders      customer    ---------
    #   | Customer | ------------------------ | Order |
    #   ------------  0..*               1    ---------
    # 
    #   customer = Customer.new
    #   order = Order.new
    #   order.customer = customer  
    #   # Here, from_one_inverse_resolve should be called to add the order
    #   # object to the customer#orders list.
    #
    # == Containment references
    # If the opposite end is a containment reference, then the passed +object+
    # is set as the container of this object. 
    #
    # == Arguments
    # * <tt>owner</tt>. The object whose property has been set.
    # * <tt>property</tt>. The property that has been set. It must have upperBound == 1.
    # * <tt>object</tt>. The new value of the property.
    # * <tt>old_object</tt>. The old value of the property.
    #
    def from_one_inverse_resolve(owner, property, object, old_object)
      if property.eOpposite.multivalued?
        old_object.get(property.eOpposite).remove_without_inverse(owner) if old_object != nil
        object.get(property.eOpposite).add_without_inverse(owner) if object != nil        
      else
        object.quick_set(property.eOpposite, owner, false)
      end        

      if property.eOpposite.containment
        self.__container__ = object
        self.__container_reference__ = property.eOpposite
      end
    end

    def inverse_resolve(owner, property, object)
      # TODO: Ensure that object is an RMOF Object of the proper type   
      # TODO: What about nils? 
      # TODO: Remove old objects
      if property.eOpposite.multivalued?
        object.get(property.eOpposite).add_without_inverse(owner)
        # raise "TODO: N..N relationships"   
      else
        object.quick_set(property.eOpposite, owner, false)
      end  
    end
        
    # Sets the container of this object. The containment relationship
    # is hold through a certain reference.
    # This method does not add this object to the +owner+, but just sets
    # the owner of this object as its container.
    #
    # == Arguments
    # * <tt>owner</tt>. The owner of the object.
    # * <tt>reference</tt>. The reference where this object is stored in the container.
    #
    def set_container(owner, reference) 
      self.__container__ = owner
      self.__container_reference__ = reference
      self.quick_set(reference.eOpposite, owner, false) if reference.eOpposite
    end
    
    # Removes the object from its current container it is
    # has one assigned.
    def remove_from_container
      if self.__container__ != nil
        self.__container__.remove_contained_object(self, __container_reference__)
        if __container_reference__.eOpposite
          self.quick_set(__container_reference__.eOpposite, nil, false)
        end
      end
    end  
    
    # Remove an object which is contained through a reference
    # so that this object does not belong to this container
    # anymore.
    #
    # == Arguments
    # * <tt>object</tt>. The object to be removed
    # * <tt>reference</tt>. The reference from which the object will be removed.
    #
    def remove_contained_object(object, reference)
      if reference.multivalued?
        self.get(reference).remove_without_inverse(object)
      else
        self.quick_set(reference, nil, false)
      end
    end  

    # In a 1_1 relationship, it changes de container of a new object
    # which is contained in the +owner+ object, and sets the +old_value+ container
    # to nil.
    def change_container_for_1_1(owner, old_value, value, property)
      old_value.__container__ = nil if old_value
      if value
        value.remove_from_container 
        value.set_container(owner, property)
      end    
    end    

  end

end
