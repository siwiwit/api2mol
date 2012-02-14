module RubyTL
  module VariantSupport

    # This class a represent a feature in a feature model. It includes
    # information about the feature itself, and about the value given
    # by the user. 
    #
	  class Feature
	    attr_reader :name    
      
      # Creates a new feature with a given name.
      def initialize(name)
        @name = name
      end
      
      # Returns true when the feature has been selected by the user.
      def selected?
        @selected
      end        
      
      # Returns true when the features has NOT been selected by the user.
      def unselected?
        ! @selected
      end
      
    #protected
    
      # Sets whether the current features has been selected by the user.
      def selected=(true_or_false)
        @selected = true_or_false
        # I would like to have one-time methods...
      end
        
	  end
    
    
    
  end
end  
