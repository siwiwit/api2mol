# == Many-To-One plugin
#
# This plugin allows RubyTL to perform mappings between N source to elements
# to 1 target element. Actually, it allows N:N mappings if used with +set_type+
# plugin.
# 
# This plugin extends the language in several ways:
#
# * It extends the binding concept to detect patterns of N elements.
# * It provides a '**' operator that makes the cartesian product of two enumerables.
#   This product is used to merge different model elements.
# * The usual behaviour of the algorithm is changed, rule conformance, filter checking
#   and rule evaluation is all done at once. The reason is simply to improve efficiency.
#
# == Example
#
#    rule 'java2class' do
#       from     JavaM::JavaClass
#       to       ClassM:Class
#       mapping  do |javaclass, class|
#          class.name = javaclass.name
#          class.fields = javaclass.features
#       end
#    end
#
#    rule 'features2field' do
#       from     JavaM::Method, JavaM::Method, JavaM::Field
#       to       ClassM::Field
#       filter   do |set, get, field|
#          (set.name =~ /set(\w+)/ && $1 == field.name) &&
#          (get.name =~ /get(\w+)/ && $1 == field.name)
#       end
#       mapping do |set, get, field, class_field|
#          class_field.name = field.name
#          class_field.type = field.type
#       end
#    end
# 
#
# == Merging models example
# Let's assume that RubyTL can manage two input models (although the following is also true
# for only one input model). A merge operator (o cross product) is the binary '**' operator
# and it makes the cross product of two collections of objects. The following example shows
# the merging of two class models based on the certain (still inexistent) heuristics.
#
#   input  'ClassM1' => 'file://classm.emof'
#   input  'ClassM2' => 'file://classm.emof'
#   output 'Output'  => 'file://classm.emof'
# 
#   rule 'merge-classes' do
#     from  ClassM1::Class, ClassM2::Class
#     to    Output::Class
#     filter { |c1, c2| classes_are_equivalent?(c1, c2) } 
#     mapping do |c1, c2, output|
#       output.name = common_name(c1, c2)
#       output.features = c1.features ** c2.features  # <=== merge operator!!
#     end
#   end
#
#   rule 'merge-features' do
#     from  ClassM1::Feature, ClassM2::Feature
#     to    Output::Feature
#     filter  { |f1, f2| features_are_equivalente?(f1, f2) }
#     mapping do |f1, f2, output|
#        output.name = common_name(f1, f2)
#        output.type = common_type(f1, f2)
#     end
#   end
#


# == Modifying the default rule
# 
# Modifies the default conformance checking in order to avoid problems
# with rules with more than one metaclass in the from part. Old check conformance
# used to raise an exception in these cases. Since this plugin allows us to
# have N from metaclasses, such error must not be raised.
#
class DefaultRule < Rule
  alias_method :old_check_conformance, :on_check_conformance

  def on_check_conformance(binding)
    self.from_metaclasses.size == 1 && old_check_conformance(binding)
  end
  
end

# == Modifying the default algorithm
# 
# The default algorithm is modified in several ways.
# 
# 1. A +transformation_start_filter+ is implemented to calculate some
#    values that will be used through the whole transformation.
# 2. The +on_resolve_binding+ method is completely rewritten to perform
#    conformance, filtering and application as a whole. If the binding is not
#    many-to-one, then the old resolve binding hook is used (yielding to default
#    behaviour).
# 3. Some methods are written to deal with permutations efficiently (i hope so!).
#
class Algorithm
  alias_method :old_resolve_binding, :on_resolve_binding
  append_transformation_start_filter :do_when_transformation_start

  # This filter group the set of rule in a hash, so that they can be accessed
  # by the number of elements in its from part.
  def do_when_transformation_start
    @rules_by_from_size = @transformation.rules.group_by { |r| r.from_metaclasses.size }      
  end

  # Overrides the default implementation of the +on_resolve_binding+ hook
  # in the following way:
  # 
  # * The old version of resolve binding (method aliased as +old_resolve_binding+)
  #   is always performed first.
  # * A new method +resolve_many_to_one+ is called if the right part is a
  #   collection type (an enumerable), so that, many to one mappings can
  #   be performed.
  # * For many-to-one bindigns (or with merging by '**') checking conformance,
  #   checking the filter and applying the rule is done as a whole.
  #
  def on_resolve_binding(binding)        
    if binding.source_instance.kind_of?(TupleArray)
       resolve_crossed_many_to_one(binding) 
    else
      begin
        resolve_many_to_one(binding) if binding.source_instance.kind_of?(Enumerable) && !binding.source_instance.kind_of?(String)   
        old_resolve_binding(binding)
      rescue RubyTL::NoRuleFoundManyToOneError => e
        old_resolve_binding(binding)
      rescue RubyTL::NoRuleFoundError => e
        # Do nothing because a many-to-one mapping has been resolved by some rule
        #raise "Rule not
      end
    end
  end 
  
protected
 
  # Resolve a binding which right part is a TupleArray, that is, an array
  # composed of tuple objects, probably because the ** operation has been performed
  # between two or more arrays.
  def resolve_crossed_many_to_one(binding)
    any = false
    binding.source_instance.each do |tuple|
      (@rules_by_from_size[tuple.size] || []).each do |rule|
        if tuple_conformance(rule, tuple)
          applied = try_to_apply(rule, binding, tuple) 
          any = true if applied
        end
      end
    end
    # raise RubyTL::NoRuleFoundManyToOneError.new(binding) if not any  
    # TODO: Should it be raised?
  end

  # Check if a tuple with values is conforming to the rule from metaclasses.
  def tuple_conformance(rule, tuple)    
    (0...tuple.size).all? { |i| 
      DefaultRule.source_conforms?(rule.from_metaclasses[i], tuple.tuple_type[i]) 
     }
  end

  # To resolve a many-to-one binding, the following steps are followed:
  #
  # * Rules with more than one element in the <tt>from part</tt> and whose target 
  #   conforms are selected
  # * The right part of the binding (list of source elements) is traversed to
  #   to collect all types. These types are used to further filter the list of
  #   available rules, and to improve the permutations done next.
  # * Now, the rules and its from classes are used to permute all source elements
  #   and try to apply such rules
  #
  def resolve_many_to_one(binding)  
    many_to_x_rules                    = select_target_conforming(binding, @transformation.rules) 
    many_to_x_rules, instances_by_type = select_source_conforming(binding, many_to_x_rules)

    many_to_x_rules.each do |rule|
      make_type_permutations(rule.from_metaclasses, instances_by_type) do |values|
        try_to_apply(rule, binding, values)
      end
    end
  end

  # Try to apply a rule, given the set of source instances. Before applying the rule,
  # it checks the filter, and it is applied.
  # Notice that rule conformance is assumed to be hold, since the permutations algorithm
  # has used conformance information to speed up.
  def try_to_apply(rule, binding, values)
    if rule.pass_filter?(values)
      tuple = values.tupleize
      new_instances = rule.create_and_link(tuple, binding)
      rule.apply(tuple, new_instances)
      return true
    end    
    return false
  end
  
  # Select those rules whose target types conforms with the binding target type and,
  # as a optimization, whose number of from metaclasses are greater than 1.
  def select_target_conforming(binding, rules)
    many_to_x_rules = rules.select { |r| 
      r.from_metaclasses.size > 1 && 
      DefaultRule.target_conforms?(r.to_metaclasses, binding.target_class) 
    }    
    raise RubyTL::NoRuleFoundManyToOneError.new(binding) if many_to_x_rules.empty?  

    many_to_x_rules
  end

  # Select those rule, whose source types conforms with the binding source type.
  # This method takes into account the types of the source collection in order to
  # select those rules that can be applied.
  def select_source_conforming(binding, rules)
    instances_by_type = binding.source_instance.map { |e| e }.uniq.group_by { |c| c.class }
    many_to_x_rules = rules.select do |rule|
      rule.from_metaclasses.all? do |from_metaclass|
        instances_by_type.keys.any? { |source_class| DefaultRule.source_conforms?(from_metaclass, source_class) } 
      end
    end

    raise RubyTL::NoRuleFoundManyToOneError.new(binding) if many_to_x_rules.empty?  

    # Modify instances_by_type to contain such metaclasses in the from part that are
    # superclasses.
    many_to_x_rules.map(&:from_metaclasses).flatten.uniq.each do |metaclass|
      if not instances_by_type.key?(metaclass)
        instances_by_type.each_pair do |subclass, instances|
          if subclass.all_super_classes.include?(metaclass)
            instances_by_type[metaclass] ||= []
            instances_by_type[metaclass] += instances 
          end
        end
      end
    end

    return many_to_x_rules, instances_by_type
  end

  # Make permutations based on the types of the source instances.
  # 
  # == Arguments
  #
  # * <tt>types</tt>. All types, in the same order that the instances have to appear in the permutation 
  # * <tt>instances_by_type</tt>. Sources instances grouped in a hash based on its type.
  # * <tt>values</tt>
  # * <tt>used</tt>
  # * <tt>block</tt>
  #  
  def make_type_permutations(types, instances_by_type, values = [], used = {}, &block)
    if types.size == 2
      unloop2(types, instances_by_type, values, used, &block) 
      return
    end
   
    type = types.first
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
    instances_by_type[types[0]].each do |instance0|
      next if used[instance0]
      instances_by_type[types[1]].each do |instance1|
        unless used[instance1] || instance0 == instance1
            yield(values + [instance0, instance1])
        end
      end
    end
  end
end

class RubyTL::NoRuleFoundManyToOneError < RubyTL::NoRuleFoundError
end