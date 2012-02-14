
module RubyTL
  module Rtl
    
    # Blah, blah...
    # 
    # A transformation execution has two steps: prepare and start.
    # 
    # * Prepare sets configuration values through phases and rules. 
    # * Start is in charging of "starting" the transformation execution.
    #
    class Transformation < CompositePhase
      attr_reader :imports
      attr_reader :factory_hooks
      attr_reader :status
      
      def initialize(name)
        super(name)
        @imports = []				
        @imported_phases = {}
        @factory_hooks = []
        @meta_rules = {}
      end
      
      # Starts a transformation. This is an overrided version
      # of CompositePhase#start that just catch exceptions and
      # converts them to standard RubyTL errors.
      # TODO: Is this really necessary? Can I use exception_handling { }
      #
      # == Error handling
      # * NameError
      # * RMOF::FeatureNotExist
      # * RMOF::TypeCheckError 
      #
      def start
        prepare if self.algorithm_klass.nil?
        import_transformations
        super
      end    
      
      # Returns a block (a callback) that provides the binding semantics.
      def binding_semantics
        method(:resolve_binding)
      end
      
      # Search for a rule which can deal with a binding and evaluate it.
      # The rule application result is stored.
      #
      def resolve_binding(binding)
        @status.current_phase.algorithm.resolve_binding(binding)
      end
      
      # Does a explicit call to a rule in the current phase.
      #
      def explicit_call(rule_name, instance)
        if instance.kind_of?(Enumerable)
          return instance.map { |i| explicit_call(rule_name, i) }.flatten
        end
        
        selected = @status.current_phase.rules.find { |r| r.name == rule_name }
        raise "Invalid rule #{rule_name}" unless selected
        tuple_instance = Tuple.new(instance)
        result = selected.create_and_link(tuple_instance)
        selected.apply(tuple_instance, result)
        return result.first if selected.to_part.types.size == 1
        result
      end
      
      def trace_query(instance)
        RubyTL::Rtl::TraceQuery.new(instance, self)
      end
      
      # Add new functionality to a metaclass by evaluating the contents
      # of +block+ in the context of such a +metaclass+.
      #
      # == Arguments
      # * <tt>metaclass</tt>
      # * <tt>block</tt>
      #
      def decorate_metaclass(metaclass, block)
        if metaclass.respond_to? :decorate
          metaclass.decorate(block)
        else
          metaclass.instance_eval(&block)
        end
      end
      
      # Looks up for an imported transformation. If the transformation does not exist,
      # nil is returned. Otherwise, an ImportedPhase object is returned.
      def lookup_imported(name)
        @imported_phases[name]
      end
            
      def instantiate_hooks(hooks)
        @factory_hooks.each do |factory_hook|
          concrete_type = hooks[factory_hook.name]
          factory_hook.concrete_type = concrete_type if concrete_type
        end
      end
      
      def add_meta_rule(rule)
        @meta_rules[rule.kind] ||= []
        @meta_rules[rule.kind] << rule
      end

      def binding_meta_rules
        @meta_rules[MetaRule::BINDING_KIND] || []
      end

      protected
      
      def import_transformations
        @imports.map { |i| i.do_import(status) }.each do |p| 
          @imported_phases[p.name] = p
        end
      end
      
    end
    
    
    # This class represents the transformation status, which is given
    # by some elements:
    #
    # * <tt>trace</tt>. Which targets elements have been created, from which source
    #                   ones, and by which rule.
    # * <tt>stack</tt>. The current rule call stack.
    #
    class TransformationStatus    
      # The underlying trace model that keeps track of the transformation
      attr_reader :trace_model      
      # The current trace being executed by the transformation engine
      attr_reader :current_phase
      # A list of trace models that come from another transformation
      attr_reader :resuming_traces
      
      def initialize
        @stack = []
        @trace_elements  = {}
        @trace_by_source = {}
        @trace_by_rule   = {}
        @current_phase   = nil
        @resuming_traces = []
        @trace_model = RubyTL::Trace::TraceModel.new
        @applied_rules   = {} # TODO: Consider phases, and do it better than this
      end
      
      # Change the current phase being executed. It receives a code
      # block (compulsory), that will be executed in the context
      # of the new phase.
      # 
      # == Arguments
      # * <tt>phase</tt>. The new current phase.
      # 
      def change_phase(phase)
        old_phase, @current_phase = @current_phase, phase
        yield
        @current_phase = old_phase
      end
      
      # Returns the current stack. Notice that, +self.stack.first+
      # is the last pushed rule, that is, the current rule being
      # executed.
      def stack
        @stack.dup
      end
      
      # The last rule pushed onto the call stack, that is, the current
      # rule being executed.
      def current_rule
        @stack.first
      end
      
      # A rule is executed and so pushed onto the rule call stack.
      #
      # == Arguments
      # * <tt>rule</tt>. The rule being executed.
      def push_rule(rule)
        @stack.unshift(rule)
        if block_given?
          yield
          pop_rule
        end      
      end
      
      # The rule being executed is removed from the rule call stack.
      def pop_rule
        @stack.shift
      end
      
      def add_isolated_trace(sources, targets)
        element = RubyTL::Trace::TraceElement.new
        @trace_model.traces << element

        sources.flatten.each { |s| element.sources << s }
        targets.flatten.each { |s| element.targets << s }
        
        element      
      end
      
      # Adds a trace element. Each trace is composed by one or more source
      # elements, from which one or more target elements are created, and the
      # rule used to create them.
      # 
      # == Arguments
      #
      # * <tt>sources</tt>. An array of source elements.
      # * <tt>targets</tt>. An array of target elements.
      # * <tt>rule</tt>. The rule used to map source to targets.
      #
      def add_trace(sources, targets, rule)
        element = add_isolated_trace(sources, targets) 
        unless mrule = @applied_rules[rule]
          # TODO: To do it without the need of this hash I must improve the
          # generator to consider single inheritance and use the generator output
          # as the implementation of the RubyTL::Rule
          mrule = RubyTL::Trace::Rule.new
          mrule.kind = rule.name
          @applied_rules[rule] = mrule
          @trace_model.rules << mrule
        end
        element.rule = mrule
        
        @trace_elements[rule] = element
        @trace_by_rule[rule] ||= {}
        sources.each do |source|
          @trace_by_source[source] ||= []
          @trace_by_source[source].push(*targets)
          @trace_by_rule[rule][source] ||= []
          @trace_by_rule[rule][source].push(*targets)
        end
      end
      
      # Returns all elements that has been created from a given
      # +source+ element.
      #
      # == Arguments
      # * <tt>source</tt>. The source element.
      def transformed_by_source(source)
        @trace_by_source[source]
      end
      
      # Returns all elements that has been created from a given
      # +source+ element using a given +rule+.
      #
      # == Arguments
      # * <tt>source</tt>. The source element.
      # * <tt>rule</tt>. The rule used to transformed the target elements.
      #
      def transformed_by_source_using_rule(source, rule)
        return nil unless target_hash = @trace_by_rule[rule]
        target_hash[source]
      end
      
      def transformed_by_resuming_source(source_element)
        self.resuming_traces.map do |trace|
          trace.traces.select { |t| t.sources.include?(source_element) }.
                       map { |t| t.targets }
        end.flatten.uniq
                  # TODO: Why I need an uniq!!!!        
      end
    end
    
  end
end


module RubyTL
  
  # A transformation is an aggregation of rules. 
  #
  class Transformation
    attr_accessor :name
    
    attr_reader :rules
    # attr_reader :delegate
    attr_reader :repository
    attr_reader :context
    attr_reader :status
    
    # The transformation that is currently being executed by the engine
    cattr_accessor :current
    
    # Creates a new transformation object. The transformation delegates in
    # an ExtensionDelegate object to perform actions related to the 
    # transformation algorithm or the rule life cycle.
    #
    # == Args
    # 
    # * <tt>context</tt>. The module where this transformation is enclosed.
    # * <tt>extension_delegate</tt>. An ExtensionDelegate object.
    # * <tt>repository</tt>. A Repository object to make the transformation able of loading models.
    #
    def initialize(context, repository)      
      @name = "undefined_transformation_name##{object_id}" 
      @context = context
      @context.transformation_ = self
      @rules = []
      @properties = {}
      # @delegate = extension_delegate
      @repository = repository
      @status = RubyTL::Rtl::TransformationStatus.new(self)
    end
    
    # Add an input metamodel. 
    #
    # == Arguments
    # * <tt>local_name</tt>. The name of the metamodel package.
    # * <tt>metamodel_uri</tt>. The uri of the metamodel.
    #
    def add_input(local_name, metamodel_uri)
      return if @repository.already_bound?(local_name)
      model_binding = @repository.bind_as_source(local_name, :metamodel => metamodel_uri)
      raise RubyTL::UndefinedModel.new(local_name, metamodel_uri) if not model_binding
      model_binding.bind_to_module(@context)
    end
    
    # Add an output metamodel. 
    #
    # == Arguments
    # * <tt>local_name</tt>. The name of the metamodel package.
    # * <tt>metamodel_uri</tt>. The uri of the metamodel.
    #
    def add_output(local_name, metamodel_uri)
      return if repository.already_bound?(local_name)
      model_binding = @repository.bind_as_target(local_name, :metamodel => metamodel_uri)
      raise RubyTL::UndefinedModel.new(local_name, metamodel_uri) if (!model_binding || (!model_binding.model && !model_binding.in_memory))
      model_binding.bind_to_module(@context)
    end
    
    # Add new functionality to a metaclass by evaluating the contents
    # of +block+ in the context of such a +metaclass+.
    #
    # == Arguments
    # * <tt>metaclass</tt>
    # * <tt>block</tt>
    #
    def decorate_metaclass(metaclass, block)
      if metaclass.respond_to? :decorate 
        metaclass.decorate(block)
      else
        metaclass.module_eval(&block)
      end
    end
    
    # Creates a new rule
    #
    # == Arguments
    # 
    # * <tt>rule_klass</tt>. The concrete class of the rule that will be created
    # * <tt>name</tt>. The rule name as a string
    # * <tt>body</tt>. A block containing the rule body (from, to...)
    #
    def create_rule(rule_klass, name, body)    
      rule = rule_klass.new(@context, name, body, :kind => rule_klass.kind)
      @rules << rule
      rule
    end
    
    # Starts a transformation and it is provided with class that will
    # handle the transformation life cycle.
    #
    # == Error handling
    # 
    #
    def start(algorithm_class)
      @algorithm = algorithm_class.new(@context)
      @algorithm.transformation_start
      self.apply_entry_points
    rescue ::NameError => e
      raise RubyTL::EvaluationError.new(e)
    rescue RMOF::FeatureNotExist => e
      raise RubyTL::EvaluationError.new(e)
    rescue RMOF::TypeCheckError => e
      raise RubyTL::EvaluationError.new(e)
    end
    
    # Look for entry point rules and apply them in order to
    # start the transformation process.
    def apply_entry_points()         
      @algorithm.apply_entry_point_rules
    end
    
    # Returns a block (a callback) that provides the binding semantics.
    def binding_semantics
      method(:resolve_binding)
    end
    
    # Search for a rule which can deal with a binding and evaluate it.
    # The rule application result is stored.
    #
    def resolve_binding(binding)
      @algorithm.resolve_binding(binding)
    end
    
    # Busca una regla por su nombre. Devuelve un objeto de tipo +Rule+.
    # Si la regla no existe lanza una excepción
    def rule_by_name(name)
      selected = @rules.select { |rule| rule.name == name }
      if selected.empty? 
        raise "No existe regla #{name}"
      else
        selected.first
      end 
    end
    
    # Get a transformation property value.
    def [](key)
      @properties[key]
    end
    
    # Set a transformation property value.    
    def []=(key, value)
      @properties[key] = value
    end
  end
  
=begin
TODO: Deber�a ser un plugin
      # Transforma una instancia seg�n una regla que sea capaz de tranformar el tipo
      # de la instancia al tipo indicado en target_type
      def transform_to(instance, target_type)
          rule = search_rule_for(target_type.metaclass, instance)
          rule.apply(instance)
      end
=end      
  
  module ParameterHandling
    def parameter_set(params)
      self.const_set('Parameters', params)
    end
  end
  
end
