
  module Plugins
      
    # The default rule that should be inherited by plugin's developers
    # in order to define a new kind of rule.
    #
    # == Available hooks
    #
    # == Available filters
    #
    class Rule < RubyTL::Rule
      include RubyTL::Plugins::RuleActionsHelper
      include RubyTL::Plugins::ContextInformation      
      include Plugins::RuleLifeCycle
      extend  Plugins::Filtering      
      
      attr_reader :data
      
      def initialize(context, *args)        
        load_context_information(context)
        @data = Hash.new
        super(context.transformation_, *args)
      end
      
      # Filters which are called before and after a rule
      # is defined (i.e. is instanciated)
      define_filter :before_definition
      define_filter :after_definition   

      define_filter :before_application
      define_filter :after_application 
              
      # Filters to be called before an element is created
      # and after. The after filter is usuallly more useful.
      define_filter :before_create_and_link
      define_filter :after_create_and_link

      
      def self.rule_keyword(value)
        @rule_keyword = value
      end
      
      def self.kind
        "#{self.name.split('::').last.gsub(/((::)|(\w))+::/, '').underscore.gsub(/_rule$/, '')}".intern
      end
      
      def self.keyword
        @rule_keyword || "#{self.kind}_rule" 
      end
    
      def self.non_qualified_name
        self.name.split('::').last
      end
    
      @@extensions = []
      cattr_accessor :extensions

    private
      def self.inherited(subclass)
        @@extensions << subclass
      end    
      
      # attr_accessor :transformation
      # attr_accessor :delegate     
      # attr_accessor :data    
    end
  end
