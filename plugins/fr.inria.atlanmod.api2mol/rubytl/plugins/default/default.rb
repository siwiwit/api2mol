
class DefaultRule < Rule
  
#  syntax_definition do
#    keyword 'rule' do
#      param 'name', :id
#      keyword 'from'
#      keyword 'to'
#      keyword 'filter'
#      keyword 'mapping'
#    end
#  end
  
  rule_keyword 'rule'
  attr_reader :transformed

  def on_definition
    @transformed = Hash.new
  end
  
  def on_create_and_link(source_element, binding)
    targets = @transformed[source_element]    
    if not targets
      targets = create_and_link_helper(binding, source_element)
    else
      link_helper(targets, binding, source_element) if binding   
    end
    return targets
  end
  
  def on_application(source_element, target_elements)

    # If the source_instance has not been already 
    # transformed by this rule, the new targets are
    # annotated as already created and the mapping
    # is evaluated
    if not @transformed.key?(source_element)
      if target_elements.flatten.size > 0
        @status.add_trace([*source_element], target_elements, self)  
      end
    
      @transformed[source_element] = target_elements
      evaluate_mapping_helper(source_element, target_elements)
    end
    return target_elements    
  end

#  append_after_application_filter :add_trace_information
#  def add_trace_information(source_element, targets)
#    if targets.flatten.size > 0
#      @status.add_trace([*source_element], targets, self)  
#    end

#  	targets.select { |t| t.respond_to? :i_am_a_set }.each do |v|
#    	@status.add_trace([*source_element], v, self)    	
#  	end
#  end


  # Check if a rule is conforming with a source type and a target type,
  # so that it can be used to resolve a binding. Conformance rules
  # are the following:
  #
  # * A class A is conforming with another class B, if an object of type A
  #   can be assigned to a variable of type B. Therefore A == B, or A is a 
  #   subclass of B.
  # * A rule conforms to a binding if the binding source_klass conforms to
  #   the rule source class (i.e. the binding source instance can be used
  #   as the rule source instance), and if all rule target classes conforms 
  #   to the binding target class (i.e. the rule results can be assigned to
  #   the target property).
  # * If the source class is an enumerable (that is, a collection), the rule
  #   is supposed to be conforming if all rule target classes conforms 
  #   to the binding target class, and IF for each rule source class there exist at
  #   least one element in the enumerable whose class conforms with such source class.
  #   Notice, that is the enumerable consist of tuples then...
  #
  # == Arguments
  # * <tt>binding</tt>. The binding. 
  #
  def on_check_conformance(binding)
    instance     = binding.source_instance
    source_class = binding.source_class
    target_class = binding.target_class    

    raise "Too many from metaclasses #{self.from_metaclasses}" if self.from_metaclasses.size > 1
    return DefaultRule.target_conforms?(self.to_metaclasses, target_class) && 
           DefaultRule.source_conforms?(self.from_metaclasses.first, source_class) # creo que esto no tiene sentido
  end

  def self.target_conforms?(rule_klass, target_class)
    [*rule_klass].all? { |c| c.conforms_to(target_class) }
    #all_conforms?(rule_klass) { |c| c.conforms_to(target_class) }
  end
  
  def self.source_conforms?(rule_klass, source_class)
    source_class.conforms_to(rule_klass)
  end
  
private
  def self.all_conforms?(rule_klass, &block)
    rule_klass.kind_of?(Enumerable) ? 
      rule_klass.all? { |c| all_conforms?(c, &block) } :
      yield(rule_klass)  
  end
end

=begin
class Algorithm

  # Implementation of the +apply_entry_point_rules+ extension point. It delegates
  # on the +select_entry_point_rules+ extension point to get the entry point rules
  # and the apply those rules at top level.
  def on_apply_entry_point_rules
    rules = self.select_entry_point_rules
    rules.each do |rule|
      rule.execute_at_top_level
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
  def on_resolve_binding(binding)
    homogenize_enumerable_binding(binding) do |binding|   
      if not binding.is_right_nil?
        if binding.directly_assignable? 
          binding.perform_assignment
        else
          selected = self.select_conforming_rules(binding)
          self.evaluate_available_rules(binding, selected)  
        end
      end
    end      
  end

  # Returns the list of available rules for a given binding
  def on_select_conforming_rules(binding, rules)
    target_type = binding.left_type
    instance = binding.right_instance
    selected = rules.select do |rule|
      rule.conforms_to(binding) && rule.pass_filter?(instance)
    end
    selected = [*self.resolve_conflicts(binding, selected)] if selected.size > 1
    selected        
  end

  # 
  # It makes tracking links, that is, creates and link the result of the binding
  # before the rule to resolve it has been executed.
  # 
  def on_evaluate_available_rules(binding, selected)
    raise NoRuleFoundError.new(binding) if selected.empty?

    results = selected.map do |rule|
      new_instances = rule.create_and_link(binding.tupleized_source, binding)
      rule.apply(binding.tupleized_source, new_instances)
    end.flatten
  end
  
  # Filter to retrieve entry point rules
  append_entry_point_selection_filter :default_rule_selection  

  # If no rule is selected then the first rule is selected as an
  # entry point rule.
  def default_rule_selection(selected)
    raise ::RubyTL::EmptyTransformation.new if transformation.rules.empty?
    if selected.empty?
      selected << transformation.rules.first
    end
  end


  def on_resolve_conflicts(binding, rules_in_conflict)
    raise RubyTL::ConflictingRules.new(binding, rules_in_conflict)
  end

protected

  # Makes a binding whose right part is an enumerable acts as if n-bindings,
  # one for each instance in the enumerable, would exist.
  #
  # == Arguments
  # * <tt>binding</tt>. A BindingAssigment object.
  # * <tt>block</tt>. The block is yield for each single instance.
  #
  # == Example
  # Given a +BindingAssigment+ object, +b+ taken from a binding like
  # +left.property = [r1, r2, r3]+, 
  #
  #    homegenize_enumerable_binding(b) do |binding|
  #      puts binding
  #    end
  #
  #    ==> left.property = r1
  #    ==> left.property = r2
  #    ==> left.property = r3
  #
  def homogenize_enumerable_binding(binding, &block)
    left_instance = binding.left_instance
    right_instance = binding.right_instance
    feature = binding.feature

    if right_instance.kind_of?(Enumerable) && !right_instance.kind_of?(String)
      right_instance.each do |i|
        homogenize_enumerable_binding(RubyTL::BindingAssignment.new(left_instance, i, feature), &block)          
      end
    else
      yield(binding)        
    end    
  end
    
end

class ::RubyTL::EmptyTransformation < RubyTL::BaseError
  def initialize; end
  def message
    "Transformation without rules"
  end
end

class ::RubyTL::NoRuleFoundError < RubyTL::EvaluationError
  include ::RubyTL::BacktraceHandling
  def initialize(binding)
    @binding = binding
  end
  
  def message
    "No applicable rules found to resolve #{@binding}" #\n#{suggestion}"
  end  
  
  def suggestion
    left_type = @binding.target_class
    right_type = @binding.source_class
  
#    suggestion = ::RubyTL::Suggestion.new
#    suggestion.title = 'You can use this rule'
#    suggestion.alternatives << %{
     %{
rule '#{right_type.name}2#{left_type.name}' do
  from 
  to
  mapping do |source, target|
        
  end 
end
}
  end
end

class ::RubyTL::ConflictingRules < RubyTL::EvaluationError
  include ::RubyTL::BacktraceHandling
  def initialize(binding, rules)
    @binding = binding
    @rules = rules
  end

  def message    
    "There are #{@rules.size} conflicting rules to resolve xxxx.#{@binding.left_type.name} = #{@binding.right_instance.class}:" + $/ +
            @rules.map { |r| r.name }.join($/)  
  end  
end
=end