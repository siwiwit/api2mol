
module RubyTL
  module Base

    # This class maintain strategies to be used by a proxy builder
    # when creating the proxy and creating new objects.
    #
    # Supported strategies:
    # * <tt>Creation strategies</tt>. Implements create(object, initial_values)
    # * <tt>Adapting strategies</tt>. Implements alter(object, proxy)
    # * <tt>Filling strategies</tt>.  Implements fill(object)
    #
    class StrategyProvider
      attr_reader :creation_strategies
      attr_reader :adapting_strategies
      attr_reader :filling_strategies
      attr_reader :metaclass_strategies
      
      def initialize()
        @creation_strategies = []
        @adapting_strategies = []
        @filling_strategies  = []
        @metaclass_strategies = []
      end
      
      def add(strategy)
        self.creation_strategies  << strategy if strategy.respond_to? :create 
        self.adapting_strategies  << strategy if strategy.respond_to? :alter
        self.filling_strategies   << strategy if strategy.respond_to? :fill
        self.metaclass_strategies << strategy if strategy.respond_to? :adapt_metaclass_proxy
      end
      
      def merge(other_provider)
        provider = StrategyProvider.new
        provider.creation_strategies.push(*(self.creation_strategies + other_provider.creation_strategies))
        provider.adapting_strategies.push(*(self.adapting_strategies + other_provider.adapting_strategies))
        provider.filling_strategies.push(*(self.filling_strategies + other_provider.filling_strategies))                
        provider.metaclass_strategies.push(*(self.metaclass_strategies + other_provider.metaclass_strategies))
        provider
      end
      
      def alter_object(object, proxy)
        @adapting_strategies.each { |s| s.alter(object, proxy) }
      end
      
      def create_object(object, initial_values)
        @creation_strategies.each { |s| s.create(object, initial_values) }
      end
      
      def fill_with_object(object)
        @filling_strategies.each { |s| s.fill(object) }
      end
      
      def adapt_metaclass_proxy(proxy)
        @metaclass_strategies.each { |s| s.adapt_metaclass_proxy(proxy) }
      end
    end

    # This is both a creation and filling strategy, which is in charge of 
    # adding an object to the list of "all_objects" in the corresponding
    # superclasses.
    #
    # It depends on the TagProxyStrategy.
    #
    class KeepAllObjectsStrategy
      def initialize(proxy_coordinator)
        @proxy_coordinator = proxy_coordinator
      end
         
      # It delegates in the +fill+ method. 
      def create(object, initial_values)
        fill(object)
      end
      
      def fill(object)       
        metaclass = object.metaclass
        metaclass.all_super_types.reverse.each do |super_metaclass|         
          proxy = @proxy_coordinator.query_metaclass_proxy(super_metaclass)
          proxy.__add_object(object) if proxy
        end
      end            
    end
    
    class AdaptToRUMI
      def alter(object, proxy)
        if object.respond_to?(:is_primitive?) && object.is_primitive?
          object.extend(RubyTL::RumiRMOF::PrimitiveTypeInterface)
        else
          object.extend(RubyTL::RumiRMOF::ModelObjectInterface)
        end
        
        object.virtual_klass = proxy               
      end
    
    end
    
    class ModifySetMethod
      #def fill(object)
      #  alter(object, nil)
      #end
      
      def alter(object, proxy)
	      #is_module = object.kind_of?(Module)     
	      is_module = object.class == Module
	      object.instance_eval do
	        class << self
	          alias_method :old_set, :set if method_defined?(:set)
	        
	          def set(property, value, resolve_inverse = true)
	            if value.kind_of?(Array)
	              value.each { |v| set(property, v, resolve_inverse) }
	              return
	            end
	            return if value.nil?
	            old_set(property, value, resolve_inverse)
	          end
	        end        
	      end unless is_module # When loading an ECORE metamodel, the ECore::EBoolean is not a class...
      end
    end   
    
    # Strategy to set the model id for model objects
    class SetModelId
      def initialize(model_id)
        @model_id = model_id
      end
      
      def alter(object, proxy)
        object.instance_variable_set("@__model_id__", @model_id)
        def object.model_id; @__model_id__; end 
      end
      
      def adapt_metaclass_proxy(proxy)
        proxy.rumi_model_id = @model_id
      end        
    end
    
    class IncludeBindingSemantics # TODO: Put in the RubyTL package
      BINDING_VAR = "@__binding_semantics_for_rubytl__"
      
      def initialize(&block)
        @binding_semantics = block
      end
      
      def alter(object, proxy)
        variable = "@__bindings_text_for_rubytl__"
        bindings_text = proxy.instance_variable_get(variable)
        if ! bindings_text
          bindings_text = create_binding_text(proxy)
          proxy.instance_variable_set(variable, bindings_text)
        end
        object.instance_eval(bindings_text, __FILE__, __LINE__) 
        object.instance_variable_set(BINDING_VAR, @binding_semantics)              
      end
      
      def create_binding_text(proxy)
        return proxy.all_references.map do |reference|
           new_method = <<-METHOD 
             def #{reference.name}=(value)
               binding = RubyTL::Rtl::BindingAssignment.new(value, self, '#{reference.name}')
               #{BINDING_VAR}.call(binding)
             end
           METHOD
         end.join        
      end
      
    end
  end
end