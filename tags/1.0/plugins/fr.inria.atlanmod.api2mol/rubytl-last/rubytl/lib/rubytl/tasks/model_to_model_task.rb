
def model_to_model(name, &block)
  RubyTL::TransformationTask.new(name, &block)
end

def ruby2xmi(name, &block)
  RubyTL::Ruby2XmiTask.new(name, &block)
end

module RubyTL
  class TransformationTask < RubyTL::Base::BaseTaskLib
    attr_accessor :name
    attr_reader :plugins
    #attr_reader :collected_targets
    #attr_reader :collected_sources
    attr_reader :collected_transformation

    def initialize(name, &block)
      #@collected_sources = []
      #@collected_targets = []      
      @collected_transformation = nil
      @plugins = [:default, :set_type, :explicit_calls]
      @plugin_parameters = {}
      @consistency_mode = :none
      @collected_resuming_traces = []
      super(name, &block)  
    end

    def benchmark(*option_list)
      @benchmark ||= []
      [*option_list].each { |o| @benchmark << "#{o}".intern }
    end

    # Specification of the transformation file to be executed. Only the
    # filename of the transformation is expected.
    #
    # == Example
    #
    #    task.transformation 'file:///tmp/class2table.rb'
    #
    def transformation(filename)
      filename = filename.values[0] if filename.kind_of?(Hash)
      @collected_transformation = as_resource(filename)
    end
       
    # Sets the filename where the transformation trace should be serialized.
    # By default, the transformation trace is not serialized.
    def trace(filename)
      @collected_trace_filename = as_resource(filename)
    end   
    
    # Sets the list of traces than are going to be used to resume
    # a transformation.
    def resuming_traces(*traces)
      traces.each { |filename| @collected_resuming_traces << as_resource(filename) }
    end
       
    # Set the list of plugins to be used. 
    def plugins(*plugin_list)
      @plugins = plugin_list    
      # TODO: Be careful because i'm asumming that "default plugins" doesn't have parameters.
      loader = PluginLoader.new
      loader.load_plugins_ui(self, @plugins)
    end
        
    def consistency_mode(mode)
      raise "Invalid consistency mode '#{mode}'" unless RubyTL::Repository::CONSISTENCY_MODES.include?(mode)
      @consistency_mode = mode
    end
    
    def set_plugin_parameter(parameter_name, value)   
      @plugin_parameters[parameter_name] = value
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
        :resuming_traces => @collected_resuming_traces,
        :benchmark => (@benchmark || [])
      } 
      launcher   = RubyTL::Rtl::Launcher.new(input_values.merge(additional))

#require 'ruby-prof'
#result = RubyProf.profile do
     launcher.evaluate
#end
# Print a graph profile to text
#printer = RubyProf::GraphPrinter.new(result)
#printer.print(STDOUT, 0)

 
    end
    
    def check_values
      raise "Transformation file required" unless collected_transformation
    end    

  end
  
# TODO: This doesn't work anymore...  
  class Ruby2XmiTask < RubyTL::Base::BaseTaskLib
    include RubyTL::Base::ExceptionHandling
    attr_accessor :name

    def initialize(name, &block)
      @model = nil    
      select_rmof_handler('old_handler')       
      super(name, &block)  
    end

    def model(model_file)   
      @model = as_resource(model_file)
    end
       
    def define
      define_task(name) do
        self.evaluate_transformation
      end
    end

    def evaluate_transformation
      # #! MyPackage => metamodel/MyMetamodelo.ecore
      package, metamodel = nil, nil
      File.open(@model.file_path) do |f|
        content = f.read
        content =~ /^#!\s+(\w+)\s*=>\s*([A-Za-z0-9_\/.]+)\s*$/
        package, metamodel = $1, $2
      end
      if package.nil? || metamodel.nil?
        puts "Error."
        puts "Invalid ruby model. It should start with: \#! PakackageName => metamodels/metamodel.ecore"
        return
      end 
      
      collect_models({ :package => package, :metamodel => metamodel, :model => @model.file_path }, sources = [])
      absolute = @model.file_path.sub(/\.rb$/, '') + '.ecore.xmi'

      repository = RubyTL::Base::Repository.new(@@config.available_handlers)
      source = nil
      handle_runtime_dsl_exceptions(@model.file_path) do
        source = repository.load_source_model(sources.first)
      end
      source.serialize_to_resource(as_resource(absolute))
      
=begin
        loaded_targets = @targets.map { |model| repository.load_target_model(model) }
        repository = RubyTL::Base::Repository.new(DualHandler.new(model_mappings_get), @@uri_resolver)
        model = sources.first
        model.bind_as_source(repository, Module.new) 
        model.binding.wrapper.serialize(absolute)
=end
      #end

      puts "Finished. "
      puts "Created XMI file: #{absolute}"
    end

  end  
end
