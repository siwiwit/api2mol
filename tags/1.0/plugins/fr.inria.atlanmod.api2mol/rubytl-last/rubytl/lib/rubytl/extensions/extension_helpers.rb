module RubyTL
  module Plugins
=begin  
    # == RuleActionsHelper
    #
    # Module providing utility methods to be used in rules.
    #  
    module RuleActionsHelper

      # Creates one instance per +to_metaclass+ (using +create_helper+). 
      # If a binding is given, the elements are linked against the 
      # target element's property.
      #
      # == Arguments
      # * <tt>binding</tt>
      # * <tt>source_elements</tt>
      #
      def create_and_link_helper(binding, source_elements = nil)
        new_instances = create_helper    
        link_helper(new_instances, binding, source_elements) if binding    
        new_instances
      end        

      # Creates one instance per +to_metaclass+. It returns an array
      # with the new instances.
      def create_helper
        self.to_metaclasses.map { |to_metaclass| to_metaclass.new }      
      end

      # Link instances, and adds trace information.
      #  
      def link_helper(new_instances, binding, source_elements = nil)
        binding.left_instance.set_reference_value(binding.feature, new_instances)
        if source_elements
          [*source_elements].each do |element|
            element.add_trace_information(binding.left_instance => new_instances)
          end          
        end
      end
          
      def evaluate_mapping_helper(source, target)
        self.mapping.evaluate(source, target) if self.mapping
      end      
    end
=end    
    # This mixin module is intended to provide access to shared
    # objects useful to modify the DSL in runtime and to gather
    # information about the transformation.
    #
    module ContextInformation
      # Provide runtime access to the syntax of the language, 
      # even allowing the DSL syntax to be modified.
      attr_reader :syntax
      
      # Provide access to the transformation object, which contains
      # the list of rules.
      attr_reader :transformation
      
      # Provide access to the transformation status. It can also be
      # accessed by +transformation.status+     
      attr_reader :status      
      
      def load_context_information(context)
        @context = context
        @transformation = context.transformation_
        @status = context.transformation_.status
        @syntax = context.syntax   
        @parameters = context.plugin_parameters   
      end
    end
  end 
end
