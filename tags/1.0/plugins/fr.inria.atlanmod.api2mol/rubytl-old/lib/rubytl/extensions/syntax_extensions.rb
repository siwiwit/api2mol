
module Plugins

  # A mixin to set and get information about the transformation
  # being executed
  module TransformationData
    attr_accessor :transformation
#    attr_accessor :syntax
#    attr_accessor :repository
  end

  # This class defines a DSL to define syntax extensions to
  # the language. You define a new language keyword using
  # the following:
  # 
  #    class MySyntax < SyntaxExtension  
  #       syntax 'my_new_keyword' do
  #         scope :dependent_keyword
  #         callback :keyword_handler
  #       end
  #
  #       def keyword_handler
  #         ...
  #       end
  #    end
  # 
  #
  class SyntaxExtension
    include TransformationData
    @@extensions = []
    cattr_reader :extensions    
  
    def self.inherited(subclass)
      @@extensions << subclass
      subclass.instance_eval do
        @keywords = []
      end      
    end    

    # Returns the list of keywords defined by this syntax extension.
    def self.keywords; @keywords; end
    
    # Each new syntax element (that is, a keyword) is defined
    # using this keyword.
    #
    # * <tt>keyword</tt>. The name of the keyword.
    # * <tt>block</tt>. A block with additional information about the syntax (required)
    #
    def self.syntax(keyword_name, &block)
      keyword = Keyword.new(keyword_name)
      keyword.context_instance = self.new
      keyword.instance_eval(&block)
      @keywords << keyword
    end
  
    # Inner class which represents a keyword and implements
    # the DSL part related to keyword information, that is, 
    # scope, callback, etc.
    class Keyword
      attr_accessor :context_instance
      attr_reader :name_
      attr_reader :callback_, :scope_
      attr_reader :nested_elements_, :parameters_
    
      def initialize(name)
        name = name.to_s
        raise Plugins::InvalidKeywordName.new("Invalid keyword '#{name}'") if invalid_keyword?(name)        
        @name_  = name
        self.scope(:transformation)
        self.nested_elements(:none)
        self.parameters()
      end
      
      # _Keyword_ to set the scope of the keyword. The scope of a keyword 
      # specifies from which keyword(s) it depends on, so that it can only
      # appears a block "attached" to such a keyword.
      # 
      # There are two special scopes: 
      # * <tt>:transformation</tt>
      # * <tt>:any_rule</tt>. The any_rule scope includes all rules, regardless of the keyword
      #
      def scope(*names) 
        @scope_ = names.stringify        
      end
      
      # _Keyword_ to set the callback that will handle the method.
      # Either a method name or a block should be given.
      def callback(method = nil, &block)
        raise "Invalid callback" if method.nil? and block.nil?
        @callback_ = LazyBlock.new(method, &block)
      end
    
      # _Keyword_ to set whether the keyword should have a nested element
      # or not. There are two options, 
      # * <tt>:mandatory</tt>. The keyword should have a block to enclose nested elements
      # * <tt>:optional</tt>. Nested elements are optional.
      # * <tt>:none</tt>. Nested are forbidden.      
      # The default option is <tt>:mandatory</tt>.
      def nested_elements(option = :mandatory)
        raise Plugins::InvalidOption.new("Invalid option, only :mandatory or :optional are valid") unless [:mandatory, :optional, :none].include?(option)
        @nested_elements_ = option
      end
      
      # _Keyword_ to set the parameters the keyword should take. A list of
      # symbols or strings which represent the parameter names is expected
      def parameters(*list)                        
        @parameters_ = list.join(', ')
      end
    
      # Creates the method header to be used in order to call the keyword
      def method_header
        "def self.#{self.name_}(#{self.parameters_})" 
      end
      
      # Creates the initial part of the method that checks the 
      # parameters.
      def method_checking
        '# TODO'      
      end
    
    private
      def invalid_keyword?(name)
        not name =~ /^\w+$/
      end
        
    end
  end

  class InvalidKeywordName < RubyTL::BaseError; end;
  class InvalidOption < RubyTL::BaseError; end;  
end
