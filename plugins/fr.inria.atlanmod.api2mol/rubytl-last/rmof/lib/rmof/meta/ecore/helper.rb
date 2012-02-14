
module ECore
module EPackageLookup

    def classifiers
      return eClassifiers
    end      

    def lookup_object(path_fragment)          
      unless @quick_classifiers
        @quick_classifiers = {}
        eClassifiers.each do |c|        
          @quick_classifiers[c.non_qualified_name] = c
        end        
      end
      # This only improves metamodel reading performance     
      #      self.eClassifiers.lookup_first do |classifier|
      #        classifier.non_qualified_name == path_fragment
      #      end
      #            
      result = @quick_classifiers[path_fragment]
      unless result
        result = eSubpackages.lookup_first { |p| p.name == path_fragment }
      end      
      result      
    end

    # TODO: This way is only for generated metamodels
    # I should separate helpers for generated and reflexive interfaces
    def getEClassifier(name)
      eval(name)
    end
  
    # Redefine the usual behaviour to always return then
    # name of object (that should be a EClass)
    #
    # == Arguments
    # * <tt>containment_reference</tt>
    # * <tt>contained_object</tt>
    #
    def uri_segment(containment_reference, contained_object)    
      contained_object.name    
    end
end
end

module ECore

  module CommonEClassInterface
        # Factorize: EClassImpl    
=begin
    def getEStructuralFeature(name)
      feature = eAllStructuralFeatures.select { |f| f.name_ == name }.first
      raise RMOF::FeatureNotExist.new(name, self) unless feature
      feature
    end  
=end    
    def getEStructuralFeature(name, strict = true)
      #feature = eAllStructuralFeatures.select { |x| x.name == name }.first
      #raise RMOF::FeatureNotExist.new(name, self) if feature.nil? && strict
      #return feature    
               #$count1 ||= 0; $stderr << "#{$count1}\n"; $count1 += 1
      # This condition is a horrible hack 
      # if i remove this condition, test_regression_javam doesn't work, so...
      unless @quick_features    
        @quick_features = {}
        eAllStructuralFeatures.each do |f|        
          @quick_features[f.name_] = f
        end
      end
      
      feature = @quick_features[name]
      raise RMOF::FeatureNotExist.new(name, self) if feature.nil? && strict
      feature
    end    
    
    def getEOperation(name, strict = true)
      unless @quick_operations
        @quick_operations = {}
        eAllOperations.each do |f|
          @quick_operations[f.name_] = f
        end
      end
      
      operation = @quick_operations[name]
      raise RMOF::OperationNotExist.new(name, self) if operation.nil? && strict
      operation
    end    

    def eAllStructuralFeatures
#      result = self.eStructuralFeatures.dup
#      self.eSuperTypes.each do |s|
#        s.eAllStructuralFeatures.each do |f|
#          result.unshift(f)
#        end
#      end
#      result

      self.eStructuralFeatures + self.eSuperTypes.map { |t| t.eAllStructuralFeatures }.flatten
    end    

    def eAllOperations
       self.eOperations + self.eSuperTypes.map { |t| t.eAllOperations }.flatten
    end    
    
    def eAllAttributes
      self.eAllStructuralFeatures.select { |attr| attr.kind_of? ECore::EAttribute }
    end

    def eAllReferences
      self.eAllStructuralFeatures.select { |attr| attr.kind_of? ECore::EReference }
    end

    def eReferences
      self.eStructuralFeatures.select { |attr| attr.kind_of? ECore::EReference }
    end

    def eAttributes
      self.eStructuralFeatures.select { |attr| attr.kind_of? ECore::EAttribute }
    end
  
    def eAllSuperTypes
      unless @eAllSuperTypes      
        @eAllSuperTypes = self.eSuperTypes + self.eSuperTypes.map { |t| t.eAllSuperTypes }.flatten.reverse
      end
      @eAllSuperTypes
    end   

    def eIDAttribute
      self.eAllAttributes.lookup_first { |a| a.iD }
    end

    ## Common Ruby Metamodel interface for EClass
    def property_exist?(name)
      self.getEStructuralFeature(name) != nil
    rescue RMOF::FeatureNotExist
      false
    end
    
    # TODO: Take one naming convention
    def property(name, strict = false)
      self.getEStructuralFeature(name, strict)
    end  

    def property_by_name(name)
      self.property(name)
    end

    def get_reference(name)
      feature = self.getEStructuralFeature(name)
      if not feature.kind_of?(ECore::EReference)
        raise "Feature '#{name}' expected to be a reference but is a #{feature.class}"
      end
      feature
    end
    
    alias_method :all_super_types, :eAllSuperTypes
    alias_method :all_structural_features, :eAllStructuralFeatures
    alias_method :all_references, :eAllReferences
    alias_method :all_attributes, :eAllAttributes
  end



  # A module with helper functions to define meta-models base on ECore
  #
  module Helper # TODO: Set ClassHelper as name?
    include CommonEClassInterface
    
    # Added to allow meta-metaclasses to refer to structural features
    def lookup_object(path_fragment)
      value = self.getEStructuralFeature(path_fragment)
      raise "error" if not value
      return value #self.getEStructuralFeature(path_fragment)    
    end    

        
    def metaclass
      return ECore::EClass
    end

    def getEStructuralFeatureFromClass(name)
      feature = self.eStructuralFeatures.lookup_first { |f| f.name_ == name }
      raise RMOF::FeatureNotExist.new(name, self) unless feature
      feature
    end

    def define_super_types(*super_types)
      if @eSuperTypes.nil?
        super_types = [EObject] if super_types.empty? && self != EObject
        @eSuperTypes = super_types
      end
      @eSuperTypes
    end
  
    def define_structural_features
      if @eStructuralFeatures.nil?
        @eStructuralFeatures = []
        yield
      end
      @eStructuralFeatures      
    end
  
    def define_attribute(name, type, options = {})
      @eStructuralFeatures.unshift(attribute = ECore::EAttribute.new())
      set_structural_feature_options(attribute, name, type, options)
      attribute
    end  
    
    # Define a new reference from a class to another.
    # Defining a reference is done in two steps to avoid problems
    # with recursive definitions...
    #
    def define_reference(name, type, options = {}) 
      @eStructuralFeatures.unshift(reference = ECore::EReference.new)     
      set_structural_feature_options(reference, name, type, options)
      reference.containment_ = options[:containment]
      reference
    end   
    
    def reference_opposite(name, opposite)
      reference = self.getEStructuralFeatureFromClass(name)
      reference.eOpposite_ = reference.eType_.getEStructuralFeatureFromClass(opposite)
    end
    
  private
    def set_structural_feature_options(feature, name, type, options)
      feature.eContainingClass_ = self
      feature.name_ = name
      feature.eType_ = type
      feature.derived_ = options[:derived]    
      feature.upperBound_ = options[:upperBound] || 1 #if options[:upperBound]
    end
  end
end

module ECore
  module TypeCasting
    def cast_primitive(string_value, instanceClassName)
      # TODO: Detect types
      case instanceClassName
      when /String/ then return string_value
      when 'int' then return string_value.to_i
      when 'float' then return string_value.to_f
      when 'double' then return string_value.to_f
      when /Integer/ then return string_value.to_i
      when /(L|l)ong/ then return string_value.to_i
      when /(B|b)oolean/ then return string_value.downcase == 'true'
      when 'java.lang.Object' then string_value.to_s 
      when 'java.util.Date' then (require 'time'; Time.parse(string_value))
      else raise "Type #{instanceClassName} not supported. XMI value #{string_value}"
      end
    end
  end
end

class Module
  # TODO: Merge with EObjectImpl... 
  def __meta_attribute__(*symbols)
    symbols.each do |symbol|
#        if symbol == 'name'
#        def #{symbol}; @#{symbol} end
#        else
#        def #{symbol}; get('#{symbol}'); end
#        end
#        def #{symbol}; get('#{symbol}'); end

      self.class_eval %{
        def #{symbol}; @#{symbol} end
        def #{symbol}_; @#{symbol}; end
        def #{symbol}=(value); set('#{symbol}', value); end
        def #{symbol}_=(value); @#{symbol} = value; end        
      }
    end
  end

  def __meta_reference__(*symbols)
    symbols.each do |symbol|
      self.class_eval %{
        def #{symbol}; get_from_string('#{symbol}'); end
        def #{symbol}_; @#{symbol}; end
        def #{symbol}=(value); set('#{symbol}', value); end
        def #{symbol}_=(value); @#{symbol} = value; end        
      }, __FILE__, __LINE__ - 4
    end
  end
  
end
