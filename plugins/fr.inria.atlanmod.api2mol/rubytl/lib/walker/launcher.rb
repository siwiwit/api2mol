
module RubyTL
  module Walker

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
        @context = context = RubyTL::Walker::TransformationContext.new() 
        # context.plugin_parameters_set(@plugin_parameters || {})
        context.parameter_set(@parameters)
        context.load_helper_set(@config.workspace, context)
        context.generate_dsl
        return context    
      end
      
      def load_dsl_text(context)      
        dsl_text = read_dsl_file()
#        @loaded_target.each do |model|
#          # TODO: Remove when there is only one HANDLER (WITH STRATEGIES)
#          if model.kind_of?(RubyTL::Base::LoadedModel) && 
#             model.proxy.respond_to?(:modify_assignments_for_binding_semantics) 
#            model.proxy.modify_assignments_for_binding_semantics do |binding|
#              context.transformation_object.resolve_binding(binding)
#            end
#          end
#          #TODO: Do it other way: model.proxy.modify_assignments_for_binding_semantics(&@transformation.binding_semantics)
#        end
        @transformation = context.load_transformation(dsl_text, @dsl_file.file_path, self)
      end
      
      def execute_dsl(context)
        @transformation.prepare
        handle_runtime_dsl_exceptions(evaluated_files(context)) do
          @transformation.start
        end
      end            

      def evaluated_files(context)
        [@dsl_file.file_path] + context.loaded_helpers
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
    end 
  end
end
