#--
#
# Implementation of the phasing mechanism as described in 
#   "A phasing mechanism for model transformation languages"
#   J. Sánchez, J. García. ACM/SAC 2007, MT Track
#
# author: jesus
#++

class RefinementRule < TopRule
  rule_keyword 'refinement_rule'
  
  # A refinement rule never create elements, just link them
  # if necessary,
  # 
  def on_create_and_link(source_element, binding)
    if @conforming_real_matches
      @conforming_real_matches.each do |targets|
        link_helper(targets, binding, source_element) if binding
      end
      @conforming_real_matches
    end
  end

  def on_application(source_element, target_elements)
    evaluate_mapping_helper(source_element, target_elements)
    return target_elements    
  end

  alias_method :old_check_conformance, :on_check_conformance
  def on_check_conformance(binding)
    return false unless old_check_conformance(binding)
    
    single_instance = binding.source_instance
    if single_instance.respond_to? :size
      raise "In this moment only one source instance is supported" if single_instance.size > 1
      single_instance = single_instance[0]
    end
    
    possible_matches = @status.transformed_by_source(single_instance)
    return false if possible_matches.nil?
    
    real_matches = compute_real_matches(possible_matches, single_instance)  

    @conforming_real_matches = real_matches
    return real_matches.size > 0    
  end

  alias_method :old_execute_at_top_level, :execute_at_top_level

  # Execute the rule at top level.
  #
  def execute_at_top_level
    self.old_execute_at_top_level do |instances|
      raise ::RubyTL::PhasingError.new("In this moment only one source instance is supported") if instances.size > 1
      single_instance = instances[0]

      # Compute possible matches, and filter them
      possible_matches = @status.transformed_by_source(single_instance)
      next if possible_matches.nil?
       
      # Quick hack
      real_matches = compute_real_matches(possible_matches, single_instance)  
      real_matches.each do |target_instances|
        self.apply(single_instance, target_instances) if pass_filter?([single_instance] + target_instances)
      end
    end
  end

  def compute_real_matches(possible_matches, single_instance)
    instances_by_type = possible_matches.map { |e| e }.uniq.group_by { |c| c.metaclass }

    # TODO: Hack. To solve it homogeneize metaclass representation (maybe with methods such as equal...)
    self.to_metaclasses.map(&:real_klass).uniq.each do |metaclass|
      if not instances_by_type.key?(metaclass)
        instances_by_type.each_pair do |subclass, instances|
          if subclass.all_super_types.include?(metaclass)
            instances_by_type[metaclass] ||= []
            instances_by_type[metaclass] += instances 
          end
        end
      end

    end

    result = []
    make_type_permutations(self.to_metaclasses.map(&:real_klass), instances_by_type) do |value|
      result << value
    end
    result
  end

  # Duplicated
  def make_type_permutations(types, instances_by_type, values = [], used = {}, &block)
    
    if types.size == 2
      unloop2(types, instances_by_type, values, used, &block) 
      return
    elsif types.size == 0
      yield(values)
      return
    end

    type = types.first
    return unless instances_by_type[type] # Verify this return is correct
    instances_by_type[type].each do |instance|     
      unless used.key?(instance)
        used[instance] = true
        make_type_permutations(types[1..-1], instances_by_type, values + [instance], used, &block)
        used.delete(instance)
      end
    end
  end

  # Permutations of two elements.
  def unloop2(types, instances_by_type, values = [], used = {}, &block)
    return if ! instances_by_type[types[0]] || ! instances_by_type[types[1]] 
    instances_by_type[types[0]].each do |instance0|
      next if used[instance0]
      instances_by_type[types[1]].each do |instance1|
        unless used[instance1] || instance0 == instance1
            yield(values + [instance0, instance1])
        end
      end
    end
  end
=begin
  def compute_real_matches(possible_matches, single_instance)
    possible_matches = possible_matches.dup
    puts possible_matches.size
    possible_matches.each do |p| puts p.metaclass.name end
    real_matches = []
    while not possible_matches.empty?   
      used = []
      previous_used_size = used.size
      self.to_metaclasses.each do |metaclass|
        possible_matches.each do |instance|
          # Is an instance of metaclass or of one of its subclasses?
          if instance.metaclass.conforms_to(metaclass) &&
             ! used.include?(instance) 
            used << instance
            break
          end    
        end

        if used.size == previous_used_size 
          break # There is no match since no element has been selected in this iteration
        end
        previous_used_size = used.size
      end

      if used.size == self.to_metaclasses.size        
        # There is a complete match, check if it fulfill the rule filter
        if self.pass_filter?([single_instance] + used)       
          real_matches << used.dup
        end
        # TODO: puts rule # a strange error related to rake...
      end
        
      possible_matches.shift # 
    end  
    real_matches
  end
=end
end

# Syntax extension to describe the syntax of phases.
#
#
class PhasingSyntax < SyntaxExtension  
  Phase = Struct.new(:name, :rules)
  
  syntax :phase do
    scope :transformation
    nested_elements :mandatory
    parameters :name        
    callback :new_phase
  end
  
  syntax :depend do
    scope :phase
    parameters '*args'
    callback :set_dependency
  end

  def new_phase(*values, &block)
    name = values[0].to_s
   # block = values[1]
    phase = Phase.new(name, [])
    
    @transformation[:phases] ||= []
    @transformation[:phases] << phase
  
    # TODO: Improve this (inner elements should notify upper elements, in some way)
    Rule.append_after_definition_filter :rule_notify_phase_filter do |rule|
      rule_notify_phase_filter(rule)
    end
    yield
    Rule.remove_after_definition_filter :rule_notify_phase_filter        
  end
  
  def rule_notify_phase_filter(rule)
    phase = transformation[:phases].last
    rule[:phase] = phase.name.to_s
    phase.rules << rule            
  end
end

# Algorithm modification 
#
#
class Algorithm
  alias_method :old_entry_point, :on_apply_entry_point_rules

  # Implementation of the +apply_entry_point_rules+ extension point. It delegates
  # on the +select_entry_point_rules+ extension point to get the entry point rules
  # but also use phasing.
  def on_apply_entry_point_rules
    entry_point_rules = self.select_entry_point_rules

    # Group entry point rules according with its phase
    groups = entry_point_rules.group_by { |rule| rule[:phase] }  

    @rules_with_the_same_name = @transformation.rules.group_by { |rule| rule.name }   

    raise ::RubyTL::PhasingError.new("No phase defined in the transformation definition") if @transformation[:phases].nil?

    # TODO: The UI DSL should ensures that switched_off_phases have a default value...
    off_phases    = (@parameters[:switched_off_phases] || []).map { |p| p.to_s }
    active_phases = @transformation[:phases].reject { |phase| 
      off_phases.include?(phase.name.to_s)
    }
    active_phases.each do |phase|            
      # Mark current phase
      @transformation[:current_phase] = phase.name
      rules = groups[phase.name]
      raise ::RubyTL::PhasingError.new("No top rules defined for phase '#{phase.name}'") if rules.nil?

      rules.each do |rule|

        rule.execute_at_top_level do |instance|   
          if rule.pass_filter?(instance)
            result = rule.create_and_link(instance)
            rule.apply(instance, result) 
          end                
        end      
      end      
    end
  end

#  alias_method :old_on_evaluate_available_rules, :on_evaluate_available_rules
#  def on_evaluate_available_rules(binding, selected)
#    selected.each do |rule|
#      result = find_already_transformed(rule, binding.tupleized_source)
#      result = rule.create_and_link(binding.tupleized_source, binding) if not result
#      rule.apply(binding.tupleized_source, result)
#    end
#  end

  append_before_select_conforming_rules_filter :select_current_phase_rules    
  def select_current_phase_rules(binding, availables)
#    puts "select for #{@transformation[:current_phase]}"
    not_valid = availables.select { |rule| rule[:phase] != @transformation[:current_phase] }  
    not_valid.each do |r|
#      puts "    Elimino #{r.name}"
      availables.delete(r)
    end  
#    availables.each do |r| puts r.name end
  end  

end

class ::RubyTL::PhasingError < RubyTL::EvaluationError
  include ::RubyTL::BacktraceHandling
  def initialize(message)
    @message = message
  end

  def message    
    @message
  end  
end
