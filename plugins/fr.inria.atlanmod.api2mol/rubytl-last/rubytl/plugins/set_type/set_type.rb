
class Rule
  append_after_create_and_link_filter :link_set_type
  append_after_application_filter :add_trace_information
  
  def link_set_type(source, targets, binding = nil)
    targets.select { |t| t.respond_to?(:i_am_a_set) }.each do |set|
      set.binding = binding
      set.rule = self
      set.transformation = self.transformation
    end  
  end
  
  def add_trace_information(source_element, targets)
  	targets.select { |t| t.respond_to? :i_am_a_set }.each do |v|
	    	@status.add_trace([*source_element], v, self)    	
  	end
  end
end

#remove_const("Set") if const_defined?("Set")
module SetPlugin
class Set < Array
    def i_am_a_set
      true
    end
       
    attr_writer :binding
    attr_writer :rule
    attr_writer :transformation
    
    # puts self.respond_to?(:old_add)
    alias_method :old_add, :<< unless self.respond_to?(:old_add)
    
    def <<(value)
      old_add(value)
      @rule.link_helper(value, @binding) if (@binding && @rule)
    end
    
end
end

# TODO: Use syntax extensions...
class ::Object
    def Set(klass)
        setClass = Class.new(SetPlugin::Set)
        setClass.module_eval %{
          @@prop = ::EMOF::Property.new
          @@prop.xmi_id = "rubytl.set.add_value" 
      
          def self.klass=(value)
            @@metaclass = value
            @@prop.set(::EMOF::TypedElement.property_by_name("type"), value , true)
          end
          
          def self.metaclass
            @@metaclass
          end        

        def values=(array)
            [*array].each do |instance|
                # self << instance
              if instance.isInstanceOf(@@metaclass)
                self << instance 
              else
                binding = RubyTL::BindingAssignment.new(self, instance, 'add_value')       
                @transformation.resolve_binding(binding)
              end
            end
        end
        
        def metaclass
          self.class
        end
        
        def set_reference_value(feature, instances)
          if feature == @@prop
            [*instances].flatten.each do |i|
              self << i
            end
          else
            raise 'No property exist ' + feature.to_s + ' in Set'
          end 
        end
        
        def values
          self
        end
    
        def self.property_by_name(name)
          return @@prop if name == 'add_value'
          raise 'No property ' + name + ' found'
        end
        
        def self.conforms_to(target_klass)
          @@metaclass.conforms_to(target_klass)      
        end
    
        }
        setClass.klass = klass
        setClass
    end  
end
=begin
      new_method = <<-END_OF
        def #{rule.keyword}(name, &block)                
          add_rule(:#{rule.kind}, name, &block)
        end
      END_OF
      Module.class_eval(new_method)
    # Construye un tipo conjunto para una determinada metaclase

class Module

end
=end

=begin
            rule = RuleManager.search_rule_for(@@metaclass)
            values = rule.apply(instance)
            values.each do |value|
                # Aplanar el resultado para guardarlo porque es posible
                # que haya un Set
                [*value].each do |v|
                    self << v
                end
            end
=end        
