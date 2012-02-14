require 'stringio'

module RubyTL
  module LowLevelDSL
    
    module EvaluatorMixin 
      attr_reader :info
      
      def initialize
        @info = EvaluatorInfo.new
      end

      # Keyword: global_context
      # Methods that belong to the DSL global context, so that
      # they can be called anywhere when evaluating the DSL
      def global_context(&block)
        @info.add_global(&block)
      end
      
      # keyword: keyword
      def keyword(name, options = {}, &block)
        definition = KeywordDSLDefinition.new(name)
        @info.keywords << info = definition.evaluate(&block)       
        analyze_keyword_options(info, options)
        info
      end
      
      # keyword: abstract_keyword
      def abstract_keyword(name, options = {}, &block)
        info = keyword(name, options, &block)
        info.abstract = true
        info
      end

      def import_for(resource_name, options = {})
        prefix = options[:as]
        uri    = options[:uri] 
        @info.add_import(resource_name, prefix, uri)
      end
            
      # keyword: composition_for
      def composition_for(keyword_name, &block)
        definition = CompositionDefinition.new(keyword_name)
        @info.compositions << info = definition.evaluate(&block)
        info
      end
      
      # keyword: root_composition
      def root_composition(&block)
        definition = CompositionDefinition.new('__root__')
        @info.root_composition = definition.evaluate(&block)        
      end
      
      def visitor_semantics(&block)
        @info.visitor_semantics << block
      end
      
      def decorator(metaclass, &block)
        metaclass.decorate(block)
      end     
      
      def mappings(&block)
        mappings_def = MappingsDefinition.new()
        @info.mappings = mappings_def.evaluate(&block)
      end
      
    private
      def analyze_keyword_options(keyword_info, options)
        if extends = options[:extends]
          extended_keyword = @info.keywords.find { |k| k.name.to_s == extends.to_s }          
          raise KeywordNotExist.new("Keyword not exist '#{extends}'") unless extended_keyword
          keyword_info.inherits_from = extended_keyword
        end        
      end
    end  
       
    class EvaluatorInfo
      attr_reader :keywords
      attr_reader :compositions
      attr_reader :global_context_methods
      attr_accessor :root_composition
      attr_accessor :visitor_semantics
      attr_accessor :mappings
      attr_reader :imports
      
      def initialize
        @keywords     = []
        @compositions = []
        @visitor_semantics = []
        @global_context_methods = []
        @imports = {}
      end    
      
      def add_global(&block)
        @global_context_methods << block
      end
      
      def abstract_keywords
        self.keywords.select { |k| k.abstract }
      end
      
      def concrete_keywords
        self.keywords.reject { |k| k.abstract }
      end
      
      def find_keyword(keyword_name)
        self.keywords.find { |k| k.name == keyword_name }
      end
      
      def add_import(resource_name, prefix, uri_scheme)
        @imports[uri_scheme] = ImportInfo.new(resource_name, prefix) 
      end
    end

    class Evaluator
      include EvaluatorMixin
    end
    
    class DslDefinition
      extend EvaluatorMixin
      
      def self.inherited(klass)
        klass.send(:initialize)
      end
    end

    class ImportInfo
      attr_reader :resource_name
      attr_reader :prefix
      def initialize(resource_name, prefix)
        @resource_name = resource_name
        @prefix        = prefix
      end
      
    end
    
    class KeywordDSLDefinition
      attr_reader :info
    
      def initialize(name)
        @info = KeywordInfo.new
        @info.name = name  
      end
      
      def evaluate(&block)
        self.instance_eval(&block) if block_given?
        @info
      end

      def param(name, type = :any, how_many = :one, opts = {})
        raise InvalidName.new("Name should be a string or symbol") unless name.kind_of?(String) || name.kind_of?(Symbol)
        raise InvalidType.new("Invalid type '#{type}'") unless ParamInfo::ALLOWED_TYPES.include?(type.to_s)
        raise InvalidCardinality.new("Invalid cardinality '#{how_many}'") unless [:one, :many, :zero_or_one].include?(how_many)
        param = ParamInfo.new(name, type, how_many, opts[:is_id])        
        @info.params << param
        param
      end
  
     
      # Keyword: catch_block
      def catch_block(true_or_false = true)
        @info.catch_block = true_or_false
      end
    end
        
    class KeywordInfo
      attr_reader :name
      attr_accessor :catch_block
      attr_accessor :abstract
      attr_accessor :inherits_from
      attr_reader :params
      #attr_accessor :id_param
      
      def initialize
        @params = []
      end
      
      def name=(name)
        raise InvalidKeywordName.new("Invalid keyword '#{name}'") if invalid_keyword?(name)
        @name = name
      end      
        
      def find_id_param
        self.params.find { |p| p.is_id }
      end
        
    private
      def invalid_keyword?(name)
        not name =~ /^\w+$/
      end    
    end    
  
    class ParamInfo
      ALLOWED_TYPES = [:id, :string, :integer, :hash, :class, :any].map(&:to_s)
      attr_reader :name
      attr_reader :type
      attr_reader :cardinality
      attr_reader :is_id
      
      def initialize(name, type, cardinality, is_id = false)
        @name = name.to_s
        @type = type.to_s
        @cardinality = cardinality
        @is_id = is_id
      end
      
      def many_cardinality?
        @cardinality == :many 
      end      
    end
    
    class CompositionDefinition
      def initialize(keyword_name)
        @info = CompositionInfo.new
        @info.keyword_name = keyword_name
      end

      def evaluate(&block)
        self.instance_eval(&block) if block_given?
        @info
      end
      
      # keyword: contain_keyword
      def contain_keyword(keyword_name, cardinality = 1)
        info = ContainedKeywordInfo.new
        info.keyword_name = keyword_name
        info.cardinality  = cardinality
        @info.contained_keywords << info
      end
    end
    
    class CompositionInfo
      attr_accessor :keyword_name
      attr_reader :contained_keywords
      
      def initialize
        @contained_keywords = []
      end
    end
    
    class ContainedKeywordInfo
      attr_accessor :keyword_name
      attr_accessor :cardinality # number or many
    end
    
    # Sandbox class for the mapping definition language.
    #
    # == Example
    #
    #   map 'family'      => Family::Family
    #   map 'dad'         => Family::Dad
    #   con 'family.dad'  => Family::Family.members
    #   ref 'family.head' => 'family.dad'   
    #
    class MappingsDefinition     
      def initialize
        @info = MappingsDefinitionInfo.new()
      end
      
      def map(hash)
        keyword, metaclass = nil, nil
        parameters = {}
        hash.each do |key, value|
          if value.respond_to?('is_rumi_class?')
            raise MapError.new('Too many maps') unless metaclass.nil?
            keyword, metaclass = key, value 
          else
            parameters[key.to_s] = value    
          end         
        end
        raise MapError.new('No keyword map set') if metaclass.nil?
        
        @info.add_map(keyword, metaclass, parameters)
      end
      
      def con(hash)
        hash.each do |path, reference|
          @info.add_con(path.split('.'), reference)
        end
      end
      
      def ref(hash)
        hash.each do |path, cs_reference|
          path, as_reference = path.split('/')
          split_path = path.split('.')
          @info.add_ref(split_path, cs_reference, as_reference) # TODO: This only handles global refs
        end      
      end
      
      def evaluate(&block)
        self.instance_eval(&block) if block_given?
        @info
      end
    end
    
    # Class to store the definitions given by the user to map concrete
    # syntax elements to abstract syntax metaclasses/references. It provides
    # the +do_map_for+, +do_ref_for+ and +do_con_for+ methods to set the
    # mappings as the visitor traverses the "syntax tree".    
    #
    class MappingsDefinitionInfo
      MapElement = Struct.new(:keyword, :metaclass, :parameters)
      ConElement = Struct.new(:keyword, :path_list, :reference)
      RefElement = Struct.new(:keyword, :path_list, :keyword_ref, :reference, :prefix)      
      
      attr_reader :maps
      
      def initialize
        @maps = {}
        @cons = {}
        @refs = {}
      end
      
      def add_map(keyword, metaclass, parameters)       
        @maps[keyword] = MapElement.new(keyword, metaclass, parameters)
      end
      
      def add_con(path_list, reference)
        keyword = path_list.last
        @cons[keyword] ||= []
        @cons[keyword] << ConElement.new(keyword, path_list, reference)
      end

      def add_ref(path_list, keyword_ref, reference = nil)
        keyword = path_list.last
        reference = path_list.last if reference.nil?
        keyword_ref, prefix = keyword_ref.split('::').reverse
        @refs[keyword] ||= []
        @refs[keyword] << RefElement.new(keyword, path_list, keyword_ref, reference, prefix) # TODO: Avoid convention over conf...
      end
      
      def do_map_for(keyword, node)
        if element = @maps[keyword]
          obj = element.metaclass.new
          fill_attributes(element, obj, node)
          yield obj
        end
      end
      
      def do_con_for(keyword, node)
        return unless @cons.key?(keyword)
        @cons[keyword].each do |element|  # TODO: Check that two elements are not applicable
          cnode   = node
          inverse = element.path_list.reverse
          inverse.each do |fragment|
            next if cnode.nil?
            next if fragment != cnode.keyword_name
            cnode = node.parent 
          end
          
          obj        = yield(node)
          parent_obj = yield(node.parent)          
          property = parent_obj.metaclass.rumi_property_by_name(element.reference)
          raise InvalidProperty.new("Invalid reference #{element.reference}") if property.nil?
      
          do_set(property, parent_obj, obj)      
        end
      end
      
      def do_ref_for(keyword, node, dsl_info, mapping_resolver)
        return unless @refs.key?(keyword)
        @refs[keyword].each do |element|
          keyword_obj    = mapping_resolver.find_keyword(element.prefix, element.keyword_ref)
          mapped_element = mapping_resolver.mapped_element(element.prefix, element.keyword_ref)
          #mapped_element = @maps[element.keyword_ref]
          
          raise MapError.new("No keyword #{element.keyword_ref}") unless keyword_obj
          raise MapError.new("No mapped element #{element.prefix}::#{element.keyword_ref}") unless mapped_element

          id_param = keyword_obj.find_id_param
          raise MapError.new("No id param defined for #{element.keyword_ref}") unless id_param          
          
          pname = mapped_element.parameters[id_param.name] || id_param.name  

          raise MapError.new("Too many attributes") unless node.attributes.size == 1        
          value = node.attributes.values.first
          
          # Flatten to handle :many cases
          [*value].each do |value|
            # TODO: Check only one element exists, but not here, in the moment
            # the element is first created : check key uniqueness
            
            # TODO: THIS IS TOO SIMPLISTIC SINCE IT CONSIDERS THAT THE SAME KEY
            # IS IN THE CSYNTAX AND ASYNTAX. IT DOESN'T ALLOW HANDLING PREFIXES
            value, prefix = value.split('::').reverse
            all = mapped_element.metaclass.all_objects.select { |o|
              o.get(pname) == value
            }
            
            raise MapError.new("Element '#{prefix}::#{value}' has not been defined") if all.size == 0
            raise MapError.new("Too many elements") if all.size > 1
            
            linked_element = all.first

            obj = mapping_resolver.object_for_node(nil, node.parent) #yield(node.parent)
            raise MapError.new("No mapping for #{node.parent.keyword_name}") unless obj          
            property = obj.metaclass.property(element.reference, true)
            do_set(property, obj, linked_element)
          end
        end          
      end
      
    private
      def do_set(property, parent_obj, obj)
        if property.multivalued?
          parent_obj.get(property) << obj
        else
          parent_obj.set(property, obj)
        end
      end
    
      def fill_attributes(element, obj, node)
        obj.metaclass.all_attributes.each do |att|
          value = node.attributes[att.name]
          obj.set(att.name, value) # casting, typecheck????          
        end
        element.parameters.each do |cs_name, as_name|
          obj.set(as_name.to_s, node.attributes[cs_name])
        end
      end
    end
    
    
    class KeywordNotExist < RubyTL::BaseError; end;
    class InvalidKeywordName < RubyTL::BaseError; end;
    class InvalidType < RubyTL::BaseError; end;
    class InheritanceCycle < RubyTL::BaseError; end;
    class InvalidCardinality < RubyTL::BaseError; end;  
    class MapError < RubyTL::BaseError; end;
    class InvalidProperty < RubyTL::BaseError; end;
  end
end

# TODO: Things that need to be addressed:
# * Duplicated keywords (even in different inner_elements blocks)
# 
#


module RubyTL
  module LowLevelDSL
    class EvaluatorInfo
   
      def pack
        unless @packed
          self.compositions.each { |c| c.pack(self) } 
          self.keywords.each { |k| k.pack(self) }
          self.mappings.pack(self) if self.mappings
          create_root_elements
        end
        @packed = true         
      end
      
      def find_keyword(keyword_name)
        return @root_keyword if @root_keyword && keyword_name == @root_keyword.name
        keyword = self.keywords.find { |k| k.name == keyword_name }
        
        # find in superclasses        
#        keyword ||= self.keywords.map { |k| k.inherits_from }.compact.
#                                  select { |k| k.abstract }.
#                                  find { |k| k.name == keyword_name }
        
        raise KeywordNotExist.new("I can't find '#{keyword_name}'") unless keyword
        keyword
      end
   
      def create_dsl_text
        io = StringIO.new
        self.pack
        create_global_context_module(io)
        concrete_keywords.each { |k| k.create_keyword_class(io) }
        create_evaluator(io)
        io
      end         
    
      def create_dsl        
        context = Module.new
        #context.module_eval io.string
        #dsl = context::Evaluator.new(evaluator_info)      
        create_dsl_in_context(context)
      end
    
      def create_dsl_in_context(context)
        io = create_dsl_text
        context.module_eval(io.string)
        context.module_eval "extend EvaluatorMixin"
        self.global_context_methods.each { |block| context::GlobalContext.module_eval(&block) }
        context.do_initialization(self, context)
        context
      end
    
    private
      def create_global_context_module(io)
        io.puts "module GlobalContext"
        io.puts "end"
      end
    
      def create_evaluator(io)
        io.puts "module EvaluatorMixin"
        io.puts   "include ::RubyTL::LowLevelDSL::ExecutionSemantics"   
        io.puts   "attr_reader :child_nodes"
        io.puts   "attr_reader :program_imports"
        io.puts   "def do_initialization(dsldef_info, syntax_context)"
        io.puts     "@dsldef_info = dsldef_info"
        io.puts     "@parent_node = self"
        io.puts     "@child_nodes = []"
        io.puts     "@syntax_context = syntax_context"
        io.puts     "@program_imports = []" 
        io.puts   "end"
        io.puts   "def keyword_name; '__root_sandbox_keyword__'; end"
        @root_keyword.create_all_keyword_methods(io)
        #@root_keyword.contained_keywords.each do |c|
        #  c.keyword.create_keyword_method(io) unless c.keyword.abstract
        #end
        create_import_statement(io) if generate_import_statement?
        io.puts "end"
      
        io.puts "class Evaluator"
        io.puts   "include EvaluatorMixin"
        io.puts   "def initialize(dsldef_info, context)"
        io.puts     "do_initialization(dsldef_info, context)"
        io.puts   "end"        
        io.puts "end"
      end

      def create_import_statement(io)
        io.puts "include ::RubyTL::LowLevelDSL::ImportationMechanism"
        io.puts "def import(resource, options = {})"
        io.puts   "@program_imports << ImportInfo.new(resource, options[:as])"
        io.puts "end"
      end
      
      def generate_import_statement?
        ! root_keywords.any? { |k| k.name == 'import' }
      end
      
      def create_root_elements      
        @root_keyword = KeywordInfo.new
        @root_keyword.name = '__root__'
        unless @root_composition
          main = root_keywords
          @root_composition = CompositionInfo.new
          @root_composition.keyword_name = @root_keyword.name
          main.each do |keyword|
            contained = ContainedKeywordInfo.new
            contained.keyword_name = keyword.name
            @root_composition.contained_keywords << contained 
          end
        end
        @root_composition.pack(self)
      end
      
      def root_keywords
        used = self.keywords.map { |k| k.contained_keywords }.flatten.
                             group_by(&:keyword)
        return self.keywords.reject { |k| used.key?(k) }        
      end
    end
    
    class CompositionInfo
      def pack(evaluator_info)
        keyword = evaluator_info.find_keyword(self.keyword_name)          
        self.contained_keywords.each { |contained| contained.pack(evaluator_info) }
        keyword.contained_keywords = self.contained_keywords 
      end
    end

    class ContainedKeywordInfo
      attr_reader :keyword
      def pack(evaluator_info)
        @keyword = evaluator_info.find_keyword(self.keyword_name)
      end
    end
    
    class MappingsDefinitionInfo
      def pack(info)
        self.maps.each do |key, value|
          keyword = info.find_keyword(key)
          recursive_add_map(keyword.inherits_from, value) if keyword.inherits_from           
        end
      end
    
    private
      def recursive_add_map(keyword, map_element)
        add_map(keyword.name, map_element.metaclass, map_element.parameters)
        recursive_add_map(keyword.inherits_from, map_element) if keyword.inherits_from           
      end
    end 
    
    class KeywordInfo
      CLASS_PREFIX = "KeywordClass"
      BLOCK_NAME   = "_block_"
      EVALUATION_NODE_CLASS = "::RubyTL::LowLevelDSL::EvaluationNode"

      attr_accessor :contained_keywords      
      attr_accessor :child_keywords
      
      alias_method :old_initialize, :initialize
      def initialize(*args)
        old_initialize(*args)
        @contained_keywords = []
        @child_keywords     = []
      end
      
      def pack(evaluator_info)
        if self.inherits_from
          current = self
          used = { current => true }          
          while parent = current.inherits_from          
            parent.child_keywords << self
            current = parent
            raise InheritanceCycle.new(self.name) if used.key?(current)
            used[current] = true
          end
        end
      end
            
      def create_keyword_class(io)
        io.puts "class #{self.klass_name}"
        io.puts   "include GlobalContext"
        io.puts   "def initialize(syntax_context, parent_node)"
        io.puts     "@syntax_context = syntax_context"
        io.puts     "@parent_node = parent_node"
        io.puts   "end"
        create_all_keyword_methods(io)
        io.puts "end"
      end
      
      def create_all_keyword_methods(io)
        childs = self.all_contained_keywords.map { |c| c.keyword.child_keywords }.flatten
        all    = self.all_contained_keywords.map { |c| c.keyword } + childs           
        all.reject { |k| k.abstract }.each { |k| k.create_keyword_method(io) }      
      end
      
      def create_keyword_method(io)
        io.puts "def #{self.name}(#{self.keyword_formal_params})"
        io.puts   "node = #{EVALUATION_NODE_CLASS}.new('#{self.name}', @parent_node)"      
        self.all_params.each do |param|
          param.create_node_setter(io, 'node')
        end
        if self.catch_block
          io.puts "node.catched_block = #{BLOCK_NAME}" 
        else
          io.puts "context = #{self.klass_name}.new(@syntax_context, node)"
          io.puts "context.instance_eval(&#{BLOCK_NAME}) if block_given?"
        end
        io.puts   "node"
        io.puts "end"
      end
      
      def klass_name
        "#{CLASS_PREFIX}_#{self.name}"
      end      
      
      def keyword_formal_params
        check_params
        name_list = self.all_params.map { |p| p.formal_param } + ['&' + BLOCK_NAME]
        name_list.join(',')
      end

      def all_params
        (self.inherits_from ? self.inherits_from.all_params : []) +
          self.params        
      end
    
      def all_contained_keywords
        self.contained_keywords + 
          (self.inherits_from ? self.inherits_from.all_contained_keywords : [])
      end        
    private
      def check_params
        the_params = self.all_params
        the_params.each_with_index do |p, idx|
          if p.many_cardinality? && idx != the_params.size - 1 
            raise InvalidCardinality.new("Many cardinality should be the last param") 
          end
        end 
      end
    end
 
    class ParamInfo
          
      def formal_param
        if @cardinality == :one
          @name
        elsif @cardinality == :many
          "*#{@name}"
        elsif @cardinality == :zero_or_one
          @type == :hash ? "*#{@name} = {}" : "#{@name} = nil"
        else
          raise "Invalid cardinality #{@cardinality}"
        end
        
        #@cardinality == :one ? @name : "*#{@name}"
      end
        
      def actual_param
        @name
      end  
      
      def create_node_setter(io, node_name)
        io.puts "#{node_name}.attribute_set('#{@name}', #{self.actual_param})"
      end
    end
    
    class EvaluationNode
      IN_PREFIX = "in_"
      OUT_PREFIX = "out_"
      
      attr_reader :attributes
      attr_reader :keyword_name
      attr_reader :child_nodes
      attr_reader :parent
      attr_accessor :catched_block
      
      def initialize(keyword_name, parent = nil)
        @keyword_name = keyword_name
        @child_nodes  = []
        @attributes   = {}
        @parent       = parent
        @parent.child_nodes << self if parent
      end

      def is_root?
        @parent.nil? || ! @parent.respond_to?(:keyword_name)
      end
      
      def attribute_set(name, value)
        @attributes[name] = value
      end
      
      def accept(visitor)
        visitor.call_in_out(in_name, out_name, self) do
          self.child_nodes.each { |node| node.accept(visitor) } 
        end
      end
      
      def attrs
        RubyTL::Base::AttributesProxy.new(self.attributes)
      end

      def children_by_kind(keyword_name, &block) 
        result = self.child_nodes.select { |n| n.keyword_name == keyword_name }
        result.each(&block) if block_given?
        result
      end
           
    private
      def in_name
        IN_PREFIX + self.keyword_name
      end
      
      def out_name
        OUT_PREFIX + self.keyword_name
      end
    end

    # Represents the information of a program already
    # loaded. It references,
    #   * <tt>dsldef</tt>. The underlying definition
    #   * <tt>evaluator</tt>. The tree representation
    #   * <tt>mappings</tt>. An object containing the "links" between nodes and objects.  
    LoadedProgram = Struct.new(:dsldef, :evaluator, :visitor)
    
    module ExecutionSemantics  
      def keyword_name; '__root_name'; end
      	
    	#
    	# == Arguments
    	# * <tt>dsl_loader</tt>. An optional loader to import the result of another
    	#                        DSLs into this DSL.
    	# 
    	def execute_visitor_semantics(dsl_loader = nil)
        raise "No semantics defined" if @dsldef_info.visitor_semantics.size == 0
        visitor_klass = Class.new do
          attr_accessor :mapping_resolver
          def initialize(syntax_context, dsldef_info, dsl_loader = nil)
            @syntax_context = syntax_context
						@dsl_loader = dsl_loader
            @dsldef_info = dsldef_info
          end
        end
        visitor_klass.send(:include, VisitorHelperFunctions)
        visitor_klass.send(:include, VisitorMapping)
        visitor_klass.send(:include, ImportationMechanism)        
        @dsldef_info.visitor_semantics.each do |block|
          visitor_klass.class_eval(&block)
        end               
        visitor = visitor_klass.new(@syntax_context, @dsldef_info, dsl_loader)        
        loaded_program   = LoadedProgram.new(@dsldef_info, self, visitor)
        visitor.mapping_resolver = MappingResolver.new(loaded_program) 
                            # TODO: Generalize to make store/retrieve in visitor methods
                            # access by means of this class. 
        
        visitor.import_resources(self.program_imports)
                
        # Start visitor
        visitor.call_in_out(:start, :finish, self) do
          self.child_nodes.each { |node| node.accept(visitor) }
        end

        return loaded_program
      end  

      module VisitorHelperFunctions
        include RubyTL::Base::VisitorMixin
        alias_method :old_call_in_out, :call_in_out
        
        # Overriden version of VisitorMixin#call_in_ourt that deals
        # with mapping issues.  
        def call_in_out(in_method_name, out_method_name, node, &block)
          #perform_mapping
          #old_call_in_out(in_method, out_method, node, &block)
          change_current_node(node) do
            perform_mapping unless @dsldef_info.mappings.nil?
            self.call_if_exist(in_method_name)
            yield    
            self.call_if_exist(out_method_name)
          end  
        end
        
        def add_to_global_context(text = nil, &block)
          @syntax_context::GlobalContext.module_eval(text)   if text
          @syntax_context::GlobalContext.module_eval(&block) if block_given?            
        end
      end

      module VisitorMapping
        def perform_mapping                   
          keyword = @current_node.keyword_name
          @dsldef_info.mappings.do_map_for(keyword, @current_node) do |obj|           
            store obj
          end
          @dsldef_info.mappings.do_con_for(keyword, @current_node) do |node|
            retrieve node
          end       
          @dsldef_info.mappings.do_ref_for(keyword, @current_node, @dsldef_info, @mapping_resolver) do |node|
            retrieve node
          end       
        end
      end      
    end      

    module ImportationMechanism
      URI_SCHEME_REGEXP = /^(\w+):\//
      def import_resources(program_imports)
        return if not @dsl_loader.respond_to? :load_program_tree
        program_imports.each do |import|
          definition     =  definition_for(import.resource_name)
          loaded_program = @dsl_loader.load_program_tree(rename_resource(import.resource_name), definition.resource_name)
          @mapping_resolver.add_loaded_program(definition.prefix, loaded_program)
        end
      end
      
      def rename_resource(resource_name)
        resource_name.sub(URI_SCHEME_REGEXP, 'mo:/')
      end
      
      def definition_for(program_uri)
        program_uri =~ URI_SCHEME_REGEXP
        scheme      = $1
        import_def  = @dsldef_info.imports[scheme]
        raise ImportError.new("No uri defined #{scheme}") unless import_def
        return import_def
      end
    end   

    # This is class contains references to all evaluators loaded as part
    # of a family of programs, resolving 
    class MappingResolver
      def initialize(default_program)
        @default_program = default_program
        @loaded_programs = {}
      end
      
      def add_loaded_program(prefix, loaded_program)
        @loaded_programs[prefix] = loaded_program
      end
      
      # Returns the metaclass that is mapped to a certain keyword
      # of a DSL program.
      def mapped_element(prefix, keyword_ref)
        program = choose_program(prefix)
        program.dsldef.mappings.maps[keyword_ref] 
      end

      def find_keyword(prefix, keyword_ref)
        program = choose_program(prefix)
        program.dsldef.find_keyword(keyword_ref) 
      end
      
      def object_for_node(prefix, node) 
        program = choose_program(prefix)
        program.visitor.retrieve(node)
      end
    
    private
      def choose_program(prefix)
        if prefix == nil
          @default_program
        else
          loaded = @loaded_programs[prefix]
          raise ImportError.new("No import defined for prefix '#{prefix}'") unless loaded
          loaded
        end         
      end
    end
    
    class ImportError < RubyTL::BaseError; end;
        
  end
end