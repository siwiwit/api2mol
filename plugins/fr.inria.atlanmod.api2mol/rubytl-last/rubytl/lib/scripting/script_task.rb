
def model_script(name, &block)
  RubyTL::ModelScriptTask.new(name, &block)
end

module RubyTL
  class ModelScriptTask < RubyTL::Base::BaseTaskLib
   
    def initialize(name, &block)
      super(name, &block)  
    end

    def script(filename)
      filename = filename.values[0] if filename.kind_of?(Hash)
      @script = as_resource(filename)
    end
          
    def define
      define_task(name) do
        self.evaluate_task
      end
    end

    def evaluate_task
      raise RubyTL::BaseError.new("Script file not given") unless @script
      additional = {
        :dsl_file   => @script
      } 
      launcher   = RubyTL::Scripting::Launcher.new(input_values.merge(additional))

      launcher.evaluate
   end

  end

end

module RubyTL
  module Scripting
    class Launcher < RubyTL::Base::Launcher
      
      def dsl_setup
        @context = context = RubyTL::Rtl::TransformationContext.new()
        context.parameter_set(@parameters)
        context.load_helper_set(@config.workspace, context)
        #context.generate_dsl
        return context
      end

      def load_dsl_text(context)
        dsl_text = read_dsl_file()
        filename = @dsl_file.file_path
        handle_dsl_exceptions(filename) do
          context.module_eval(dsl_text, filename)
        end
      end

      def execute_dsl(context) 
        context.send(:main) if context.methods.include?('main')
      end
    end

    
  end
end
 
