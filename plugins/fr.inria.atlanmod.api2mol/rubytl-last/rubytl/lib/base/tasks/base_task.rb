require 'rake/tasklib'

module Rake
  class Task
    attr_accessor :defining_tasklib
  end
end

# Access to the DSL to define model_mappings
# TODO: Link to @config
def model_mappings_definition(&block)
  model_mappings = RubyTL::Base::ModelMappingsDSL.new(RubyTL::Base::BaseTaskLib.config)
  model_mappings.evaluate(&block)
end

def load_path_add(dir)
  RubyTL::Base::BaseTaskLib.config.workspace.load_path << dir
end

def serializer(kind)
  RubyTL::Base::BaseTaskLib.config.serializer_options.serializer_class =
      if kind == :text_stream
         RMOF::ECore::StreamSerializer
      elsif kind == :rexml
         RMOF::ECore::Serializer
      else
        raise "not supported #{kind}"
      end
end

# Sets the model handler
def select_rmof_handler(h)
  RubyTL::Base::Configuration.handler_klasses.delete(RubyTL::HandlerRMOF2)
  RubyTL::Base::Configuration.handler_klasses.delete(RubyTL::SimpleRMOFHandler)
  if ( h.to_s == 'new_handler' )
    RubyTL::Base::Configuration.handler_klasses << RubyTL::SimpleRMOFHandler
  else
    RubyTL::Base::Configuration.handler_klasses << RubyTL::HandlerRMOF2          
  end
end


module RubyTL
  module Base
    module ConfigurationOptions
      def rmof_parse_model_with_sax
        @config.parsing.model_parser_impl = RubyTL::Base::ParserConfig::SAX_VERSION
      end
    end

    class BaseTaskLib < ::Rake::TaskLib    
      include ConfigurationOptions
     
      cattr_accessor :config
      attr_reader :name
      attr_reader :collected_sources
      attr_reader :collected_targets
      attr_reader :collected_parameters
      
      def initialize(name, &block)
        @config = @@config.dup
 
        @name = name
        @collected_sources = []
        @collected_targets = []
        @collected_parameters = {}    
        yield(self) if block_given?
        # self.instance_eval(&block) if block_given?
        define             
      end         
 

      # Add parameters to the dsl. This parameters can be accessed, by name, globally within
      # the dsl module.
      #
      # == Example
      #            
      #    task.parameters 'param-name' => 'param-value',
      #                    'another-key' => 1324134
      #     
      def parameters(hash)
        @collected_parameters.merge!(hash)
      end
          
      # Sets the debug model (for developers). If true, detailed stack traces
      # will be printed when there are errors.
      def debug_mode(active = true)
        RubyTL::BaseError.debugging_mode = active
      end
  
      # Add sources to the transformation in the form of hash. A source has
      # the following form:
      #
      #   t.sources :package   => 'module_name',
      #             :metamodel => '/path/to/metamodel',
      #             :model     => '/path/to/model'  
      #
      # where:
      # * <tt>package</tt>. 
      # * <tt>metamodel</tt>
      # * <tt>model</tt>
      #
      # == Examples
      #  
      #   t.sources :package   => 'ClassM',
      #             :metamodel => 'metamodels/ClassM.ecore',
      #             :model     => 'models/class-source-simple.xmi' 
      # 
      def source(source_hash)   
        collect_models(source_hash, @collected_sources)
      end
  
      # Add target models to the transformation.
      # See #source.
      def target(target_hash)
        collect_models(target_hash, @collected_targets)
      end
  
      alias_method :sources, :source    
      alias_method :targets, :target
  
    protected  
    
      def input_values
        { :source_models => @collected_sources,
          :target_models => @collected_targets,
          :parameters => @collected_parameters,        
          :config        => @config }
      end
    
      def define_task(name, &block)
        @the_task = Rake::Task.define_task(name) do |t|
          block.call(t)
        end
        @the_task.defining_tasklib = self    
        @the_task
      end
      
      def collect_models(hash, model_array)
        actual_collect_models(hash, model_array)
      end
  
      def model_mappings_get
        RubyTL::BaseTaskLib.model_mappings    
      end
  
    private
      def old_collect_models(hash, model_array)
        hash.each_pair do |key, value|   
          value = [*value]
          model_array << ModelInformation.new(key, as_resource(value[1]), as_resource(value[0]))
        end    
      end
      
      def actual_collect_models(hash, model_array)
        options    = hash.stringify_keys
        package    = options['package'] || options['namespace']
        namespaces = options['namespaces']  
        model      = options['model']
        metamodel  = options['metamodel']
        raise ModelDefinitionError.new("Not allowed namespaces & namespace/package") if package && namespaces        
        
        model_resources = [*model].map { |m| as_resource(m) }
        if namespaces
          multi_model = MultiModelInformation.new(model_resources)
          namespaces.each do |key, value|
            multi_model.model_informations << ModelInformation.new(key.to_s, as_resource(value), model_resources)
          end
          model_array << multi_model
        else
          raise ModelDefinitionError.new("No namespace name given") unless package
          raise ModelDefinitionError.new("No model given") unless model
          raise ModelDefinitionError.new("No metamodel given") unless metamodel        
          model_array << ModelInformation.new(package, as_resource(metamodel), model_resources)
        end
      end
      
      def as_resource(str)
        @@config.workspace.create_resource(str)
      end
    end
    
    class ModelDefinitionError < RubyTL::BaseError; end
  end
end

# Little DSL to set the rake model mappings
module RubyTL
  module Base
    class ModelMappingsDSL  
      def initialize(config)
        @config = config
      end
  
      def evaluate(&block)
        self.instance_eval(&block)
      end
  
      # TODO: Use uri_resolver... (homegenize)
      # URI.parse(@resolver.resolve_as_local(@serialize_trace)).file_path 
      def map(mappings)
        mappings.each_pair do |uri_key, filename_value| 
          split_filename(filename_value) do |filename, fragment|
            @config.add_uri_mapping RubyTL::Base::UriModelMapping.new(uri_key, filename, fragment)
          end          
        end
      end
      
    private
      def split_filename(filename_value)
        filename, fragment = filename_value.split('#')
        yield(filename, fragment)
      end
    end
  end
end
