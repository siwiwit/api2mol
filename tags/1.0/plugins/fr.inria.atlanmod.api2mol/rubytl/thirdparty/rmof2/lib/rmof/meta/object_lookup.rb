# This file contains utility modules to allow objects to be looked up
# by some attribute, probably obtained from the XMI.
#
# This module include utilities to compute a URI fragment for
# a given object using the Ecore style.
#

module RMOF
  # TODO: Factor with ECore#EObject
  module ObjectLookup

    # Lookup a contained object given a path
    #
    def lookup_object(path_fragment)     
      if path_fragment.include?('.')
        parse_path_fragment(path_fragment) do |reference, index|
          self.get(reference).at(index)
        end       
      elsif path_fragment =~ /^@/
        # The reference should be 1:1
        self.get(path_fragment.sub('@', ''))
      else
        # TODO: Should be an error?
        return self.eGet(self.getEStructuralFeature(path_fragment))
      end
    end

    # Taking into account the container of the object, the complete uri fragment,
    # from the object to the root container, is computed. 
    #
    def compute_uri_fragment
      if __container__
        segment = __container__.uri_segment(__container_reference__, self)        
        __container__.compute_uri_fragment + '/' + segment
      else
        if @owning_model
          @owning_model.uri_segment(self)      
        else
          '#/'
        end
      end  
    end

    # Returns the uri segment for a contained object
    # by a given reference.
    #
    # == Arguments
    # * <tt>containment_reference</tt>
    # * <tt>contained_object</tt>
    #
    def uri_segment(containment_reference, contained_object)
      if containment_reference.multivalued?
        list = self.get(containment_reference)
        index = list.index(contained_object)
        raise "No contained object #{contained_object} : #{contained_object.metaclass.name}" unless index
        "@#{containment_reference.name}.#{index}"
      else
        "@#{containment_reference.name}"
      end       
    end

  private
    def parse_path_fragment(path_fragment)
      elements = path_fragment.sub('@', '').split('.')
      yield(elements[0], elements[1].to_i)
    end
  end
end


