module RubyTL 
  module Templating

    class LanguageDefinition < RubyTL::LowLevelDSL::DslDefinition      
      
      keyword('rule') { param :name, :id, :one }
      keyword('from') { param 'type', :class, :one }
      keyword('text') { catch_block }
      keyword('filter') { catch_block }
      keyword('param') { param :names, :id, :many}
      keyword('ignore') { param :what, :any, :one }
      
      root_composition do
        contain_keyword 'rule'
      end

      composition_for 'rule' do
        contain_keyword 'param'
        contain_keyword 'from'
        contain_keyword 'ignore'
      end
      
      composition_for 'from' do
        contain_keyword 'filter'
        contain_keyword 'text'
      end

      visitor_semantics do
        attr_reader :transformation
      
        def start
          @transformation = RubyTL::Templating::Transformation.new() # TODO: Look for the transformation name
          associate current_node, @transformation
        end
        
        def out_rule
          parts  = current_node.child_nodes.select { |n| n.keyword_name == 'from' }.map { |c| retrieve(c) }
          params = current_node.child_nodes.select { |n| n.keyword_name == 'param' }.map { |c| retrieve(c) }
          ignores = current_node.child_nodes.select { |n| n.keyword_name == 'ignore' }.map { |c| retrieve(c) }
          name  = current_node.attributes['name']
          params = params.flatten.map do |param_name|
            RubyTL::Templating::RuleParam.new(param_name)
          end
          rule  = RubyTL::Templating::Rule.new(@transformation, name, parts, params, ignores)
          retrieve(current_node.parent).rules << rule
        end        
        
        def out_param
          current_node.attributes['names'].each do |name|
            store(name)
          end
        end

        def out_ignore
          what = current_node.attributes['what']
          if what.respond_to? :is_rumi_class?
            store(IgnoreMetaclassPart.new(what))
          elsif what.to_s == 'all'
            store(IgnoreAllPart.new())
          else
            RuleStructureError.new('Invalid kind of ignore')
          end 
        end
                
        def out_from
          # TODO: Avoid multiple text / filter
          text   = current_node.child_nodes.find { |c| c.keyword_name == 'text' }
          filter = current_node.child_nodes.find { |c| c.keyword_name == 'filter' }          
          raise RuleStructureError.new("Expected one 'text' part in the rule") unless text
          type = current_node.attributes['type']
          part = RubyTL::Templating::RulePart.new(type, text.catched_block)
          part.filter_block = filter.catched_block if filter          
          associate current_node, part
        end       
      end
    end
  end
end

module RubyTL
  module Templating
  
    class Transformation
      attr_reader :rules
      attr_reader :status
      attr_accessor :mapper
      attr_accessor :template_creator
      
      def initialize
        @rules  = []
        @status = ExecutionStatus.new
      end
      
      def apply_rule(rule_name, element, parameters = {})
        matched_rule = @rules.select { |rule| rule.name == rule_name.to_s }.first
        raise RuleError.new("Rule '#{rule_name}' not exist") unless matched_rule
        [*element].compact.each { |e| matched_rule.apply_for_element(e, parameters) }
      end
    end
  
    class Rule
      attr_reader :name
      attr_reader :parts
      attr_reader :params
    
      def initialize(transformation, name, rule_parts, rule_params, ignores)
        @transformation = transformation
        @name = name.to_s
        @parts = rule_parts
        @params = rule_params
        @ignores = ignores
      end
      
      def apply_for_element(element, parameters = {})        
        matched_parts = @parts.select { |part| part.match?(element) }
        matched_parts = disambiguate(matched_parts, element)
        if matched_parts.size == 0
          return if @ignores.any? { |i| i.ignore?(element) }
          raise RuleError.new("No matched parts for rule '#{self.name}'", element)
        end                
        raise RuleError.new("Too many matched parts for rule '#{self.name}'", element) if matched_parts.size > 1

        with_options(parameters) do |param_list|
          param_list = check_parameters(param_list)
          matched_parts.first.execute(@transformation, element, param_list)
        end
      end

    private
      OPTION_LIST = ['inc_indent']
      def with_options(options = {})  
        indent = options[:inc_indent]
        @transformation.status.current_file.inc_indent if indent
        yield(options.delete_if { |key, _| OPTION_LIST.include?(key.to_s) })
        @transformation.status.current_file.dec_indent if indent
      end
      
      def check_parameters(parameters)
        parameters.each do |key, _|
          raise RuleError.new("Parameter '#{key}' not defined", nil) unless @params.any? { |p| p.name.to_s == key.to_s }
        end
        @params.each do |p|
          raise RuleError.new("Parameter '#{p.name}' not given", nil) unless parameters[p.name.to_s] || parameters[p.name.to_s.intern]          
        end
        parameters
      end
      
      def disambiguate(matched_parts, element)
        return matched_parts if matched_parts.size <= 1
        result = matched_parts.sort_by { |p| p.distance_to_type(element) }
        result.reject { |p| p.distance_to_type(element) > result.first.distance_to_type(element) }
      end
    end

    class RuleParam
      attr_reader :name
      def initialize(name)
        @name = name
      end
    end
    
    class IgnoreAllPart
      def ignore?(obj); true; end
    end
    
    class IgnoreMetaclassPart
      def initialize(metaclass)
        @metaclass = metaclass
      end
      
      def ignore?(obj); obj.rumi_kind_of?(@metaclass); end        
    end
    
    class RulePart
      attr_reader :type
      attr_accessor :filter_block
      
      def initialize(type, text_block)
        @type = type
        @text_block = text_block
        raise ::SyntaxError.new("No text block given") unless @text_block
      end
      
      def match?(element)
        r = element.metaclass.conforms_to(@type)
        if @filter_block
          r = r && FilterProxy.new(element).instance_eval(&@filter_block)
        end
        r
      end

      # TODO: Naive implementation. The supertypes property should be used.
      def distance_to_type(element)
        return 0 if element.metaclass == @type
        return 1000 
      end
      
      def execute(transformation, element, param_list)
        ExecutionProxy.new(element, transformation, param_list).instance_eval(&@text_block)
      end
    end
      
    # This is class keep the status of a particular running
    # transformation. The status is usually shared among several
    # "keyword execution contexts".
    # 
    # == Status
    # The transformation status is composed of:
    # 
    # * <tt>current_indentation</tt>.
    # * <tt>current_file</tt>
    class ExecutionStatus
      attr_accessor :indent
      attr_accessor :base_indent
    
      def initialize
        @indent = 0
        @base_indent = 3
        @file_stack = []
      end
    
      def push_file(file)
        @file_stack.push(file)
      end
      
      def pop_file
        @file_stack.pop
      end
      
      def current_file
        raise "No file defined" if @file_stack.empty?
        @file_stack.last
      end
    end
  end
end

module RubyTL
  module Templating
    
    module HelperMethods
    private
      def template_text(filename)
        @mapper.read_template(filename)
      end
      
      def write_result(file, result)
        if file.kind_of? ComposedFile
          file.append_partial_result(result)
        else
          @mapper.write_file(file, result, @codebase)
        end
      end

      def locate_template_mapping(hash)
        hash.each do |key, value|
          return key, value if check_template_mapping_condition(key, value)
        end
        raise "No template matching found"
      end
      
      def locate_variable_mapping(hash)
        hash.select { |key, value| not check_template_mapping_condition(key, value) }
      end
      
      def check_template_mapping_condition(key, value)
        key.kind_of?(String) &&
          (value.kind_of?(String) || value.kind_of?(ComposedFile))
      end
    end
    
    # These are KeywordOperations
    module ApplyOperations
      include HelperMethods
      include RubyTL::Base::ExceptionHandling  
        
      def apply_rule(rule_name, element, parameters = {})
        # TODO: Handle options
        # 
        @transformation.apply_rule(rule_name, element, parameters)
      end
      
      def apply_template(template_name, options = {})   
        filename = @mapper.map_file(template_name)
        text     = template_text(template_name)
        variable_mapping = locate_variable_mapping(options)

        erbt = @transformation.template_creator
        erbt.generate_code(filename, text, @transformation, variable_mapping) { |result|
          write_result(@status.current_file, ToCodeHelper.adapt_text(result, @status.indent))
        }
        #handle_runtime_dsl_exceptions(filename) do
        #  generator = TextGenerator.new(filename, text, :transformation => @transformation)
        #  result = generator.generate()                
        #  write_result(@status.current_file, ToCodeHelper.adapt_text(result, @status.indent))        
        #end          
      end

      def base_indent(num)
        raise IndentationError.new("The indentantion must be positive or zero") if num < 0
        @status.base_indent = num
      end

      def indent(num)
        raise IndentationError.new("The indentantion must be positive or zero") if num < 0
        old_indent = @status.indent
        @status.indent = num     
        if block_given?
          yield
          @status.indent = old_indent
        end   
      end

      def inc_indent
        raise IndentationError.new("Indentantion is not set") unless @status.indent
        @status.indent += @status.base_indent
        if block_given?
          yield
          @status.indent -= @status.base_indent
        end
      end

      def dec_indent
        raise IndentationError.new("Indentantion is not set") unless @status.indent
        @status.indent -= @status.base_indent
      end

      def context_set(transformation, status, mapper)
        @transformation = transformation
        @status = status
        @mapper = mapper
      end
    end
    
    # TODO: Blank slate proxies...    
    class FilterProxy
      def initialize(obj)
        @obj = obj
      end

      def method_missing(name, *args, &block)        
        return @obj.send(name, *args, &block)# if @obj.respond_to?(:name)
      end      
    end
    
    class ExecutionProxy
      include ApplyOperations

      def initialize(obj, transformation, param_list)
        @obj = obj
        context_set(transformation, transformation.status, transformation.mapper)
        param_list.each do |key, value|
          (class << self; self; end).send(:define_method, key.to_s) { value }
        end
      end

      def _obj
        @obj
      end
            
      #alias_method :old_method_missing, :method_missing
      def method_missing(name, *args, &block)        
        current_file = @transformation.status.current_file
        return current_file.send(name, *args, &block) if current_file.respond_to?(name)
        return @obj.send(name, *args, &block)# if @obj.respond_to?(:name)
        #old_method_missing(name, *args, &block)
      end

      # TODO: Delegate common methods
      def type
        @obj.type
      end
    end

=begin
    class Model
      def initialize(models)
        @models = models
      end

      # TODO: Definir operaciones
    end
=end  
    class ComposedFile
      include ApplyOperations
      
      attr_reader :text
    
      def initialize(transformation, status, mapper)
        context_set(transformation, status, mapper)
        @join_separator = $/
        @text = ''
      end
    
      def append_partial_result(partial_text)
        @text << @join_separator unless @text == ''
        @text << partial_text
      end
     
      def <<(value) 
        @text << value
      end#(value)
         
      def join_by(separator)
        @join_separator = separator
      end
      
      def inline(value)
        raise "TODO: Apply a template"
        # @text << value
      end
      
      def println(value = '')        
        @text << ToCodeHelper.adapt_text(value, @status.indent) if value != nil
        @text << $/
        value
      end

      def print(value)
        @text << ToCodeHelper.adapt_text(value, @status.indent)
        value
      end      
    end    

    class TemplatesDefinition
      def initialize
        @templates = {}
      end
      
      def template(name, code)
        @templates[name] = code
      end
    end

    # A module with instance methods to work with templates
    # and files.
    module ToCodeHelper
      include ApplyOperations
    
      attr_reader :model
      
      # TODO: Is this a good way to initialize variables?
      # TODO: How to share variables among clases that include the same module
#      def self.extended(mod)
#        mod.instance_variable_set("@transformation", Transformation.new)
#      end
      
      def start_transformation(file_path)
        raise NoMainElement.new("No main element defined for '#{file_path}'") unless @main
        @transformation.mapper = @mapper
        @transformation.template_creator = @template_creator
        @status = @transformation.status
        @main.call
      end

      def decorator(metaclass, &block)
        metaclass.decorate(block)
      end
      
      def main(&block)
        @main = block
      end
      
      def compose_file(file, &block)
        composed = ComposedFile.new(@transformation, @status, @mapper)
        @status.push_file(composed)
        composed.instance_eval(&block)
        write_result(file, composed.text)
      end
      
      #def templates(&block)
      #  @templates ||= TemplatesDefinition.new
      #  @templates.instance_eval(&block)
      #end
      
      # Keyword: template_to_file
      # 
      # Apply a template to generate a file. The mapping between templates
      # and filenames is done by a hash entry with two strings. The other
      # options of argument-hash are variable bindings, whose keys must
      # be symbols.
      # 
      # == Usage
      #
      #   template_to_file "file.template" => "filename.txt", :varname => var
      #   template_to_file "file.template" => "filename.txt", 'varname' => 'astring'  # Incorrect
      #
      # The second example is incorrect because both "template mapping" and
      # "variable mapping" use strings as key and values, so it's impossible
      # to disambiguate them.
      #      
      def template_to_file(options = {})
        template_name, output_file = locate_template_mapping(options)  
        template_filename = @mapper.map_file(template_name)
        template_text     = template_text(template_name)
        variable_mapping  = locate_variable_mapping(options)

        erbt = @transformation.template_creator
        erbt.generate_code(template_filename, template_text, @transformation, variable_mapping) { |result|
          write_result(output_file, ToCodeHelper.adapt_text(result, @status.indent))
        }
        
        #handle_runtime_dsl_exceptions(template_filename) do
        #  generator = TextGenerator.new(template_filename, template_text, :transformation => @transformation)
        #  result = generator.generate(locate_variable_mapping(options))                
        #  write_result(output_file, ToCodeHelper.adapt_text(result, @status.indent))
        #end          
      end
      
      def self.adapt_text(text, indent)
        if indent && indent > 0
          fill = " " * indent
          #text = fill + text unless text[0..0] == $/
          text = text.gsub(/^(.+)$/) { |value| fill + value }
        end
        text
      end
    end

    class ERBTemplateCaller
      include RubyTL::Base::ExceptionHandling  
    
      def initialize(template_binding_class)
        @template_binding_class = template_binding_class
      end 
      
      def generate_code(filename, text, transformation, variable_mapping)
        status = transformation.status
        handle_runtime_dsl_exceptions(filename) do
          options   = { :transformation => transformation, :template_binding_class => @template_binding_class.dup }
          generator = ToCodeTextGenerator.new(filename, text, options)
          result = generator.generate(variable_mapping)
          yield(result)                
          #write_result(where_to_write_result, ToCodeHelper.adapt_text(result, status.indent))        
        end          
      end
    end
     
    # Class where to bind a file with 2code rules. 
    # A 2code file is a file with an structure like this:
    #
    #   model.foreach(Class::ClassM) do |klass|
    #     template "javaclass.template" => "#{klass.name}.java", :klass => klass
    #   end
    # 
    #   compose_file('tables.sql') do |file|
    #     model.foreach(Relational::Table) do |table|
    #       template 'sqltable.template" => file, :table => table
    #     end
    #
    #     model.foreach(Relational::FKey) do |fkey|
    #       template 'sqlalter.template" => file, :fkey => fkey
    #     end
    #   end   
    #
    # This class provides the set of helper methods to easily
    # accessing a model and to render templates to files.
    #
    class ModelToCode
      include RubyTL::Base::ExceptionHandling
  
      def self.create_dsl_module(mapper, codebase, parameters = {})
        mod = Class.new do
          extend ToCodeHelper
          extend RubyTL::HelperLoading
          extend RubyTL::ParameterHandling
          class << self
            attr_accessor :mapper, :codebase
            attr_accessor :template_creator            
          end
        end
        mod.load_helper_set(mapper.workspace, mod) # TODO: Scattered through some places, factorize in "extend HelperLoading"
        mod.parameter_set(parameters)
        
        # Template binding adapted for helper loading
        tbinding = Class.new(TemplateBindingWithOperations) do
          @@to_code_mod = nil
          def self.__to_code_mod=(to_code_mod); @@to_code_mod = to_code_mod; end
          def self.const_missing(name)
            @@to_code_mod.const_get(name)
          end  
        end
        tbinding.__to_code_mod = mod
        mod.template_creator = ERBTemplateCaller.new(tbinding)
        
        #mod.model = @model
        mod.mapper = mapper
        mod.codebase = codebase
        mod      
      end
  
      # Eval the given +file+ in the context of this class. It provides
      # the Ruby code in the 2code file to access helper methods
      # defined in the Model2Code class.
      # 
      # == Params
      # * <tt>file</tt>: a File object
      #
      # == Usage
      #   
      #   m2c = Model2Code.new(a_model)
      #   File.open('/tmp/afile') do |file|
      #      m2c.bind_and_eval(file)
      #   end
      #
      def bind_and_eval(file)
        raise "No longer valid"
        @source_models.each { |m| m.bind_to_context(mod) }

        language_definition = RubyTL::Templating::LanguageDefinition.info 
        #language_definition.generate_dsl(mod)
        language_definition.create_dsl_in_context(mod)
        
        handle_runtime_dsl_exceptions(file.path) do
          mod.module_eval(file.read, file.path || '')
        end

        visitor = mod.execute_visitor_semantics
                
        mod.instance_variable_set("@transformation", visitor.transformation) # TODO: Do it in other way
        mod.start_transformation(file.path)
      end          
    end
    
    class NoMainElement < RubyTL::RGenException; end
    class IndentationError < RubyTL::RGenException; end
    class RuleError < RubyTL::RGenException 
      def initialize(message, element = nil)
        super(message + which_element(element))
      end
      
      def which_element(element)
        return '' if element.nil?
        # TODO: Factorize with other cases
        "and object #{element.metaclass.name} " + $/ + "\t" + "where #{element.metaclass.name} = { #{element} }"   
      end
    end
    class RuleStructureError < RubyTL::RGenException; end
  end
end