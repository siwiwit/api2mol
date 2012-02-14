
def execute_edsl(name, &block)
  RubyTL::ExecuteDSLTask.new(name, &block)
end


def edsl_family(name, &block)
  RubyTL::DSLFamilyTask.new(name, &block)
end

module RubyTL
  class ExecuteDSLTask < RubyTL::Base::BaseTaskLib
    attr_accessor :name
    attr_reader :collected_targets
    attr_reader :collected_dsl_definition_filename
    attr_reader :collected_language
    attr_reader :collected_dsl_filename
    
    def initialize(name, &block)
      @collected_targets = []
      @collected_dsl_definition_filename = nil
      @collected_language = :low_level
      @collected_dsl_filename = nil
      super(name, &block)  
    end

    # Specification of the dsl file that contains the definition of the
    # DSL to be executed. 
    #
    # == Example
    #
    #    task.dsl_definition 'file:///tmp/my_dsl_def.rb'
    #
    def dsl_definition(value, options = {})
      @collected_dsl_definition_filename = as_resource(value)
      @collected_language = options[:language] || :lowlevel_level
    end
    
    def dsl_filename(value)
      @collected_dsl_filename = as_resource(value)    
    end
                     
    def define
      define_task(name) do
        self.evaluate_dsl
      end
    end

    def evaluate_dsl
      additional = { :dsl_file   => @collected_dsl_definition_filename,
                     :executed_file   => @collected_dsl_filename }
      launcher = if @collected_language == :low_level
        RubyTL::LowLevelDSL::Launcher.new(input_values.merge(additional))
      else
        raise "Not implemented"
      end
      
      launcher.evaluate
    end
  end



  class DSLFamilyTask < RubyTL::Base::BaseTaskLib
    attr_accessor :name
    attr_reader :collected_targets
    attr_reader :collected_dsl_programs
    
    def initialize(name, &block)
      @collected_targets = []
      @collected_dsl_programs = []
      @collected_language = :low_level
      super(name, &block)  
    end

    def dsl_program(programs = {})
      programs.each do |prog, definition|
        @collected_dsl_programs << [as_resource(prog), as_resource(definition)]
      end
    end

    def define
      define_task(name) do
        self.evaluate_dsl
      end
    end

    def evaluate_dsl
      additional = { :dsl_programs   => @collected_dsl_programs }
      launcher = if @collected_language == :low_level
        RubyTL::LowLevelDSL::FamilyLauncher.new(input_values.merge(additional))
      else
        raise "Not implemented"
      end
      
      launcher.evaluate
    end

  end

end
