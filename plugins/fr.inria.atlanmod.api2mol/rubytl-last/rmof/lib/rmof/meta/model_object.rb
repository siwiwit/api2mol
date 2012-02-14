# TODO: Quitar todos los eOpposite

module RMOF
  module ObjectHelper
    attr_accessor :xmi_id
    attr_writer :owning_model
    def owning_model
      @owning_model || __container__.owning_model
    end

    def initialize_object_features
      self.metaclass.all_attributes.each do |attribute|
        initialize_attribute(attribute)
      end
      self.metaclass.all_references.each do |reference|
        initialize_reference(reference)
      end
    end

    def initialize_attribute(attribute)
      if attribute.computedDefaultValue # TODO: There should be another way to avoid infinite recursion
        self.instance_variable_set("@#{attribute.name}", attribute.computedDefaultValue)
      end    
      if attribute.multivalued?
        self.instance_variable_set("@#{attribute.name}", [])
      end
      return self.instance_variable_get("@#{attribute.name}")
    end
    
    def initialize_reference(reference)
      if reference.multivalued?
        self.instance_variable_set("@#{reference.name}", select_multivalued_reference(reference))
      end    
    end
  
    def auto_set_features(values = {})
      values.each_pair do |key, value| 
        self.set(key.to_s, value)          
      end
    end

    def check_abstract_class
      raise RMOF::AbstractClassCannotBeInstantiated.new(self.metaclass) if self.metaclass.abstract
    end

    attr_accessor :__container__, :__container_reference__
  
    def select_multivalued_reference(reference)
      if reference.containment
        return ContainmentList.new(self, reference) 
      elsif reference.eOpposite != nil      
        return InverseResolvingList.new(self, reference) 
      else
        return [] 
      end
    end

    # Sets a property value, taking into account bidirectional and containment 
    # relationship established by the property. Type check is also performed.
    #
    # == Arguments
    # * <tt>property</tt>. The property to be set, either a Property object or a string.
    # * <tt>value</tt>. The value of the property.
    # * <tt>resolve_inverse</tt>. false if consistency tasks should be done. Default is true.
    #
    def set(property, value, resolve_inverse = true)   
      if property.kind_of?(String)
        property = self.metaclass.property(property.to_s, true)
      end
      check_assignment(property, value)
      
      if property.multivalued?
        self.get(property) << value
      else       
        quick_set(property, value, resolve_inverse)
      end
    end
  
    # This is only for 1:1 relationships.
    #
    def quick_set(property, value, resolve_inverse = true)
      old_value = self.instance_variable_get("@#{property.name}")
      self.instance_variable_set("@#{property.name}", value)                   

      if resolve_inverse && property.is_reference?
        if property.eOpposite
          from_one_inverse_resolve(self, property, value, old_value)
        end 
        if property.containment
          change_container_for_1_1(self, old_value, value, property)
        end
      end    
    end

    def get_from_string(property_name)
      value = self.instance_variable_get("@#{property_name}")
      return value || get_from_property( self.metaclass.getEStructuralFeature(property_name) )      
    rescue RMOF::FeatureNotExist => e
      e.object = self
      raise e
    end
 
    def get_from_property(property)
      value = self.instance_variable_get("@#{property.name}")
      unless value
        value = if property.is_reference?
          initialize_reference(property) 
        else       
          initialize_attribute(property)       
        end 
      end
      value
    end
    
    def get(prop_or_str)
      prop_or_str.kind_of?(String) ? 
        get_from_string(prop_or_str) : 
        get_from_property(prop_or_str)
    end

=begin
    # Old version
    def get(property)
      name = property.kind_of?(String) ? property : property.name    
      if (value = self.instance_variable_get("@#{name}")) == nil
        feature = self.metaclass.getEStructuralFeature(name.to_s)
           
        value = if feature.is_reference?
           initialize_reference(feature) 
        else  # if feature.is_attribute?       
           initialize_attribute(feature)       
        end
        #create_property(name) {  self.instance_variable_get("@#{name}") }
      end
      value
    rescue RMOF::FeatureNotExist => e
      e.object = self
      raise e
    end
=end  

protected
    def create_property(name, &block)
       object_class.send(:define_method, name, &block)
    end

    def object_class
      class << self; self; end
    end
  end
end

module RMOF


  # A model object is a reflective implementation of an object
  # created from a metaclass. 
  #
  class ModelObject
    include ObjectHelper
    include InverseResolvers
    include TypeChecking
    include ObjectLookup
    
    attr_reader :metaclass
  
    # Creates a new model object for a given metaclass.
    #
    # == Arguments
    # * <tt>metaclass</tt>. The metaclass of this model object.
    #
    def initialize(metaclass, initial_values = {})      
      @metaclass = metaclass
      check_abstract_class
      auto_set_features(initial_values)
    end

    METHOD_NAME = /^(\w+)=$/
    def method_missing(method_name, *args)
      return get_from_string(method_name.to_s) if args.size == 0
      return set($1.to_s, args.first) if args.size == 1 && method_name.to_s =~ METHOD_NAME
      raise NoMethodError.new("Invalid method #{method_name}(#{args.size} params)")
    end
  end

end

module RMOF

  # This list takes a property, which must be a reference,
  # and is able to keep the opposite end synchronized.
  # 
  # This kind of lists cannot be used as a normal Ruby Array
  # because it refers to the owner model object.
  #
  class InverseResolvingList < Array
    include InverseResolvers
  
    def initialize(owner, property, *options)
      super(*options)
      @owner = owner
      @property = property
    end
    
    alias_method :old_add, :<<
    def <<(object)
      inverse_resolve(@owner, @property, object)
      old_add(object)
    end
    
    def add_without_inverse(object)
      old_add(object)
    end

    alias_method :old_delete, :delete
    
    def remove_without_inverse(object)
      old_delete(object)
    end
  end

  class ContainmentList < InverseResolvingList  
    def <<(object)      
      object.remove_from_container
      object.set_container(@owner, @property)
      old_add(object)
    end
  end
end

