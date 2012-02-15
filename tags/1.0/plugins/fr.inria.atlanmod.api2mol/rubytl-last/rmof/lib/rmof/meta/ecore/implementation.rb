
# Implementation of ECore operations.

# ECore package implementation
module ECore
  extend EPackageLookup
end

# Is this a hack?
# As a every generated metaclass returns itself as the 
# metaclass, the EPackage class should give concrete values
# to nsPrefix and nsURI
#
module ECore
  class EPackage
    def self.nsURI
      ECore.nsURI
    end
	
    def self.nsPrefix
  	  ECore.nsPrefix
    end		  
    
    def root_package
      return self unless self.eSuperPackage
      return self.eSuperPackage.root_package
    end
  end
end

module ECore
  module EClassifierImpl
  	def nsURI
      self.ePackage.nsURI
  	end
  	
  	def nsPrefix
  	  self.ePackage.nsPrefix
  	end
  end
 
#  self.eClassifiers.each do |klass|  
#    klass.send(:include, RMOF::ObjectHelper)
#    klass.send(:include, RMOF::ObjectLookup)
#    klass.send(:include, RMOF::InverseResolvers)
#  end

  
  module EObjectImpl    
    def initialize(values = {})
      # initialize_object_features
      check_abstract_class
      auto_set_features(values)
      yield(self) if block_given?
    end
  
    def eGet(eStucturalFeature)
      self.get(eStucturalFeature)
      # --       name = eStucturalFeature.kind_of?(String) ? eStucturalFeature : eStucturalFeature.name

      # TODO: Mejorar a�adiendo comprobaci�n de tipos
      
      # -- self.send("#{name}")
      
      # La comprobaci�n de tipos se hace mirando la metaclase, es decir, un Eclass
      # esto me lleva a pensar si el ECLASSCommon tiene sentido para ser incluido...
    end
    
    def eSet(eStucturalFeature, value)
      self.set(eStucturalFeature, value)
      # --       name = eStucturalFeature.kind_of?(String) ? eStucturalFeature : eStucturalFeature.name
      # TODO: Mejorar a�adiendo comprobaci�n de tipos
      # --       self.send("#{name}=", value)
      # La comprobaci�n de tipos se hace mirando la metaclase, es decir, un Eclass
      # esto me lleva a pensar si el ECLASSCommon tiene sentido para ser incluido...
    end
    
    def isInstanceOf(metaclass)
      self.metaclass == metaclass || self.metaclass.eSuperTypes.include?(metaclass)
    end    
  end  


  module EPackageImpl    
    def non_qualified_name
      self.name_
    end
    
    def eClasses
      self.eClassifiers.select { |c| c.kind_of? ECore::EClass }
    end

    def eDataTypes
      self.eClassifiers.select { |c| c.kind_of? ECore::EDataType }
    end
  end
  
  # module EPackageImpl doesn't not work, why?
  class EPackage
    include EPackageLookup
    
    # Part of the common interface defined by rmof...
    #
    alias_method :classifiers, :eClassifiers
  end
  
  class EClass
    alias_method :standard_lookup_object, :lookup_object
    def lookup_object(path_fragment)
      return standard_lookup_object(path_fragment) if path_fragment.include?('@') 

      # I guess this is something like this
      if path_fragment.include?('.')
        parse_path_fragment(path_fragment) do |name, index|
          return self.getEStructuralFeature(name) if index == 1
          return self.eOperations.select { |o| o.name == name } if index == 0
          raise "Unexpected case"
        end            
      end
# self.eOperations.select { |o| o.name == path_fragment }.first ||              self.getEStructuralFeature(path_fragment)    
      return self.getEOperation(path_fragment, false) || 
             self.getEStructuralFeature(path_fragment)    

    end

    # Redefine the usual behaviour to always return then
    # name of object (that should be a StructuralFeature)
    #
    # == Arguments
    # * <tt>containment_reference</tt>
    # * <tt>contained_object</tt>
    #
    def uri_segment(containment_reference, contained_object)       
      contained_object.name    
    end

    # An alternativa implementation to the helper.rb, which doesn't
    # use hashes to avoid problems.
    def getEStructuralFeature(name, strict = true)
      feature = nil
      if @quick_features
        feature = @quick_features[name]
      else
        feature = eAllStructuralFeatures.lookup_first { |x| x.name == name }      
      end
      raise RMOF::FeatureNotExist.new(name, self) if feature.nil? && strict
      return feature
      # TODO: Once and for all, implement it with hashes ok!    
    end   
       
  end

  class EAnnotation
    def lookup_object(path_fragment)   
      self.contents.lookup_first { |o| o.name == path_fragment }
    end
  end
end


# Provides a common interface to the ECore metamodel.
#
module ECore  
  
  module EObjectCommon
  
#    def set(property, value)
#      return self.eSet(property, value)
#    end  
    
#    def get(property)
#      return self.eGet(property)    
#    end
    
    # Creating new objects
    # TODO: Is here a good place?
    def new_instance(initial_values = {})
      return RMOF::ModelObject.new(self, initial_values)
    end
  end

  module EStructuralFeatureCommon
    def is_reference?
      return self.class == EReference
    end
    
    def is_attribute?
      return self.class == EAttribute
    end
  end

  module ETypedElementCommon
    ## Common Ruby metamodel interface for EStructuralFeature
    def type
      self.eType_
    end
    
    def multivalued?
      self.upperBound_ == -1
    end

  end

end


module ECore
  module EStructuralFeatureStruct
    # TODO: Test that self.eContainingClass returns a proper value
    # not an Array
    #def owner
    #  return self.eContainingClass
    #end
  end
  
  module EAttributeStruct
    # I'm not really sure if this is ok, because I though that defaultValue was
    # a stored property, but now EMF uses defaultValueLiteral...
    def computedDefaultValue
      literal = defaultValueLiteral_ || defaultValue_
      if literal && self.eType.is_primitive?
        return self.eType.from_xmi_str(literal)       
      elsif self.eType.is_enumeration?  
        return self.eType.eLiterals.first
      end
    end
  end
end 

# TODO: Refactor up
module ECore
  module EClassifierImpl
    def non_qualified_name
      self.name_
    end
    
    def is_metaclass?
      self.metaclass == ECore::EClass
    end
    
    def is_enumeration?
      self.metaclass == ECore::EEnum
    end
    
    def is_primitive?
      self.metaclass == ECore::EDataType
    end
  end

  class EClass
    include CommonEClassInterface
    
    alias_method :super_types, :eSuperTypes    
  end
    
  class EDataType
    include TypeCasting
    
    def from_xmi_str(string_value)
      cast_primitive(string_value, self.instanceClassName || self.name)
    end
  end
end



# Dynamic performance improvement
# Once a metamodel has been read, making it read-only
# can provide a performance improvement superseding 
# methods for improved versions.
module ECore
  class EPackage
         
    def compact_elements
      #@quick_classifiers = {}
      eClasses.each do |c|
      #  @quick_classifiers[c.non_qualified_name] = c
        c.compact_structural_features
      end
      
      #def self.lookup_object(path_fragment)          
      #  @quick_classifiers[path_fragment]
      #end      
    end
  end
  
  class EClass
    def compact_structural_features
      @quick_features = {}
      @eAllStructuralFeatures = []
      @eAllAttributes = []
      @eAllReferences = []
  
      eAllStructuralFeatures.each do |f|
        @quick_features[f.instance_variable_get('@name')] = f
        @eAllStructuralFeatures << f
        if f.kind_of? ECore::EAttribute
          @eIDAttribute = f if f.iD
          @eAllAttributes << f
        elsif f.kind_of? ECore::EReference
          @eAllReferences << f
        end
      end
      
      def self.getEStructuralFeature(name, strict = true)
        feature = @quick_features[name]
        raise RMOF::FeatureNotExist.new(name, self) if feature.nil? && strict
        feature
      end    
      
      def self.eAllStructuralFeatures;  @eAllStructuralFeatures; end
      def self.all_structural_features; @eAllStructuralFeatures; end      
      def self.eIDAttribute; @eIDAttribute; end      
      def self.eAllAttributes; @eAllAttributes; end
      def self.eAllReferences; @eAllReferences; end
      def self.all_attributes; @eAllAttributes; end    
      def self.all_references; @eAllReferences; end    


    end
  end
  
end

module ECore
  class EDataType
    include ECore::TypeCasting
 
    def from_xmi_str(value)
      cast_primitive(value, self.instanceClassName || self.name)
    end
  
    def to_xmi_str(value)
      # TODO: Do a helper such as cast_primitive to serialize properly
      value.to_s
    end
  end
end 





