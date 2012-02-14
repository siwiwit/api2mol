
module RubyTL
  module Rtl

    # This module provides extensibility primitives to a class
    # that wants to have the capability of being extended by
    # means of hooks and filters.
    #
    # The class including this module must implement the 
    # +extensible_objects+ method if it contain other depedent
    # objects that needs to be extended.
    module ExtensibleClass
=begin
      attr_reader :extension
    
      # Make an Extension object available in the class including
      # this module. This object will be used to delegate hook and
      # filter calls.
      def extension_set(extension)
        @extension = extension
        extensible_objects.each { |eo| eo.extension_set(extension) }
      end
      
      def extensible_objects; []; end
=end      
    end
  
  end
end