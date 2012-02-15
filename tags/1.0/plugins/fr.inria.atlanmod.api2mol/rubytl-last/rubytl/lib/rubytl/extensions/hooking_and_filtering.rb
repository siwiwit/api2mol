#
# Convenient classes and mixin to define hooks and filters
# to be used both in the definition of new extension points
# and in the classes that invoke those extension points.
# 

#module RubyTL
  module Plugins  
    # Provides filtering capabilites
    module Filtering
      
      def define_filter(filter_name)              
        eval(%{
       
        def #{filter_name}_filter
          @@#{filter_name}_filter ||= []
          @@#{filter_name}_filter
        end
        
        def append_#{filter_name}_filter(method_name = nil, &block)
          filter = LazyBlock.new(method_name, &block)
          #{filter_name}_filter << filter
        end     
        
        def remove_#{filter_name}_filter(method_name)
          element = #{filter_name}_filter.find { |filter| filter.use_method?(method_name) }
          raise "No filters deleted " + method_name.to_s unless element
          #{filter_name}_filter.delete(element)
        end
        })
      end
    end

    # Helper methods to ease the calling of hooks and filters
    module HookFilterHelper
      def check_respond_and_send(object, method_name, *args)
        raise "Extension #{method_name} must exist" if not object.respond_to?(method_name)
        object.send(method_name, *args)               
      end
      
      def call_filter(object, filter_name, *args)
        klass = object.class
        #klass = RubyTL::Plugins::Rule if object.kind_of? RubyTL::Plugins::Rule # TODO: �Por qu� no se heredan los filtros?

        klass.send("#{filter_name}_filter").each do |filter|
          filter.call(object, *args)
        end
      end        
    end    

    # 
    #
    module AlgorithmHooks
      include HookFilterHelper
      
      # Before de transformation starts a filter is called in order to allow
      # plugins to peform global actions over the transformation
      def transformation_start  
        call_filter(self, :transformation_start)        
      end
      
      # Start the transformation algorithm by applying the entry point 
      # rules.       
      def apply_entry_point_rules
        check_respond_and_send(self, :on_apply_entry_point_rules)
      end
    
      # This step is in charge of looking up a rule which makes possible
      # to transform the right part of the binding in the left one.
      # It delegates in an extension point that must be named 
      # +on_resolve_binding+, and must be an extension of the Algorithm class.
      # 
      # == Arguments
      # * <tt>binding</tt>. A Binding object. 
      #                     
      # == Returns
      # Nothing.
      #
      # == Example
      # Calling <tt>delegate.resolve_binding(abinding)</tt> yields to
      # the execution of the extension point <tt>on_resolve_binding</tt> 
      # specified by something like this
      #
      # class Algorithm
      #    ...
      #
      #    def on_resolve_binding(binding)
      #      selected = @delegate.select_conforming_rules(binding)     
      #      @delegate.evaluate_available_rules(binding, selected)
      #    end
      #
      #    ...
      # end
      # 
      # In this example, binding resolution is performed by delegating
      # in another extension points
      #
      def resolve_binding(binding)
        check_respond_and_send(self, :on_resolve_binding, binding)
      end
    
      # Return the list of available rules for a given binding
      def select_conforming_rules(binding)
        rules = @transformation.rules.dup
        call_filter(self, :before_select_conforming_rules, binding, rules)
        selected = check_respond_and_send(self, :on_select_conforming_rules, binding, rules)
        selected
      end
    
      # Evaluate available rules, usually the rules selected by +available_rules+
      def evaluate_available_rules(binding, selected)
        check_respond_and_send(self, :on_evaluate_available_rules, binding, selected)
      end
    
      # Given a set of rules it resolve a conflict by selecting
      # one or more rules between the conflicting ones.
      def resolve_conflicts(binding, selected)
        check_respond_and_send(self, :on_resolve_conflicts, binding, selected)
      end
    
      # Select those rules suitable for being entry point rules
      def select_entry_point_rules    
        rules = []
        call_filter(self, :entry_point_selection, rules)
        rules
      end    
    end  
    
    
    # A module to provide a rule class the capability to delegate 
    # the execution in a plugin.
    #
    module RuleLifeCycle
      include HookFilterHelper
    
    
      def apply_rule_step(source, targets)        
        call_filter(self, :before_application, source, targets)
        check_respond_and_send(self, :on_application, source, targets)
        call_filter(self, :after_application, source, targets)
      end
       
      def before_rule_definition_step
        call_filter(self, :before_definition)
      end
      
      def after_rule_definition_step
        call_filter(self, :after_definition, self)
      end
 
      def create_and_link_step(source_element, binding)
        call_filter(self, :before_create_and_link, source_element, binding)
        result = check_respond_and_send(self, :on_create_and_link, source_element, binding)      
        call_filter(self, :after_create_and_link, source_element, result, binding)
        result
      end

      def check_conformance_step(binding)
        check_respond_and_send(self, :on_check_conformance, binding)      
      end
 
      def rule_definition_step
        # TODO: Quiero que me diga el n�mero de l�nea en el que aparecio la regla no definida (__LINE__)
        # raise "Rule '#{rule[:kind]}' not defined'" if not self.class.extensions.rule_by_kind[rule[:kind]]
        
        # TODO: Esto se puede generalizar para que los propios plugins
        # sean los que meten los datos a sintaxis definidas en su �mbito
        # @owner.syntax.evaluate_syntax(:rule, rule)      
        # �PARA QU� ERA ESTO, LO HE QUITADO PERO NO SE SI ES CORRECTO?

        # TODO: Revisar        
        self.on_definition if self.respond_to? :on_definition
        self.after_definition if self.respond_to? :after_definition # TODO: Poner en un filtro
      end        
    end
      
  end      
#end
