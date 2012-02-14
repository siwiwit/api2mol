
module RubyTL
  module Rtl
  
    # This is a version of the transformation algorithm that
    # can be extended by means of hooks and filters.
    #
    class ExtensibleAlgorithm < RubyTL::Rtl::Algorithm
    
      alias_method :alg_apply_entry_point_rules, :apply_entry_point_rules
      alias_method :alg_resolve_binding, :resolve_binding
      alias_method :alg_select_conforming_rules, :select_conforming_rules
      alias_method :alg_evaluate_available_rules, :evaluate_available_rules
    end
  end
end