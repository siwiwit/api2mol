

module RubyTL
  module Rtl

    class Launcher < RubyTL::Base::Launcher
      attr_accessor :status
      attr_accessor :hooks_instantiations
      
      def initialize(options = {})
        super(options)
        @serialize_trace = options[:serialize_trace]
        @status = options[:status]
        @trace_filename = options[:trace_filename]
        @resuming_traces = options[:resuming_traces] || []
        @loaded_resuming_traces = []
      end
    
      # Override the default context setup.
      def dsl_setup
        @context = context = RubyTL::Rtl::TransformationContext.new() 
        # context.plugin_parameters_set(@plugin_parameters || {})
        context.parameter_set(@parameters)
        context.load_helper_set(@config.workspace, context)
        load_plugins(context)
        context.generate_dsl
        return context    
      end
      
      def load_dsl_text(context)      
        dsl_text = read_dsl_file()
        @loaded_target.each do |model|
          # TODO: Remove when there is only one HANDLER (WITH STRATEGIES)
          if model.kind_of?(RubyTL::Base::LoadedModel) && 
             model.proxy.respond_to?(:modify_assignments_for_binding_semantics) 
            model.proxy.modify_assignments_for_binding_semantics do |binding|
              context.transformation_object.resolve_binding(binding)
            end
          end
          #TODO: Do it other way: model.proxy.modify_assignments_for_binding_semantics(&@transformation.binding_semantics)
        end
        @transformation = context.load_transformation(dsl_text, @dsl_file.file_path, self)
      end
      
      def execute_dsl(context)
        @transformation.prepare(:algorithm_klass => RubyTL::Rtl::Algorithm, :status => @status)
        @transformation.instantiate_hooks(@hooks_instantiations) if @hooks_instantiations
        @transformation.status.resuming_traces.push(*@loaded_resuming_traces)
        handle_runtime_dsl_exceptions(evaluated_files(context)) do
          @transformation.start
        end
      end            
      
      def additional_serialization
        if @trace_filename
          model = RMOF::Model.new('http://trace_model', [@transformation.status.trace_model])
          adapter = RMOF::ECore::FileModelAdapter.new(RUBYTL_REPOSITORY)
          serializer = RMOF::ECore::Serializer.new(model, adapter)
          File.open(@trace_filename.file_path, 'w') do |f|
            serializer.serialize(f)
          end
        end        
      end

      def create_strategy_provider
        provider = RubyTL::Base::StrategyProvider.new
        # TODO: Is this the better way to handle the order problem when initializing the binding...
        provider.add(RubyTL::Base::IncludeBindingSemantics.new do |binding| 
          @context.transformation_object.resolve_binding(binding)
        end)
        provider
      end
                  
    protected
      def load_plugins(context)
        #puts "TODO: load plugins"
      end      
      
      def evaluated_files(context)
        [@dsl_file.file_path] + context.loaded_helpers
      end
      
      def load_additional_models(repository)
        return [] if @resuming_traces.empty?
        metamodel = @config.workspace.create_resource(RUBYTL_TRACE_MODEL_NAME)
        information = RubyTL::Base::ModelInformation.new('RtlResumingTrace', metamodel, @resuming_traces)
        handle_repository_exceptions(information) { 
          #plain_model = repository.load_plain_model(information) 
          #@loaded_resuming_traces = plain_model.model.root_elements.first
          model = repository.load_source_model(information)
          @loaded_resuming_traces = model.proxy::TraceModel.all_objects
        }
      end      
    end
  
  end
  

  # This class search for plugins in default paths and can be configured
  # to search in additional paths. When plugins are found, they can be
  # selectively loaded.
  #helper_loading.rb
  # It considers a plugin any directory with a name 'X' that contains a
  # file named 'X.rb'. The file 'X.rb' is assumed to have the code that
  # implements the extension points.
  # An optional file README could exist providing information about the
  # plugin.
  #
  # == Example
  #
  # The following directory structure shows a common organization for a
  # plugins directory:
  #
  #     + myplugins
  #       |
  #       |-- aplugin
  #       |    |-- aplugin.rb
  #       |    |-- test/
  #       |          |-- ... (test files)
  #       |
  #       |-- another_plugin
  #       |    |-- README
  #       |    |-- another_plugin.rb
  #       |    |-- test/
  #       |          |-- ... (test files)
  #       
  #      
  class PluginLoader
    Plugin = Struct.new(:filename, :name, :code, :readme, :ui_file)
  
    # Create a new plugin searcher. By default is search only in the installation
    # directory of RubyTL.
    #
    # == Args
    #
    # * <tt>custom_paths</tt>. Optional argument. A list of paths where to search for plugins.
    # * <tt>use_default_path</tt>. Optional argument. Set it to false not to include default plugins.
    #
    def initialize(custom_paths = [], use_default_path = true)
      default_path = File.join(RUBYTL_ROOT, '..', 'plugins')
      @paths = custom_paths + (use_default_path ? [default_path] : [])      
      @availables = {}
    end

    # Search for available plugins
    def search_for_plugins
      @availables = {}
      @paths.each do |path|
        Dir.glob(File.join(path, '*')).select { |x| File.directory?(x) }.each do |dir|
          add_plugin(dir)
        end      
      end    
    end

    # Load plugins based on a list of allowed plugins.
    def load_plugins(context, selected_plugins = [:default])
      really_available_plugins(selected_plugins, true) do |plugin|
        context.load_plugin(context, plugin.code, plugin.filename)
      end     
    end    
    
    # Loads the user interface of the selected plugins.
    #
    # * <tt>context</tt>. An object that will be modified according to the plugin ui definition.
    # * <tt>selected_plugins</tt.>. The list of plugins (as symbols or strings)
    #
    def load_plugins_ui(context, selected_plugins)
      really_available_plugins(selected_plugins) do |plugin|
        if plugin.ui_file 
          RubyTL::PluginUserInterfaceDSL.evaluate_and_interpret(plugin.ui_file, context)
        end
        #context.load_plugin(context, value.code, value.filename)
      end     
      
#      return unless plugin.ui_file
#      puts read_file(plugin.ui_file)
    end
      
  private
    def really_available_plugins(selected_plugins, check_existence = false)
      self.search_for_plugins if @availables.size == 0
      selected_plugins = selected_plugins.map(&:to_s)
      availables = @availables.delete_if { |key, _| not selected_plugins.include?(key) }    
      check_existence(availables, selected_plugins) if check_existence
      selected_plugins = selected_plugins.map { |p| availables[p] }
      selected_plugins.each do |plugin|
        yield(plugin)
      end
      selected_plugins
    end
    
    def check_existence(availables, selected_plugins)
      not_existing = []
      selected_plugins.each do |name|
        not_existing << name unless availables.key?(name)
      end
      raise RubyTL::PluginNotExist.new("Plugins '#{not_existing.join(', ')}' does not exist") unless not_existing.empty?
      true
    end
  
    # Add a plugin placed in +dir+ to the list of available plugins.
    def add_plugin(dir)    
      plugin_name = File.basename(dir)
      plugin_file = File.join(dir, "#{plugin_name}.rb")
      readme_file = File.join(dir, "README")
      ui_file     = File.join(dir, 'ui.rb')

      if File.exist?(plugin_file)
        File.open(plugin_file) do |f|
          @availables[plugin_name] = Plugin.new(plugin_file, plugin_name, f.read)
        end
        if File.exist? readme_file
          File.open(readme_file) { |f| @availables[plugin_name].readme = f.read }          
        end        
        @availables[plugin_name].ui_file = ui_file if File.exist?(ui_file)
      end    
    end
  end
  
  module PluginHandling
    
    # Load plugin libraries within the context of the
    # transformation. 
    def load_plugin_library(*filenames)
      filenames.each do |filename|
        open_and_eval(File.join(RUBYTL_ROOT, 'rubytl', 'extensions', filename) + '.rb')
      end
    end    
    
    def load_plugin(context, code, filename)    
      self.const_get('Plugins').module_eval(code, filename)
      self.const_get('Plugins').const_get('Rule').extensions.each do |new_rule|
        create_rule_syntax(new_rule, context)
      end
      self.const_get('Plugins').const_get('SyntaxExtension').extensions.each do |extension|
        create_syntax(extension, context)
      end
    end      

  private
    def open_and_eval(filename)
      File.open(filename) do |f|
        self.module_eval(f.read, filename)
      end    
    end        
    
    def read_file(filename)
      return File.open(filename) do |f|
        f.read  
      end
    end
    
    def create_rule_syntax(rule_klass, context)
      classname = rule_klass.non_qualified_name
      #new_method = %{
      #    def self.#{rule_klass.keyword}(name, &block)         
      #      add_rule(Plugins::#{classname}, name, &block)
      #    end
      #}
      #context.module_eval(new_method, __FILE__, __LINE__ - 3)
      context.add_syntax do
         keyword rule_klass.keyword, :extends => 'base_rule' do
            action do |name, block|               
              rule = @transformation.create_rule(rule_klass, name, block)
              rule.from_metaclasses = self_data.from.value
              rule.to_metaclasses = self_data.to.value
              rule.filter = self_data.filter.value
              rule.mapping = RubyTL::Mapping.new(self_data.mapping.value) if self_data.mapping.value
              rule
            end
         end
         # TODO: Implement somekind of helpers in the low_level_dsl...
      end
    end  

    # Given the specification of a syntax extension, +extension+, the new syntax
    # is added to the context
    def create_syntax(extension, context)
      extension.keywords.each do |keyword|
        context.syntax.add_keyword(keyword)
      end    
    end
  end
end
