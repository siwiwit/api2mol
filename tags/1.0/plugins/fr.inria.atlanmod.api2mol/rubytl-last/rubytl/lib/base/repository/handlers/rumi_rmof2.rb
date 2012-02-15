
# This file contains the definition of the Ruby model interface (rumi)
# for RMOF.
module ECore

  class EReference  
    # The type of the reference.
    def rumi_type
      self.eType
    end
  end
  
  #class EClass
  #  def rumi_property_by_name(name)
  #    property_by_name(name)
  #  end
  #end
  
end

# Rumi interface at instance level...
# * rumi_kind_of? => Implemented in handler_rmof2 (TODO: Do it here)
      
module RubyTL
  module RumiRMOF
    
    module ClassInterface

      attr_accessor :rumi_model_id

      def is_rumi_class?
        true
      end
      
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
        @real_klass.all_structural_features
      end

      def rumi_qualified_name
        klass = @real_klass
        names = [klass.name]
        pkg   = klass.ePackage 
        while ( pkg != nil ); names << pkg.name; pkg = pkg.eSuperPackage; end
        names.reverse.join('::')
      end

    
      def method_missing(name, *args)
        raise NoMethodError.new("undefined method `#{name}` for metaclass #{@real_klass.name}") unless @real_klass.respond_to?(name)
        @real_klass.send(name, *args)
      end

      # These should not belong to the RUMI interface, but it is necessary to handler ECore objects as model elements
      # THIS METHODS ARE NEEDED BECAUSE THEY CANNOT BE CALLED BY THE METHOD MISSING ABOVE
      # BECAUSE THE RESPOND_TO? HAS BEEN OVERRIDEN BY THE MODEL_OBJECT RUMI INTERFACE
      def all_super_types; @real_klass.all_super_types; end      
      def property_exist?(name); @real_klass.property_exist?(name); end     
      def property(name, resolve_inverse = true); @real_klass.property(name, resolve_inverse); end     
      def getEStructuralFeature(name); @real_klass.getEStructuralFeature(name); end      
      def nsPrefix; @real_klass.nsPrefix; end
      def nsURI;    @real_klass.nsURI; end
      def non_qualified_name; @real_klass.non_qualified_name; end
      def all_structural_features; @real_klass.all_structural_features; end
      # END OF OVERRIDEN METHODS
      
      alias_method :old_equal, :==
      def ==(other_klass)
        @real_klass == other_klass || old_equal(other_klass)
      end
    end
    
    module PrimitiveTypeInterface
      attr_accessor :virtual_klass
      def rumi_kind_of?(klass)
        return klass == ECore::EDataType || klass == ECore::EClassifier
      end
      
      # The semantics of datatype is to copy elements, so model_id's always "conforms"
      def rumi_model_id_check(other_instance)
        true
      end      
    end
    
    module ModelObjectInterface
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
      
      def rumi_model_id_check(other_instance)
        self.rumi_model_id == other_instance.rumi_model_id
      end
    end
  end
end

module ECore
  class EDataType
    def self.rumi_conforms_to?(metaclass)
      metaclass = metaclass.real_klass if metaclass.respond_to? :real_klass
      metaclass == ECore::EDataType
    end
  end
end