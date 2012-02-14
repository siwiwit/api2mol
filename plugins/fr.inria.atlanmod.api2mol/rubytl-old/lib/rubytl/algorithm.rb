module RubyTL
  module Rtl
            
    # Implementation of the transformation algorithm. If the transformation
    # has no phases, then this is the transformation algorithm used
    # to evaluate the rules. 
    # If there are phases, then, the same algorithm is applied to evaluate
    # each phase.
    # Therefore, this is the transformation algorithm, and the phase algorithm.
    #
    class Algorithm
      include EventLogging
      attr_reader :transformation
    
      def initialize(transformation, configuration)
        @transformation = transformation
        @status         = configuration.status
        self.tlogger.action_for_event(RubyTL::Rtl::TLogger::RuleConflict, :ignore)
      end
    
      # Starts the transformation execution
      def start
        self.apply_entry_point_rules
      end
    
      # Implementation of the +apply_entry_point_rules+ extension point. It delegates
      # on the +select_entry_point_rules+ extension point to get the entry point rules
      # and the apply those rules at top level.
      def apply_entry_point_rules
        @status.change_phase(@transformation) do 
          rules = self.select_entry_point_rules
          rules.each do |rule|
            rule.execute_at_top_level
          end
        end          
      end
    
      # It resolves a binding by performing the following steps:
      #
      # * If the right part of the binding is an enumerable, then
      #   every element in the enumerable is extracted in order to convert
      #   the binding in a set of n-bindings. It allows the bindings to be
      #   handled in an homogenous way.
      # * If the right part can be directly assigned, then it is assigned
      #   and the binding is already resolved.
      # * In the other case, +select_conforming_rules+ and +evaluate_available_rules+ 
      #   extension points are called.
      #
      def resolve_binding(binding)
        binding.homogenize_enumerable_binding do |binding|                     
          if not binding.is_source_nil?
            if binding.directly_assignable? 
              binding.perform_assignment
            else
              selected = self.select_conforming_rules(binding, transformation.rules)
              self.evaluate_available_rules(binding, selected)  
            end
          end
        end      
      end
    
      # Returns the list of rules able to resolve a given binding
      # 
      # == Arguments
      # * <tt>binding</tt>. The binding to be resolved.
      # * <tt>rules</tt>. Available rules.
      # 
      def select_conforming_rules(binding, rules)
        target_type = binding.target_type
        instance = binding.source_instance
        selected = rules.select do |rule|
          rule.conforms_to?(binding) && rule.pass_filter?(instance)
        end

        selected = [*self.resolve_conflicts(binding, selected)] if selected.size > 1
        selected        
      end
    
      # 
      # It makes tracking links, that is, creates and link the result of the binding
      # before the rule to resolve it has been executed.
      # 
      def evaluate_available_rules(binding, selected)
        log_event(TLogger::NoRuleFound, binding.to_s) if selected.empty? && ! ignore_binding?(binding)
    
        results = selected.map do |rule|
          new_instances = rule.create_and_link(binding.tupleized_source, binding)
          rule.apply(binding.tupleized_source, new_instances)
        end.flatten
      end
          
      # If no rule is selected then the first rule is selected as an
      # entry point rule.
      
      # Selects those entry rules that are the entry points of the
      # transformation (or phase). It selects as entry point rules:
      # * Top rules
      # * The first rule if not top rule is defined.
      def select_entry_point_rules
        log_event(TLogger::EmptyPhase, transformation.name) if transformation.rules.empty?
        selected = transformation.rules.select { |r| r.kind_of?(TopRule) }        
        if selected.empty?
          selected << transformation.rules.first
        end
        selected
      end
    
      def resolve_conflicts(binding, rules_in_conflict)
        text = "xxxx.#{binding.target_type.name} = #{binding.source_type}:" + $/ + rules_in_conflict.map { |r| r.name }.join($/)
        log_event(TLogger::RuleConflict, rules_in_conflict.size, text)
        rules_in_conflict
      end
      
      # Checks whether a binding must be ignored when there is no rule applicable.
      def ignore_binding?(binding)
        transformation.ignore_rules.any? { |r| r.ignore?(binding) }        
      end
    end
  end
end

