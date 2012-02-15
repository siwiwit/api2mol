
module RubyTL
  module Rtl
    
    # A phase is a container for either rules or phases. This
    # is an "abstract" class, only intended to be inherited.
    #
    class Phase      
      include Preparable
      attr_accessor :name
      
      # Creates a new phase, with a given name.
      # 
      # == Arguments
      # * <tt>name</tt>. The name of the phase.
      # * <tt>
      # 
      def initialize(name, parent = nil)
        @name   = name
        @parent = parent
        @parent.phases << self if @parent
      end      
      
      def top_parent
        return self unless @parent
        return @parent.top_parent
      end
      
      def transformation
        @__transformation__ ||= top_parent
      end
    end
    
    # A primitive phase is a kind of phase that can only
    # contains rules, but no nested phases.
    class PrimitivePhase < Phase
      attr_reader :rules
      attr_reader :rule_mixins
      attr_reader :ignore_rules
      attr_reader :algorithm
      
      def initialize(name, parent = nil)
        super(name, parent)
        @rules = []
        @ignore_rules = []
        @rule_mixins = []
      end
      
      def contained_preparables
        self.rules        
      end
      
      # Starts the execution of this phase as if it were
      # an isolated transformation execution.
      # It creates a new instance of the algorithm class
      # to evaluate the rules within the phase.
      def start
        @algorithm = algorithm_klass.new(self, self.pack_configuration)
        @algorithm.start
      end 
    end
    
    # A composite phase is a kind of phase that can only
    # contains nested phases, but no rules.
    class CompositePhase < Phase
      attr_reader :phases
      attr_accessor :scheduling
      
      def initialize(name, parent = nil)
        super(name, parent)
        @phases  = []
      end      
      
      def contained_preparables
        self.phases
      end
      
      # Starts the execution of the phase by executing its
      # nested phases. If an explicit execution block was set
      # by the user, the execution of the phase is delegated
      # to such a code block.
      def start
        if @scheduling
          @scheduling.schedule_the_phase
        else
          @phases.each { |p| p.start }
        end
      end
    end    	
    
    # The import statement reflects the fact that an existing transformation
    # can be imported within a phase as a nested phase. This class uses
    # a dsl loader to load the imported transformation on the fly. 
    class ImportStatement
      
      def initialize(dsl_loader, transformation_filename, rename_as)
        @dsl_loader = dsl_loader
        @transformation_filename = transformation_filename
        @rename_as = rename_as
        @name_mappings = []
        @hooks_instantiations = {}
      end

      # Adds a name mapping to the import sentence. A name mapping allows
      # the caller transformation to "tell" the callee transformation which
      # metamodels to use.  
      # If no name mapping is provided, the  current transformation source/target
      # metamodels are passed to the callee transformation implicitly.
      def add_name_mapping(name, package)
        @name_mappings << RubyTL::Base::NameMapping.new(name, package)
      end
      
      def add_hook_instantiation(name, type)
        @hooks_instantiations[name] = type        
      end
      
      def do_import(status)
        loader = @dsl_loader.duplicate_for_importation(@transformation_filename, 
                                                       :status => status,
                                                       :name_mappings => @name_mappings,
                                                       :hooks_instantiations => @hooks_instantiations.dup)
        
        # For the moment, the DSL will be read and evaluated (in one step)
        # each time the phase is executed. This is not the ideal solution,
        # but doing it in two times: read_dsl, evaluate_read_dsl...
        # It is better in two phases in case @rename_as is not defined, so that
        # i can read the transformation name...
        return ImportedPhase.new(loader, @rename_as)
      end	
    end
    
    class ImportedPhase
      attr_reader :name
      
      def initialize(loader, name)
        @loader = loader
        @name = name
      end
      
      def start
        @loader.evaluate
      end
    end
    
    class Scheduling
      def initialize(parent, block)
        @phase = parent
        @phase.scheduling = self  
        @block = block
      end
      
      # Executes the associated block to perform the phase's scheduling.
      def schedule_the_phase
        self.instance_eval(&@block)
      end
      
      # Keyword: Execute a phase with a given name
      # The phase can be imported by the enclosing transformation, or just
      # phase belonging to the same phase that enclose the scheduling
      #
      # == Parameters
      # * <tt>name</tt>. The phase name.
      #
      # If no phase is found, and InvalidScheduledPhase is raised. 
      def execute(name)
        p = @phase.top_parent.lookup_imported(name) ||
        @phase.phases.find { |p| p.name == name }
        
        raise InvalidScheduledPhase.new("No phase named '#{name}' is found") unless p  
        
        p.start				
      end
    end
    
    class InvalidScheduledPhase < RubyTL::BaseError; end
  end
end
