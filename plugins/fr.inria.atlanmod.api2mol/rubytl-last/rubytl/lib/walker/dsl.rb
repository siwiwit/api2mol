class Symbol
  PropertyAttributePair = Struct.new(:property, :synthetised_attr_name)  
  
  def synthetised(synthetised_attr_name)
    PropertyAttributePair.new(self, synthetised_attr_name)
  end
end

module RubyTL 
  module Walker

    class LanguageDefinition < RubyTL::LowLevelDSL::DslDefinition      
      
      keyword('flow') { param :name_type, :hash, :one }
      keyword('synthetise') { param :attr_name, :id, :one }
      keyword('using_synthetised') { param :property_name, :id, :one }

      keyword('creating')    { param :metaklass, :any, :one }
      keyword('filter')     { catch_block }
      keyword('error')     { 
        param :attr_name, :id, :one 
        catch_block
      }             
      keyword('init')       { catch_block }
      keyword('local') do
        param :local_var_name, :id, :one
        param :property_attribute, :any, :one
      end
            
      keyword('computing') { catch_block }
#      keyword('filter') { catch_block }
#      keyword('param') { param :names, :id, :many}
#      keyword('ignore') { param :what, :any, :one }

      
      root_composition do
        contain_keyword 'flow'
      end
      
      composition_for 'flow' do
        contain_keyword 'synthetise'
        contain_keyword 'local'
        contain_keyword 'creating'
        contain_keyword 'error'
      end

      composition_for 'creating' do
        contain_keyword 'filter'
        contain_keyword 'init'        
      end

      composition_for 'synthetise' do
        contain_keyword 'filter'
        contain_keyword 'using_synthetised'
        contain_keyword 'computing'       
      end 

      visitor_semantics do
        attr_reader :transformation
      
        def start
          @transformation = RubyTL::Walker::Transformation.new() # TODO: Look for the transformation name
          associate current_node, @transformation
        end
        
        def in_flow          
          name, metaklass = current_node.attributes['name_type'].unique_pair
          rule  = RubyTL::Walker::FlowRule.new(@transformation, name, metaklass)
          retrieve(current_node.parent).rules << rule
          store(rule)
        end        
        
        def in_synthetise
          name      = current_node.attributes['attr_name']
          flow_rule = retrieve(current_node.parent)
          
          attr = flow_rule.get_attribute(name)
          dep  = nil
          if attr
            dep = flow_rule.dependencies.select { |d| d.kind_of?(SynthetisedDependency) }.find_one { |d| d.attribute == attr }           
          else 
            attr = SynthetisedAttribute.new(name)
            flow_rule.computed_attributes << attr
            flow_rule.dependencies << dep = SynthetisedDependency.new(attr)
          end
          store(dep)        
        end
        
        def in_error
          flow_rule = retrieve(current_node.parent)
          attr_name = current_node.attributes['attr_name']
          attr = flow_rule.get_attribute(attr_name)
          
          flow_rule.errors << ErrorHandler.new(attr, current_node.catched_block)
        end
        
        def out_synthetise        
          filter = current_node.child_nodes.find { |n| n.keyword_name == 'filter' }
          if filter
            dep        = current_node.child_nodes.map { |n| retrieve(n) }.find_one { |o| o.kind_of?(FlowPattern) }          
            dep.filter = filter.catched_block
          end
        end
        
        def in_local
          lvn = current_node.attributes['local_var_name']
          pa  = current_node.attributes['property_attribute']
          retrieve(current_node.parent).dependencies << LocalVarDependency.new(lvn, pa.property, pa.synthetised_attr_name)
        end
        
        def in_creating
          creating = CreatingPart.new(current_node.attributes['metaklass'])
          retrieve(current_node.parent).creatings << creating
          store(creating)
        end
        
        def in_filter
          if current_node.parent.keyword_name == 'synthetise'
            # Just let synthetise do the work
          else
            retrieve(current_node.parent).filter = current_node.catched_block
          end
        end
        
        def in_init
          retrieve(current_node.parent).initialization = current_node.catched_block
        end
        
        def in_using_synthetised
          the_dependency = retrieve(current_node.parent)
        
          pattern = AttributeFlowPattern.new(current_node.attributes['property_name'], the_dependency.attribute)
          the_dependency.patterns << pattern
          store(pattern) 
        end
        
        def in_computing
          the_dependency = retrieve(current_node.parent)

          pattern = ComputedFlowPattern.new(current_node.catched_block, the_dependency.attribute)
          the_dependency.patterns << pattern
          store(pattern) 
        end
      end        
    end
  end
end

module RubyTL
  module Walker
  
    class Transformation
      attr_reader :rules
      
      def initialize
        @rules  = []
      end
      
      def apply_rule(rule_name, element, parameters = {})
        raise "Not implemented"
      end
      
      def prepare; end
      
      # Look for the "root" objects (not contained in other parts) 
      def start
        roots = @rules.map { |r| 
          r.metaklass.all_objects.select { |o| o.__container__.nil? }.
                                  map { |o| [o, r] }
        }
        roots = roots.reject { |r| r.empty? }
        raise WalkerError.new('No rules for root object') if roots.empty?

        roots.each do |objects_and_rules|
          objects_and_rules.each do |o, r|
            r.execute_for_instance(o)
          end
        end
        #@rules.each do |r| 
        #  r.execute        
        #end
      rescue StopWalking => e
        $stderr << "Transformation manually stopped." + $/
        $stderr << e.message.to_s + $/
      end
      
      # Return a rule (just one rule) that is able to deal with objects
      # of the metaclass specified as a parameter.
      def lookup_for_type(metaklass, rule_name) 
        rules = @rules.select { |r|  
          r.name == rule_name &&
          metaklass.rumi_conforms_to?(r.metaklass)
        }    
        raise WalkerError.new("Too many rules: #{rules.map { |r| r.metaklass.name }.join(',')}") if rules.size > 1
        raise WalkerError.new("No rules for #{metaklass.name}") if rules.empty?
        rules.first            
      end
    end
  
    class FlowRule
      attr_reader :transformation
      attr_reader :name
      attr_reader :metaklass
      attr_reader :computed_attributes
      attr_reader :dependencies
      attr_reader :creatings
      attr_reader :errors
    
      def initialize(transformation, name, metaklass)
        @transformation = transformation
        @name = name.to_s
        @metaklass = metaklass
        @computed_attributes = []
        @dependencies = []
        @creatings = []
        @errors = []
        
        @computed_result = {}
      end
      
      def error_handler_for_attribute(attr)
        @errors.find { |e| e.attribute == attr }
      end
      
      def get_attribute(name)
        @computed_attributes.find { |a| a.name == name }
      end
      
      def execute
        metaklass.all_objects.each do |o|
          execute_for_instance(o)
        end
      end
      
      # TODO: Avoid cycles
      def execute_for_instance(o)
        debug(o) do              
          return @computed_result[o] if @computed_result.key?(o)
        
          @computed_result[o] = result = RuleResult.new(o.metaclass)
          @dependencies.each do |dep|
            dep.resolve(o, self, result)
          end    
          
          @creatings.each { |c| c.execute(o, self, result) }  
          result          
        end
      end
      
      def debug(o)
        $inc ||= -1        
        sinc = " " * ($inc += 1) 
        puts "#{sinc} Execute rule #{@metaklass.name} : [#{o}]"
        r = yield
        $inc -= 1
        r
      end
    end

    class Attribute
      attr_reader :name
      def initialize(name)
        @name = name
      end
    end
    
    class SynthetisedAttribute < Attribute
    end

    class Dependency
      def resolve(object, rule, caller_result); raise "abstract"; end
    end
    
    class SynthetisedDependency < Dependency
      attr_reader :patterns
      attr_reader :attribute
      def initialize(attr)
        @attribute = attr
        @patterns = []
      end
      
      def resolve(object, rule, caller_result)
        raise "No patterns" if @patterns.empty?
        possible = @patterns.select { |p| p.may_resolve?(object, rule, caller_result) }
        raise "Too many patterns to resolve #{@attribute.name}" if possible.size > 1
        if possible.empty?
          # Then handler will raise an exception. If not, the "No available pattern" exception is raised anyway
          if handler = rule.error_handler_for_attribute(@attribute)
            handler.execute(object)
          end
          raise "No available patterns to resolve #{@attribute.name} in rule #{rule.name}.#{rule.metaklass.name} for object #{object.metaclass.name}" 
        end

        possible.first.resolve(object, rule, caller_result)
      end      
    end
    
    class ErrorHandler
      attr_reader :attribute
      attr_reader :error_block
      def initialize(attr, error_block)
        @attribute = attr
        @error_block = error_block
      end    
      
      def execute(obj)
        ExecutionProxy.new(obj).instance_eval(&@error_block)          
      end
    end
   
    class RuleResult    
      def initialize(metaklass)
        @metaklass = metaklass
        @attribute_values = {}
      end
      
      def set_attribute(name, value)
        name = name.to_s
        raise "Attribute already exists #{name}" if @attribute_values[name]
        @attribute_values[name] = value
      end
      
      def get_attribute_value(name)
        name = name.to_s
        result = @attribute_values[name]
        raise "Not existing attribute #{name} in #{@metaklass.name}" unless result
        result
      end
      
      def pairs
        @attribute_values.dup
      end
    end
    
    module Resolution
    protected
      def resolve_dependency(object, rule, property_name)
        property = object.metaclass.property(property_name)
        if property.multivalued?
          collection = object.get(property)
          result = collection.map { |value| 
            rule_to_call = rule.transformation.lookup_for_type(value.metaclass, rule.name)
            rule_to_call.execute_for_instance(value)
          }
          yield(result) if block_given?
        else
          value        = object.get(property)
          rule_to_call = rule.transformation.lookup_for_type(value.metaclass, rule.name)
          result = rule_to_call.execute_for_instance(value)
          yield(result) if block_given?
        end      
      end 
      
      def extract_result(result, attribute_name)
        if result.kind_of?(Array)
          result.map { |r| extract_result(r, attribute_name) }
        else
          result.get_attribute_value(attribute_name)
        end
      end
    end

    class FlowPattern
      attr_accessor :filter
    
      def resolve(object, rule, caller_result); raise "abstract"; end
    
      def may_resolve?(object, rule, caller_result)
        return true unless @filter 
        ExecutionProxy.new(object, caller_result.pairs).instance_eval(&@filter)      
      end
    end
        
    class AttributeFlowPattern < FlowPattern
      include Resolution
      def initialize(property_name, dependant_attr)
        @property_name  = property_name.to_s
        @dependant_attr = dependant_attr
      end
      
      def resolve(object, rule, caller_result)
        resolve_dependency(object, rule, @property_name) do |result|                
          caller_result.set_attribute(@dependant_attr.name, extract_result(result, @dependant_attr.name)) #result.get_attribute_value(@dependant_attr.name))        
        end
      end
    end

    class LocalVarDependency < Dependency
      include Resolution
      def initialize(local_var_name, property_name, synthetised_attr_name)
        @local_var_name = local_var_name.to_s
        @property_name  = property_name.to_s
        @synthetised_attr_name = synthetised_attr_name.to_s
      end
      
      def resolve(object, rule, caller_result)
        resolve_dependency(object, rule, @property_name) do |result|
          caller_result.set_attribute(@local_var_name, extract_result(result, @synthetised_attr_name))#result.get_attribute_value(@synthetised_attr_name))        
        end
      end
    end

    class ComputedFlowPattern < FlowPattern
      def initialize(block, dependant_attr)
        @block  = block
        @dependant_attr = dependant_attr
      end
      
      def resolve(object, rule, caller_result)
        exec_result = ExecutionProxy.new(object, caller_result.pairs).instance_eval(&@block)
        caller_result.set_attribute(@dependant_attr.name, exec_result)      
      end
    end

    class CreatingPart
      attr_reader :metaklass
      attr_accessor :filter
      attr_accessor :initialization
      
      def initialize(metaklass)
        @metaklass = metaklass
      end
      
      #
      #
      # == Arguments
      # 
      # * obj
      # * rule
      # * result: a RuleResult containing the attributes already computed for this rule
      # 
      def execute(obj, rule, result)
        pairs = result.pairs                              
        if ExecutionProxy.new(obj, pairs).instance_eval(&@filter)
          target = @metaklass.new
          pairs.merge!('_target__' => target)
          ExecutionProxy.new(obj, pairs).instance_eval(&@initialization)
        end 
      end
    end

    class ExecutionProxy
      attr_reader :obj
      def initialize(obj, pairs = {})
        @obj = obj
        @pairs = {}
        pairs.each do |key, value|
          @pairs["_" + key.to_s] = value
        end
      end
      
      def method_missing(name, *args, &block)      
        return @pairs[name.to_s] if @pairs.key?(name.to_s)        
        return @obj.send(name, *args, &block)
      end
    end
    
    class WalkerError < RubyTL::BaseError; end 
    class StopWalking < RubyTL::BaseError; end 
  end
end


module RubyTL
  module Walker
    
    # A transformation context is an environment to load DSL
    # keywords and to execute the DSL. In this way, the DSL
    # execution is isolated from other execution, preventing
    # name-crashes.
    #
    class TransformationContext < Module
      include RubyTL::Base::ExceptionHandling
      attr_reader :dsl_keywords
      attr_reader :plugin_parameters
      attr_reader :transformation_object
      
      # Creates a new transformation context
      def initialize
        extend RubyTL::ParameterHandling
        extend RubyTL::HelperLoading
        extend RubyTL::PluginHandling
        #extend RubyTL::Keywords    
        
        #@language_definition = TLang::LanguageDefinition.deep_clone 
        @language_definition = RubyTL::Walker::LanguageDefinition.info
      end

      # To allow decorators in libraries to work...
      def decorator(metaclass, &block)
        metaclass.decorate(block)
      end
      
      def generate_dsl
        @language_definition.create_dsl_in_context(self)
        # syntax.create_method('mapper', 'input_value', "::Mapper.new(input_value, transformation_)")
      end  
      
      # Loads a transformation and returns a +Transformation" object
      # representing the loaded transformation.
      #
      # TODO: FACTORIZE TRANSFORMATIONCONTEXT INTO DSLCONTEXT
      def load_transformation(transformation_text, filename, launcher = nil)
        handle_dsl_exceptions(filename) do
          self.module_eval(transformation_text, filename)        
        end            
        loaded = self.execute_visitor_semantics(launcher)
        @transformation_object = loaded.visitor.transformation
      end
    end      
  end
end
