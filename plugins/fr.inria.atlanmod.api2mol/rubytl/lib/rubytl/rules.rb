
module RubyTL
  module Rtl

    #
    # A rule has a name and four elements:
    #
    # * <tt>source metaclasses</tt>. A list of classes
    # * <tt>target metaclass</tt>. A class (maybe it shoud be extended to be a list)
    # * <tt>filter</tt>. A block containing a boolean expression
    # * <tt>mapping</tt>. A block with bindings or any Ruby code.
    #
    # A rule is owned by a transformation object which contains all information
    # about another rules and provides methods to access them.
    #
    # == Rule life cycle
    # 
    # The life cycle of the rule is notified to a life cycle object
    # set in the initialize method. The object may implement the 
    # following methods:
    #
    # * <tt>:on_rule_definition</tt>
    # * <tt>:on_apply_rule</tt>
    # * <tt>:on_check_conformance</tt>
    # 
    # 
    # == Rule extensions
    #
    # A rule can have extensions in its syntax, therefore it is necessary
    # for a Rule object to have a way to store the values specified.
    # Rule properties are accessed with the [] operator.
    #   
    #    rule[:kind] = :top
    #    rule[:is_transient] = true
    # 
    # == Example
    #
    #    rule 'the_rule_name' do
    #       from  SourceMetamodel::SourceClass
    #       to    TargetMetamodel::TargetClass
    #       filter do |x|
    #          x.attribute == true
    #       end
    #       mapping do |source, target|
    #          target.attr = source.another_attr
    #       end
    #    end
    #
    # The concrete syntax shown above should raise the creation of
    # the following Rule object.
    #      
    #    rule = Rule.new(...)
    #    rule.from_metaclasses = [SourceMetamodel::SourceClass]
    #    rule.to_metaclasses = [TargetMetamodel::TargetClass]
    #    rule.filter = block_captured_for_filter
    #    rule.mapping = block_captured_for_mapping
    #     
    class Rule
      include Preparable
         
      attr_reader :name
      attr_reader :owner      
      attr_accessor :from_part
      attr_accessor :to_part
      attr_accessor :mapping_part
      attr_accessor :filter_part
      attr_reader :mixins
      
      # Creates a new rule.
      # 
      # == Arguments
      # * <tt>owner</tt>. The phase owning the rule.
      # * <tt>name</tt>. The rule name.
      #
      def initialize(owner, name)
        @owner = owner
        @name  = name
        @owner.rules << self
        @transformed = {}
        @mixins = []
      end
      
      # Execute the rule at top level, i.e. no binding has provokes
      # the execution of this rule.
      # There are two cases depending on the number of types of the 
      # from part:
      # * One type: For each instance of the type, the rule is applied.
      # * Many types: The cross product is done.
      # 
      def execute_at_top_level
        self.from_part.tupleize_instances do |tuple_instance|
          if pass_filter?(tuple_instance)
            result = create_and_link(tuple_instance)
            apply(tuple_instance, result) 
          end                            
        end
      end
      
      # Test whether the filter of a rule is satisfied.
      def pass_filter?(instances)
        return filter_part.code_block.call(*instances) if filter_part
        return true      
      end

      def pass_filter_x2?(instance1, instance2)
        return filter_part.code_block.call(instance1, instance2) if filter_part
        return true      
      end
      
      def create_and_link(source_element, binding = nil)
        targets = @transformed[source_element]    
        if not targets
          targets = create_and_link_helper(binding, source_element)          
          register_trace(source_element, targets)
        else
          link_helper(targets, binding, source_element) if binding   
        end
        return targets
      end        

      def apply(source, targets)
        if not @transformed[source]
          register_already_transformed(source, targets)
          @status.push_rule(self) {          
            # Evaluate the mixins before the mapping
            self.mixins.each { |m| m.evaluate(source, targets) }
            # Then, evaluate the mapping part
            self.mapping_part.evaluate(source, targets) if self.mapping_part
          }
        end
      end

      def apply_x2(i1, i2)
        if not @transformed[i1]
          register_already_transformed(i1, i2)          
          # Evaluate the mixins before the mapping
          self.mixins.each { |m| m.evaluate_x2(i1, i2) }
          # Then, evaluate the mapping part
          self.mapping_part.evaluate_x2(i1, i2) if self.mapping_part
        end
      end

      def conforms_to?(binding)
        instance     = binding.source_instance
        source_class = binding.source_type
        target_class = binding.target_type    

        raise "Too many from metaclasses" if self.from_part.types.size > 1
    
        return self.source_conforms_to?(source_class) &&
               self.target_conforms_to?(target_class)
      end

      def target_conforms_to?(target_class)
        self.to_part.types.all? { |c| c.rumi_conforms_to?(target_class) }
      end
  
      def source_conforms_to?(*source_classes)
        from_types = self.from_part.types
        return false if source_classes.size != from_types.size
        source_classes.each_with_index { |source_class, idx| 
          return false unless source_class.rumi_conforms_to?(from_types[idx])
        } 
        return true
      end      

    private

      def register_trace(source_element, target_elements)
        if target_elements.flatten.size > 0
          @status.add_trace([*source_element], target_elements, self)  
        end              
      end

      def register_already_transformed(source_element, target_elements)
        @transformed[source_element] = target_elements
      end

      # Creates one instance per +to_metaclass+ (using +create_helper+). 
      # If a binding is given, the elements are linked against the 
      # target element's property.
      #
      # == Arguments
      # * <tt>binding</tt>
      # * <tt>source_elements</tt>
      #
      def create_and_link_helper(binding, source_elements = nil)
        new_instances = self.to_part.create_instances(post_linking_callback(binding, source_elements))
        link_helper(new_instances, binding, source_elements) if binding    
        new_instances
      end        

      # Link instances, and adds trace information.
      #  
      def link_helper(new_instances, binding, source_elements = nil)
        binding.target_instance.rumi_reference_value_set(binding.feature, new_instances)
      end
      
      def post_linking_callback(binding, source_elements)
        lambda { |target| 
          link_helper(target, binding, source_elements) if binding
          register_trace(source_elements, [target])
        }
      end
    end
    
    class DefaultRule < Rule    
    end
    
    class TopRule < DefaultRule    
    end
    
    class CopyRule < Rule
      def register_already_transformed(source_element, target_elements)
        # Avoid registering elements
      end    
    end

    # This is a rule doing nothing. Just to allow ignore a certain 
    # mapping.     
    class IgnoreRule 
      def initialize(source, target)
        @source = source
        @target = target        
      end
      
      def ignore?(binding)
        ignore_source = @source == :any || binding.source_type.rumi_conforms_to?(@source)
        ignore_target = @target == :any || @target.rumi_conforms_to?(binding.target_type)
        return ignore_source && ignore_target
      end
    end
    
    class RuleMixin
      attr_reader :name
      attr_reader :owner
      attr_reader :mixins
      attr_accessor :mapping_part
      
      def initialize(phase, name, block)
        @name = name
        @mixins = []
        @owner = phase
        phase.rule_mixins << self 
      end
      
      def evaluate(source_instances, new_instances)
        @mixins.each { |m| m.evaluate(source_instances, new_instances) }
        @mapping_part.evaluate(source_instances, new_instances)
      end      

      def evaluate_x2(i1, i2)
        @mixins.each { |m| m.evaluate_x2(i1, i2) }
        @mapping_part.evaluate_x2(i1, i2)
      end      
    end
    
    class RefinementRule < TopRule
      
      # When refinement rules are applied, the @transformed hash
      # is not checked. 
      # TODO: This requirement should be expressed in a way better than
      # from just overriding the method...
      def apply(source, targets)
        register_already_transformed(source, targets)
        @status.push_rule(self) {                  
          self.mapping_part.evaluate(source, targets) if self.mapping_part
        }
      end
      
      def create_and_link(source_element, binding = nil)
        raise RefinementRuleError.new("Refinement rules cannot resolve bindings")
      end
      
      def execute_at_top_level
        self.from_part.tupleize_instances do |tuple_instance|
          single_instance = tuple_instance[0]
          raise RefinementRuleError.new("In this moment only one source instance is supported") if tuple_instance.size > 1

          # Compute possible matches, and filter them

          possible_matches = @status.transformed_by_source(single_instance)
          next if possible_matches.nil?
           
          # Quick hack          
          if self.to_part.types.any? { |t| t.kind_of?(Types::CollectionProxy) }
            # Refinement rule with many
            raise RefinementRuleError.new("Refinement rule with many() should have only one 'to'") unless self.to_part.types.size == 1
            many_type = self.to_part.types.first.metaclass
            matches = possible_matches.select { |e| e.rumi_kind_of?(many_type) }
            self.apply_x2(single_instance, matches) if pass_filter_x2?(single_instance, matches)
          else
            # Normal refinement rule
            real_matches = compute_real_matches(possible_matches, single_instance)
            real_matches.each do |target_instances|
              if pass_filter?([single_instance] + target_instances)
                self.mixins.each { |m| m.evaluate(single_instance, target_instances) }
                self.apply(single_instance, target_instances) 
              end                         
            end             
          end
        end
      end
      
    private

      def compute_real_matches(possible_matches, single_instance)
        instances_by_type = possible_matches.map { |e| e }.uniq.group_by { |c| c.metaclass.real_klass }
    
        # TODO: Hack. To solve it homogeneize metaclass representation (maybe with methods such as equal...)
        self.to_part.types.map(&:real_klass).uniq.each do |metaclass|
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
        make_type_permutations(self.to_part.types.map(&:real_klass), instances_by_type) do |value|
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
        
    end
    
    class RuleTypePart
      attr_reader :types
      def initialize(types)
        @types = types
      end
    end
    
    class FromPart < RuleTypePart

      # 
      #    
      def tupleize_instances(&block)
        sources = @types.map { |m| m.all_objects }
        values  = sources.inject([]) { |partial, instances| partial ** instances }
        values.each(&block) if block_given?
        values
      end
      
    end
    
    class ToPart < RuleTypePart    
    
      def create_instances(binding)
        self.types.map do |to_metaclass| 
          if to_metaclass.kind_of?(Types::CollectionProxy)
            to_metaclass.new(binding)
          else
            to_metaclass.new 
          end
        end
      end        
    end

    class CodePart
      attr_reader :code_block
      def initialize(code_block)
        @code_block = code_block
      end    
    end
    
    class MappingPart < CodePart
      # Evaluates a mapping by calling the associated block. The block
      # should have one parameter for the element in the +from+ part of
      # the corresponding rule, and the same number of parameters as 
      # the number of metaclasses specified in the +to+ part of the rule.
      #
      # == Args
      # 
      # * <tt>source_instances</tt>. An array with one or more source instances.
      # * <tt>new_instances</tt>. The list of target instances created as
      # a result of the rule application.
      #
      def evaluate(source_instances, new_instances)
        @code_block.call(*([*source_instances] + [*new_instances]))
        new_instances
      end

      def evaluate_x2(i1, i2)
        @code_block.call(i1, i2)
        i2
      end
    end

    class FilterPart < CodePart
    end
    
    # Class which depicts a binding in the form: +left_instance.feature = expression+.
    #
    # A binding is composed by four elements:
    #
    # * <tt>left_instance</tt>. The instance at the left of the binding assignment (i.e. the target)
    # * <tt>right_instance</tt>. The instance at the right of the binding assigment (i.e. the source)
    #   which is obtained from a given +expression+
    # * <tt>feature</tt>. The feature of the +left_instance+ which is assigned 
    #
    class BindingAssignment
      attr_reader :target_instance
      attr_reader :source_instance
      attr_reader :tupleized_source    
      attr_reader :target_type
      attr_reader :feature
  
      def initialize(right_instance, left_instance, feature)
        @target_instance  = left_instance
        @source_instance  = right_instance    
        @tupleized_source = right_instance.is_a?(Tuple) ? right_instance : Tuple.new(right_instance)
        @feature          = check_feature(feature)        
        @target_type      = @feature.rumi_type
      end
           
      # Returns the binding source class, that is, the class of the
      # right instance (source instance).
      def source_type
        @source_instance.metaclass
      end
          
      def primitive_source?
        false        
      end
              
      # Returns +true+ if the right part of the binding can be
      # directly assigned to the left one.
      def directly_assignable?
        @source_instance.rumi_kind_of?(@feature.rumi_type) &&
          @source_instance.rumi_model_id_check(@target_instance) 
      rescue NoMethodError => e
        raise PrimitiveValueOnBinding.new("Trying to assign value  " + 
                                          "'#{@source_instance}', which is non-conforming to a loaded metaclass, to binding.") if e.message =~ /rumi_kind_of/     
        raise e
      end     

      def perform_assignment(&block)
        @target_instance.rumi_reference_value_set(@feature, @source_instance)
      end

      def is_source_nil?
        @source_instance.nil?
      end

      # Makes a binding whose right part is an enumerable acts as if n-bindings,
      # one for each instance in the enumerable, would exist.
      #
      # == Arguments
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
      def homogenize_enumerable_binding(&block)
        target_instance = @target_instance
        source_instance = @source_instance
        feature         = @feature
        
        if source_instance.kind_of?(Enumerable) && !source_instance.kind_of?(String)
          source_instance.map { |i| BindingAssignment.new(i, target_instance, feature) }.each do |b|
            b.homogenize_enumerable_binding(&block)
          end
        else         
          yield(self)        
        end    
      end

      def to_s
        where  = []
        where += ["#{target_instance.metaclass.name} = { #{target_instance} }"] #if target_instance.respond_to?(:with_format)
        where += ["#{source_type.name} = { #{source_instance} }"] #if source_instance.respond_to?(:with_format)
        append = ''
        if where.size > 0
          append = $/ + "\twhere " + where[0]
          where[1..-1].each { |s| append += "#{$/}\t      " + s }
        end

        "#{target_instance.metaclass.name}.#{feature.name} = #{source_type.name}" + append
      end

    private
      def check_feature(feature)
        feature = @target_instance.metaclass.rumi_property_by_name(feature) if feature.kind_of?(String)
        raise "Feature '#{feature}' not found for #{@left_instance}" if feature.nil?
        feature
      end      
    end

    
    class PrimitiveValueOnBinding < RubyTL::BaseError; end    
    class RefinementRuleError < RubyTL::BaseError; end        
  end
end
