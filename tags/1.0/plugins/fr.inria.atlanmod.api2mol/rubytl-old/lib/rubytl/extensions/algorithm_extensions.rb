
  module Plugins
  
    # This class is intended to be superseded (i.e. an open class)
    # by plugins implementing algorithms extensions.
    #
    # == Available hooks
    #
    # == Available filters
    # 
    #
    class Algorithm 
      include Plugins::AlgorithmHooks
      class << self; include Plugins::Filtering; end    
      include RubyTL::Plugins::ContextInformation

      
      # Initializes a new algorithm instance that handle a certain
      # +transformation+. Plugins may access such a transformation information
      # using the +transformation+ attribute.
      #
      # * <tt>context</tt>. The context where the transformation will be executed
      #
      def initialize(context)
        load_context_information(context)
      end
          
      # Allows a plugin to take part in the selection of the 
      # rules executed at top level. The block should expect two
      # parameters, an array with the rules already selected and
      # and an array with all available rules.
      #
      # == Example
      #
      #     append_entry_point_selection_filter :basic_rule_selection
      #    
      #     def basic_rule_selection(selected)
      #       raise "No applicable rules found" if transformation_rules.empty?
      #       if selected.empty?
      #         selected << transformation_rules.first
      #       end
      #     end
      #
      # This example shows how to select the first rule in the transformation
      # if no other rules has been selected as top level rules.
      #    
      define_filter :entry_point_selection


      # This extension point is intented to perform global actions before
      # the transformation starts.
      define_filter :transformation_start

      # This filter is intented to select available rules without
      # modifying the on_select_conforming_rules hook.
      #
      # == Example
      #
      #     append_after_select_conforming_rules_filter do |binding, available|
      #        available.delete_if { |rule| rule.name == 'rule666' }
      #     end
      #
      define_filter :before_select_conforming_rules
    end
  end
