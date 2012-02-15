
def walker(name, &block)
  RubyTL::WalkerTask.new(name, &block)
end

module RubyTL
  class WalkerTask < RubyTL::Base::BaseTaskLib
    attr_accessor :name
    attr_reader :plugins
    attr_reader :collected_transformation

    def initialize(name, &block)
      @collected_transformation = nil
      @consistency_mode = :none
      super(name, &block)  
    end

    def transformation(filename)
      filename = filename.values[0] if filename.kind_of?(Hash)
      @collected_transformation = as_resource(filename)
    end
       
    # Sets the filename where the transformation trace should be serialized.
    # By default, the transformation trace is not serialized.
    def trace(filename)
      @collected_trace_filename = as_resource(filename)
    end   
        
    def consistency_mode(mode)
      raise "Invalid consistency mode '#{mode}'" unless RubyTL::Repository::CONSISTENCY_MODES.include?(mode)
      @consistency_mode = mode
    end
    
    def define
      define_task(name) do
        self.evaluate_transformation
      end
    end

    def evaluate_transformation
      check_values
      additional = {
        :dsl_file   => @collected_transformation,
        :trace_filename => @collected_trace_filename,
        :resuming_traces => @collected_resuming_traces
      } 
      launcher   = RubyTL::Walker::Launcher.new(input_values.merge(additional))

      launcher.evaluate
    end
    
    def check_values
      raise "Transformation file required" unless collected_transformation
    end    

  end
   
end