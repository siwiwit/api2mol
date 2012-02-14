module RubyTL
  module Checker
  
    class Context
      attr_reader :metaclass
      attr_reader :invariants
      
      # Creates a new context where to check invariants.
      #
      # == Arguments
      #
      # * <tt>metaclass</tt>. The metaclass associated to the context.
      #
      def initialize(metaclass)
        @metaclass = metaclass
        @invariants = []    
      end
      
      # Check an invariant in the context, that is, all instances
      # of the metaclass are tested against the invariant.
      # The invariant is also added to the list of context's invariants.
      #
      # == Arguments
      #
      # * <tt>invariant</tt>. The invariant to be checked.
      #
      def check_invariant(invariant)
        @invariants << invariant
        @metaclass.all_objects.each do |obj|           
          invariant.check!(obj)
        end
      end    
      
      # Check if there is any error in the invariants that has been
      # checked.
      def any_error?
        not self.errors.empty?
      end
      
      # Returns the errors of the context's invariants. 
      #
      def errors
        @invariants.map { |invariant| invariant.errors }.select { |error| not error.empty? }
      end
    end
    
    class Invariant
      attr_reader :name
      attr_reader :errors
      
      # Creates a new invariant. An invariant has code block
      # where the condition is specified.
      #
      # == Arguments
      #
      # * <tt>name</tt>. The invariant name
      # * <tt>context</tt>. The context associated with the invariant.
      # * <tt>block</tt>. A block that should return true or false.
      #
      def initialize(name, context, &block)
        @name = name
        @block = block
        @errors = InvariantError.new(context, self)
      end
      
      # Check the invariant against an object.
      # If the evalution of the block returns something different from true
      #     
      def check!(obj)
        result = obj.instance_eval(&@block)
        if not result
          @errors.objects << obj
        end
      end
    end
    
    class Global
      def initialize(name, &block)
        @name = name
        @block = block
      end
      
      def check
        result = @block.call
        if not result
          @error = "Global constraint #{@name} not satisfied"
        end
      end

      # Check if there is any error in the invariants that has been
      # checked.
      def any_error?
        @error != nil
      end
      
      # Returns the errors raised by checking the global constraint. 
      #
      def errors
        [@error].compact
      end 
    end    

    # An invariant error contains the set of objects that does not fulfill
    # the invariant. 
    # If InvariantError.empty? == true then all objects are valid against this
    # invariant.
    #
    class InvariantError
      attr_reader :objects
      attr_reader :invariant
      
      def initialize(context, invariant)
        @context = context
        @invariant = invariant
        @objects = []
      end
      
      def empty?
        @objects.empty?
      end
      
      def to_s
        "#{@context.metaclass.name.split('::').last} - '#{@invariant.name}'"
      end
    end
  end    
end
