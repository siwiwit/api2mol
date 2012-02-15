require 'erb'

module RubyTL
  module Templating

    class TextGenerator 
      
      def initialize(template_file, template_str, options = {})
        @options = options
        @comment_hook = create_comment_hook(options)
        @erb = ERB.new(template_str, nil, '-%<>')
        @erb.filename = template_file
        @transformation = options[:transformation]
      end
      
      def generate(local_vars = {})
        b = create_template_binding
        b.locals = local_vars
        b.comment_hook = @comment_hook
        compute_result(b)
      end

      def extract_free_blocks
        content, frees = visit_free_blocks
        frees
      end

      def merge(previous_free_blocks)
        content, frees = visit_free_blocks(previous_free_blocks)
        @result = content.join
      end

      def result
        @result
      end

    protected
      def create_template_binding()
        if @transformation
          TemplateBindingWithOperations.new(@transformation)
        else
          TemplateBinding.new
        end       
      end

      def compute_result(b)
      	@result = @erb.result(b.binding)      
      end
      
    private
      def create_comment_hook(options)
        start_comment = options[:one_line_comment]
        open_comment, close_comment = options[:multiline_comment]

        if start_comment
          Proc.new { |id| start_comment + id }
        elsif open_comment && close_comment
          Proc.new { |id| open_comment + id + close_comment }
        else
          create_comment_hook(:one_line_comment => '//$')
        end
      end

      def generate_regexp_for_comment(options)
        start_comment = options[:one_line_comment]
        open_comment, close_comment = options[:multiline_comment]

        if start_comment
          start_comment = adapt_comment_tag(start_comment)
          Regexp.new("#{start_comment}(.+)\\n")
        elsif open_comment && close_comment
          open_comment  = adapt_comment_tag(open_comment)
          close_comment = adapt_comment_tag(close_comment)
          Regexp.new("#{open_comment}((.|\\n)+)#{close_comment}\\n")
        else
          generate_regexp_for_comment(:one_line_comment => '//$')
        end
      end

      def adapt_comment_tag(value)
       ['$', '^'].each do |sub|
         value = value.gsub(sub, "\\#{sub}")
       end
       value
      end

      def visit_free_blocks(previous_frees = {})
        content = []
        #comment_tag = adapt_comment_tag(@one_line_comment)
        #regexp = Regexp.new("#{comment_tag}(.+)\\n")
        regexp = generate_regexp_for_comment(@options)
        frees = {}
        current_id = nil
        last_id = nil
        lines = []
        @result.each_line do |line|
           if line =~ regexp
             current_id = $1.strip

             # is the opening of a free block?
             if last_id == nil
               last_id = current_id
               lines = [line]
             elsif current_id == last_id
               frees[current_id] = lines[1..-1].join
               last_id = nil

               if previous_frees.has_key? current_id
                  content.push(lines.first)
                  content.push(previous_frees[current_id])
               else
                  content.push(*lines)
               end
               content.push(line)
             else
               raise "Bad balancing in block <#{last_id}> and in block <#{current_id}>" 
             end
           elsif last_id != nil
             # A block is currently opened, so lines between start
             # and end are stored, but whole lines aren't
             lines << line
           else
             # A line in a protected part of the file, so it is normally added
             # to the content representation
             content << line
           end
        end
        return content, frees
      end
    end

    class ToCodeTextGenerator < TextGenerator
      def initialize(template_file, template_str, options = {})
        @template_binding_class = options[:template_binding_class]
        super
      end

      def create_template_binding()
        @template_binding_class.new(@transformation)
      end

      def compute_result(b)
        @result = b.instance_eval @erb.src, @erb.filename, 1
      	#@result = @erb.result(b.binding)
      end
    end


    # A class where include methods and variables to be used in
    # a template. Helper could be included in such objects.
    #
    # == Example
    #    erb = ERB.new(template_str, nil, '%<>')
    #    b = TemplateBinding.new
    #    b.extend(HelperModule)
    #    erb.result(b.binding)  
    class TemplateBinding
      public :binding

      attr_reader :locals
      attr_accessor :comment_hook

      def initialize
        @id_stack = []
      end

      # Set the local variables for a template. For every value in
      # +locals_hash+ a method named same as the key is generated.
      # Such a method returns the value as if it were a local variable.
      def locals=(locals_hash)
        @locals = locals_hash
        @locals.each do |key, value|
          self.class.send(:define_method, key) { value }
        end
      end

      # Opens a free block which must be closes with a call to
      # +close_free_block+.
      def open_free_block(id)
        @id_stack.push(id.to_s)
        @comment_hook.call(id)
      end
      
      # Closes a free block opened with a call to +open_free_block+
      def close_free_block
        raise "Free blocks bad ended" if @id_stack.empty?

        id = @id_stack.pop
        @comment_hook.call(id)
      end
    end

    class TemplateBindingWithOperations < TemplateBinding 
      include RubyTL::Templating::ApplyOperations
      
      def initialize(transformation)
        context_set(transformation, transformation.status, transformation.mapper)
      end

   	  # This method is overrided to avoid the result to be directly added
			# to the file. This is because, the result should be written by
			# the ERB engine. 
			# 
			# It returns the same value as the +result+ parameter.
	  	def write_result(file, result)
				result
      end
			
      def apply_rule(rule_name, element, options = {})
      	raise "Rules cannot be called within templates yet. Not implemented"
      end	
    end
  end
end
