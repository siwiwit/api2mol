#
# This file contains 'overrides' the XSD classes, and provide
# convenience modules to adapt the XSD metamodel implementation
# to the defined RumiInterface.
#
# The following classes are overrided:
#
# * <tt>ElementDefinition</tt>
#
# Two modules are provided to be mixed-in with existing clases:
#
# * <tt> RubyTL::RumiXSD::ClassInterface</tt>
# * <tt> RubyTL::RumiXSD::XMLNodeInterface</tt> 
#

module RubyTL
  module Xsd
    
    module ElementDefinitionImpl
      def rumi_type
        self.typeDefinition
      end
    end
    
  end
end


module RubyTL
  module RumiXSD
    
    module ClassInterface

      attr_reader :rumi_model_id

      # Conformance means that +this+ object is an instance of the
      # passed +metaclass+ or of any of this superclasses. This means
      # that +self.metaclass+ is a subclass of the passed +metaclass+, and
      # so it can be assigned to any instance of such metaclass.
      def rumi_conforms_to?(metaclass)
        metaclass = metaclass.real_klass if metaclass.respond_to? :real_klass
        return true if metaclass == @real_klass
        return true if @real_klass.all_super_types.include? metaclass                
        return false       
      end

      def rumi_property_by_name(name)
        @real_klass.property_by_name(name)
      end
      
      def rumi_all_properties
        @real_klass.all_properties
      end

      def rumi_qualified_name
        @real_klass.name
      end
    
      def method_missing(name, *args)
        @real_klass.send(name, *args)
      end
      
      alias_method :old_equal, :==
      def ==(other_klass)
        @real_klass == other_klass || old_equal(other_klass)
      end
    end

        
    module XMLNodeInterface
      include RubyTL::Base::ObjectPrint 
      
      # Virtual class to which this model object refers
      attr_accessor :virtual_klass
      
      # This method overwrite the default ModelObject#metaclass method
      # to return the virtual class instead of the real RMOF EClass.
      # This means that the virtual class should provide a duck-typed
      # interface similar to the RMOF EClass.
      def metaclass
        @virtual_klass
      end
            
      def rumi_kind_of?(klass)
        klass = klass.real_klass if klass.respond_to?(:real_klass)
        self.is_instance_of?(klass)
      end
      
      def respond_to?(property, include_private = false)
        self.metaclass.property_exist?(property.to_s)
      end
      
      def kind_of?(klass)
        self.rumi_kind_of?(klass)
      end
      
      def is_a?(klass)
        self.rumi_kind_of?(klass)
      end
      
      def rumi_reference_value_set(reference, value)
        if value.kind_of? Array
          value.each { |v| rumi_reference_value_set(reference, v) }
        else
          self.set(reference, value)         
        end
      end           
      
      # TODO: Remove model_id, just use rumi_model_id
      attr_accessor :model_id
      
      def rumi_model_id
        self.model_id
      end      
    end

  end
end