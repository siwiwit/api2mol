
# == Validation language DSL
#
# This is the DSL definition of the ocl-like constraint language
# for the RubyTL infraestructure. 
# 
# The following is a typical example:
#
#    context People::Vehicle do 
#      inv 'upper-18' { self.owner.age => 18   }
#      inv 'color'    { self.color != 'yellow' }
#    end
#
#    context People::Person do 
#      inv 'any-red'  { People::Car.all_objects.any? { |c| c.color == 'red' } }
#    end
#
# The language behaviour can be different in each implementation, but the 
# easy way (and perhaps the most 'human way') is to check invariants as soon as
# they appear. This is how is implemented here.
#
#
module RubyTL
  module Checker
    module DSL
      def __contexts__    
        @@__contexts__        
      end
       
      def __globals__
        @@__globals__
      end
      
      @@__contexts__ = []
      @@__globals__  = []
      def context(klass)
        @@__contexts__ << Checker::Context.new(klass)
        yield if block_given?
      end
      
      def inv(name = 'invariant-without-name', &block)
        invariant = Checker::Invariant.new(name, @@__contexts__.last, &block)
        @@__contexts__.last.check_invariant(invariant)
      end
     
      def global(name = 'global-without-name', &block)
        @@__globals__ << global = Checker::Global.new(name, &block)
        global.check
      end
 
    end
  
  end
end
