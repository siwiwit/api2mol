
def model_to_code(name, &block)
  RubyTL::ModelToCodeTask.new(name, &block)
end

module RubyTL
  class ModelToCodeTask < RubyTL::Base::BaseTaskLib
    attr_accessor :codebase
    
    def initialize(name, &block)
      @collected_transformations = []
      super(name, &block)
    end
    
    def generate(*to_code_files)
      to_code_files.each do |to_code_file|
        @collected_transformations << as_resource(to_code_file)
      end
    end
    
    def avoid_inference
      @avoid_inference = true
    end
    
  private    
    def define
      define_task(name) do   
        infer_from_dependences unless @avoid_inference
        check_values        

        @collected_transformations.each do |collected_transformation|
          additional = { :dsl_file   => collected_transformation,
                         :codebase   => @codebase }
          launcher   = RubyTL::RGen::Launcher.new(input_values.merge(additional))        
          launcher.evaluate
        end
      end
    end  

    def infer_from_dependences
      infer_source
    end

    # TODO: Generalizar haciendo que cada subclase de BaseTaskLib pueda    
    # establcer sus reglas de inferencia
    def infer_source    
      pretasks = @the_task.prerequisites.map { |x| @the_task.application.lookup(x) }.compact
      tasklibs = pretasks.map { |task| task.defining_tasklib }.compact
      targets = tasklibs.map { |tasklib| tasklib.collected_targets }.flatten.to_a
  
      # Check there isn't naming conflicts
      # TODO: Provide something in the rake task to rename models and avoid conflicts
      names = targets.map { |t| t.namespace }
      raise "Naming conflict" if names.uniq.size != names.size
   
      @collected_sources.push(*targets) unless targets.empty?
   end
    
    def check_values
      # TODO: Raise a Base Exception an show the rakefile name
      raise "At least one source is required" unless collected_sources.size > 0
    end
  end
  
end