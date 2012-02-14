# Definition of the RubyTL DSL using the
# LowLevel definition DSL. 

module RubyTL
  module Rtl  
    class LanguageDefinition < RubyTL::LowLevelDSL::DslDefinition      
      keyword('transformation') { param :name, :id }
      keyword('input') { param :hash, :hash }
      keyword('output') { param :hash, :hash }
      
      
      keyword 'decorator' do
        param :metaclass, :class, :one
        catch_block
      end
      
      keyword 'phase' do
        param :name, :id
      end
      
      abstract_keyword 'abstract_rule' do
        param :name, :id
      end
           
      keyword('from') { param :metaclass, :any, :many } 
      keyword('to')   { param :metaclass, :class, :many } 
      keyword('filter')  { catch_block } 
      keyword('mapping') { catch_block } 
      
            
      keyword 'rule', :extends => 'abstract_rule'
      keyword 'top_rule', :extends => 'abstract_rule'
      keyword 'copy_rule', :extends => 'abstract_rule'
      keyword 'refinement_rule', :extends => 'abstract_rule'
      
      # Declares a rule mixin
      keyword 'rule_mixin' do
        param 'name', :id
      end
           
      # Actually mixes the mixin
      keyword 'mixin' do
        param 'mixin_names', :id, :many
      end

      composition_for 'rule_mixin' do
        contain_keyword 'mixin'
        contain_keyword 'mapping'
      end
            
      keyword('ignore_rule') { param :mappings, :hash } 
            
      keyword('import') do
        param :name, :string, :one
        param :options, :hash
        catch_block
      end
      keyword('scheduling') { catch_block }
      
     
      composition_for 'phase' do
        contain_keyword 'phase'
        contain_keyword 'abstract_rule'
        contain_keyword 'rule_mixin'
        contain_keyword 'ignore_rule'
        contain_keyword 'scheduling'
      end

      keyword('hook') { param :factory, :hash } # TODO: Check hook names are unique...      
      keyword('many') { param :metaclass, :class, :one } 
      keyword('Set')  { param :metaclass, :class, :one } # This is deprecated
      composition_for 'abstract_rule' do
        contain_keyword 'from'
        contain_keyword 'to'
        contain_keyword 'hook'
        contain_keyword 'many'
        contain_keyword 'Set' #This is deprecated
        contain_keyword 'filter'
        contain_keyword 'mapping'
        contain_keyword 'mixin'        
      end

      # Meta rules:
      #   meta_rule 'trace', :for => :binding do  
      #    filter { |b|  } # It takes the binding object
      #    behaviour do |b|                             
      #    end                                          
      #   end                                           
      keyword 'meta_rule' do                            
        param :name, :string, :one                      
        param :kind, :hash                              
      end                                               

      keyword 'behaviour' do
        catch_block         
      end                   
                            
      composition_for 'meta_rule' do
        contain_keyword 'filter'    
        contain_keyword 'behaviour' 
      end                           
      # End-of meta rules          
       
      # Root composition
      root_composition do
        contain_keyword 'transformation'
        contain_keyword 'input'
        contain_keyword 'output'
        contain_keyword 'decorator'
        contain_keyword 'phase'
        contain_keyword 'abstract_rule'
        contain_keyword 'ignore_rule'
        contain_keyword 'rule_mixin'
        
        contain_keyword 'import'
        contain_keyword 'scheduling'
 
        contain_keyword 'meta_rule'
      end
      
      visitor_semantics do
        include RubyTL::Rtl::VisitorHelpers
        
        attr_reader :transformation
        
        def start
          @transformation = RubyTL::Rtl::Transformation.new('no-name') 
          root = create_phase(current_node, @transformation, 'transformation_phase')
          #@transformation.phases << root = create_phase(current_node, @transformation, 'transformation_phase')
          associate current_node, root          
        end       
        
        def finish
          # Add the trace_query function
          add_to_global_context %{
            def trace_query(instance)
              @syntax_context.transformation_object.trace_query(instance)
            end
            
            def this_transformation
              RubyTL::Rtl::TransformationObjectIndirection.new(@syntax_context)
              #@syntax_context.transformation_object
            end
            
            def this_rule
              RubyTL::Rtl::TransformationObjectIndirection.new(@syntax_context).this_rule
            end            
          }        
        end
        
        def in_transformation
          @transformation.name = current_node.attributes['name']
        end 
        
        def in_decorator
          @transformation.decorate_metaclass(current_node.attributes['metaclass'], 
          current_node.catched_block)
        end
        
        def in_import
          name = current_node.attributes['name']
          as = current_node.attributes['options'][:as]
          
          import = RubyTL::Rtl::ImportStatement.new(@dsl_loader, name, as)
    
          # Call the mini-language to parametrize with metamodels the callee transformation
          if current_node.catched_block
            name_mappings = ImportMappingMiniLanguage.new
            name_mappings.instance_eval(&current_node.catched_block)
            name_mappings.mappings.each { |key, value| import.add_name_mapping(key.to_s, value) }
            name_mappings.hooks_instantiation.each { |key, type| import.add_hook_instantiation(key.to_s, type) }
          end                  
          
          @transformation.imports << import					
          #retrieve(current_node.parent).imports << import					
        end
        
        def in_scheduling
          phase = retrieve(current_node.parent)
          RubyTL::Rtl::Scheduling.new(phase, current_node.catched_block)
        end
        
        def in_phase          
          parent_phase = retrieve(current_node.parent)
          phase = create_phase(current_node, parent_phase)          
          associate current_node, phase
        end      
        
        def in_rule
          add_rule(RubyTL::Rtl::DefaultRule, current_node)
        end
        
        def in_rule_mixin
          parent_phase = retrieve(current_node.parent)
          m = RubyTL::Rtl::RuleMixin.new(parent_phase, current_node.attributes['name'], current_node.catched_block)          
          associate current_node, m
        end
        
        def out_mixin
          parent_rule = retrieve(current_node.parent)          
          attrs.mixin_names.each do |name|
            r = parent_rule.owner.rule_mixins.find { |r| r.name == name }
            raise InvalidMixin.new("No rule mixin '#{name}' found for rule '#{parent_rule.name}'") unless r
            parent_rule.mixins << r
          end
        end
        
        def in_top_rule
          add_rule(RubyTL::Rtl::TopRule, current_node)
        end
        
        def in_copy_rule
          add_rule(RubyTL::Rtl::CopyRule, current_node)
        end
        
        def in_ignore_rule
          source, target = current_node.attributes['mappings'].unique_pair          
          phase = retrieve(current_node.parent)
          rule  = RubyTL::Rtl::IgnoreRule.new(source, target) 
          phase.ignore_rules << rule
          associate current_node, rule          
        end
        
        def in_refinement_rule
          add_rule(RubyTL::Rtl::RefinementRule, current_node)
        end
       
        def in_meta_rule
          name = current_node.attributes['name']
          kind = current_node.attributes['kind'][:for]
          raise InvalidPart.new("No :for => 'kind' part found in meta rule #{name}") unless kind
          rule = RubyTL::Rtl::MetaRule.new(name, kind)
          @transformation.add_meta_rule(rule)
          store(rule)
        end       
 
        def in_from
          retrieve(current_node.parent).from_part = check_type_part(RubyTL::Rtl::FromPart)
        end
        
        def in_to
          retrieve(current_node.parent).to_part = check_type_part(RubyTL::Rtl::ToPart)
        end
        
        def in_filter
          retrieve(current_node.parent).filter_part = check_code_part(RubyTL::Rtl::FilterPart)
        end
        
        def in_mapping
          retrieve(current_node.parent).mapping_part = check_code_part(RubyTL::Rtl::MappingPart)
        end
       
        def in_behaviour
          retrieve(current_node.parent).behaviour_part = check_code_part(RubyTL::Rtl::MetaBehaviourPart)
        end
 
        def in_hook
          # TODO: Check a hook is only valid for the "to" part
          factory = current_node.attributes['factory']
          raise InvalidPart.new("Hook not defined properly") if factory.size != 1
          hookname, type = factory.unique_pair
          hook = MetaclassFactoryHook.new(hookname, type)
          associate current_node, hook
          @transformation.factory_hooks << hook
        end
        
        def in_many
          metaclass = current_node.attributes['metaclass']
          seq = RubyTL::Rtl::Types::CollectionFactory.create_sequence(metaclass, @transformation)
          associate current_node, seq          
        end
        
        def in_Set
          $stderr << 'Warning: "Set" construct is deprecated, use "many" instead' + $/
          in_many
        end
        
        private
        def add_rule(rule_klass, node)
          phase = retrieve(node.parent)
          rule = create_rule(rule_klass, phase, node)
          associate node, rule
          
          # There is a weird coupling between TransformationContext and this...
          # I should find a better way to do this          
          if rule_klass != RubyTL::Rtl::RefinementRule
            add_to_global_context %{
              def #{rule.name}(instance)
                @syntax_context.transformation_object.explicit_call("#{rule.name}", instance)
              end
            }
          end
        end
        
        def check_type_part(klass)
          metaclasses = current_node.attributes['metaclass']
          raise InvalidPart.new(klass.name) unless (metaclasses && metaclasses.size > 0)
          metaclasses = metaclasses.map { |m| m.kind_of?(RubyTL::LowLevelDSL::EvaluationNode) ? retrieve(m) : m }
          klass.new(metaclasses)
        end
        
        def check_code_part(klass)
          raise InvalidPart(klass.name) unless current_node.catched_block
          klass.new(current_node.catched_block)
        end
      end            
      
    end    
  
    class ImportMappingMiniLanguage
      attr_accessor :mappings
      attr_accessor :hooks_instantiation
      def initialize()
        @mappings = {}
        @hooks_instantiation = {}
      end
      
      def map(hash)
        hash.each { |key, value| @mappings[key] = value }
      end
      
      def factory(hook_type_hash)
        @hooks_instantiation.merge!(hook_type_hash)
      end
    end
    
    module VisitorHelpers
      def create_phase(node, parent_phase, phase_name = node.attributes['name'])
        # TODO: I will somekind of node.kind_of_rule?('abstract_rule')
        phases = node.child_nodes.select { |n| n.keyword_name == 'phase' }
        rules  = node.child_nodes.select { |n| n.keyword_name =~ /rule$/ } 
        
        raise InvalidPhase.new("Invalid phase #{phase_name}") if phases.size > 0 && rules.size > 0
        
        return RubyTL::Rtl::PrimitivePhase.new(phase_name, parent_phase) if rules.size > 0
        return RubyTL::Rtl::CompositePhase.new(phase_name, parent_phase)
      end  
      
      def create_rule(rule_klass, phase, node)
        rule_name = node.attributes['name']
        rule_klass.new(phase, rule_name)
      end
      
    end
    
    class InvalidPhase < RubyTL::BaseError; end
    class InvalidPart < RubyTL::BaseError; end 
    class InvalidMixin < RubyTL::BaseError; end
  end
end


module RubyTL
  module Rtl
    
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
        @language_definition = RubyTL::Rtl::LanguageDefinition.info
        #@dsl_keywords = Hash.new
        @plugin_parameters = Hash.new
        #self.syntax = SyntaxHandler.new(self)
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
      
      # Two versions are needed: this one for access before the syntax has been processed and
      # the one defined "globally" (see above)
      def this_transformation
        @transformation_indirection ||= TransformationObjectIndirection.new(self)        
      end
    end
    
    class TransformationObjectIndirection
      def initialize(transformation_context)
        @context = transformation_context
      end

      def make_trace(source_element, target_element, rule = nil)
        make_traceN([source_element], [target_element], rule)
      end

      def make_traceN(source_elements, target_elements, rule = nil)
        if rule.nil?
          @context.transformation_object.status.add_isolated_trace(source_elements, target_elements)
        else
          @context.transformation_object.status.add_trace(source_elements, target_elements, rule)
        end
      end

      def this_rule
        @context.transformation_object.status.current_rule
      end
      
      def this_phase
         @context.transformation_object.status.current_phase
      end
      
      def method_missing(method_name, *args, &block)
        raise ::RubyTL::BaseError.new("Transformation not ready to be introspected.") unless @context.transformation_object
        @context.transformation_object.send(method_name, *args, &block)
      end   
    end
          
  end
end
