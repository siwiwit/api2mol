require 'uri'

module RubyTL
  module Base

    # Struct to keep information about models to be loaded.
    # One or more modelos conforming to *one* metamodel
    # can be loaded within 
    #
    class ModelInformation
      attr_reader :namespace
      attr_reader :metamodel
      attr_reader :models
      
      # Creates a new object containing model information.
      #
      # * <tt>namespace</tt>. The root namespace used to handle the model.
      #                       The namespace name is converted to the Ruby constant convention.
      # * <tt>metamodel</tt>. A resource containing a metamodel
      # * <tt>models</tt>. One or more resources containing models.
      def initialize(namespace, metamodel, models)
        @namespace = namespace.to_ruby_constant_name
        @metamodel = metamodel
        @models    = [*models].compact
        raise RubyTL::Base::RepositoryError.new("No models defined") if @models.empty?
      end
      
      def multi_metamodel?
        false
      end
      
      def model_informations
        [self]
      end
      
      def to_s
        self.namespace
      end
    end
    
    # An composite version of ModelInformation that handles several metamodels for
    # the same model (or set of models).
    #
    # When there is only one model information, it acts as a model information object,
    # providing the namespace, metamodel, models methods.
    #
    class MultiModelInformation
      attr_reader :models
      attr_reader :model_informations
      
      def initialize(models)
        @model_informations = []
        @models    = [*models].compact
        raise RubyTL::Base::RepositoryError.new("No models defined") if @models.empty?        
      end

      def multi_metamodel?
        true
      end
            
      def method_missing(name, *args)
        super.method_missing(name, *args) if @model_informations.size != 1
        @model_informations.first.send(name, *args)
      end
            
      def to_s
        "{#{model_informations.map { |m| m.to_s }.join(',')}}"
      end
    end 
        
    class LoadedModel
      attr_reader :model_information
      attr_reader :proxy
      #attr_reader :already_exists
    
      def initialize(model_information, proxy)#, already_exists = false)
        @model_information = model_information
        @proxy             = proxy
        #@already_exists = already_exists 
      end
      
      def put_into_context(context)        
        context.const_set(@model_information.namespace.to_ruby_constant_name, @proxy)
      end
      
      def serializable?
        @model_information.models.any? { |m| m.is_persistible? }
      end
      
      def serialize(serializer_config = nil)
        raise "Invalid number of target models" if @model_information.models.size != 1
        @proxy.serialize(@model_information.models.first, serializer_config)
      end
      
      def serialize_to_resource(resource, serializer_config = nil)
        @proxy.serialize(resource, serializer_config)
      end
      
    end

    # TODO: Factorize with the class above    
    class LoadedMultiModel
      attr_reader :model_information

      def initialize(model_information, builder_result)
        @model_information = model_information
        @builder_result = builder_result
      end

      def serializable?
        @model_information.models.any? { |m| m.is_persistible? }
      end

      def serialize(serializer_config = nil)
        raise "Invalid number of target models" if @model_information.models.size != 1
        @builder_result.serialize(@model_information.models.first, serializer_config)
      end

      def put_into_context(context)
        @builder_result.namespace_proxy_bindings do |namespace, proxy|
          context.const_set(namespace.to_ruby_constant_name, proxy)          
        end                
      end                        
    end
    
    class PlainModel
      attr_reader :handler
      attr_reader :model
      
      #
      # == Arguments
      # * <tt>handler</tt>
      # * <tt>model</tt>. The object representing the model, according to the handler
      def initialize(handler, model)
        @handler = handler
        @model   = model
      end
    end
    
    # A name mapping is a "duck-typed" extension of loaded model, that allow
    # a proxy / subproxy that has been obtained via a LoadedModel to be mapped
    # to a different name using the put_into_context_method.
    class NameMapping
      attr_accessor :name, :proxy
      def initialize(name, proxy)
        @name = name
        @proxy = proxy
      end 
      
      def put_into_context(context)
        context.const_set(@name.to_ruby_constant_name, @proxy)
      end      
    end
    

    # This class is the bridge between different repository implementations
    # and RubyTL. It connect a repository implementation with RubyTL by
    # creating dynamic proxys. This proxys represent requested models.
    #
    # A repository has one or more handlers that are queried to 
    # handle the models.
    #
    # == Example 
    #  
    #
    class Repository
      CONSISTENCY_MODES = [:none, :backup]
      attr_reader :handlers
      attr_accessor :consistency_mode
      
      # Creates a new repository object, installing the +handlers+ to deal with
      # the possible repository implementations.
      # 
      # == Arguments
      #
      # <tt>handlers</tt>. Handlers to be installed in the repository.
      #
      def initialize(handlers, strategy_provider = nil)
        @handlers = handlers
        @consistency_mode = :none
        @strategy_provider = strategy_provider
      end

      # Loads a source model, returning a LoadedModel object.
      # 
      # == Arguments
      # * <tt>model_information</tt>
      # 
      def load_source_model(model_information)
        handler = select_handler(model_information)
        handler_call(handler, 'load', model_information)
        #handler.load(model_information)
      end
      
      # It loads a models but without generating a proxy for it.
      # It just returns a return PlainModel object, that contains
      # the model representation according to the selected handler.
      #
      # == Arguments
      # * <tt>model_information</tt>
      # 
      def load_plain_model(model_information)
        handler = select_handler(model_information)
        handler.plain_load(model_information)
      end
      
      # Loads a target model, creating a new model if necessary. This
      # is controlled by the consistency mode parameter.
      # Returns a LoadedModel object.
      # 
      # == Arguments
      # * <tt>model_information</tt>.
      # * <tt>consistency_mode</tt>.
      #
      def load_target_model(model_information, consistency_mode = @consistency_mode)
        handler = select_handler(model_information)  

        case consistency_mode
        when :none        then 
          handler_call(handler, 'new_model', model_information)
          #handler.new_model(model_information) 
        when :backup      then 
          backup_target_model(model_information)
          handler_call(handler, 'new_model', model_information)
          #handler.new_model(model_information)
        when :incremental then 
          raise "Not implemented yet"
        else
          raise "Consistency mode #{consistency_mode} not supported"
        end
      end

    protected
    
      # Select a handler depending on the kind of model used.
      def select_handler(model_information)
        handler = @handlers.find { |h| h.support?(model_information) }
        raise NoHandlerError.new("I can't find handler for #{model_information.to_s}") unless handler
        handler
      end

      # This is a facility to know whether to call the handler with one or
      # two parameters.
      def handler_call(handler, method_name, model_information)
        if handler.method(method_name).arity == 1
          handler.send(method_name, model_information)
        else
          handler.send(method_name, model_information, @strategy_provider)
        end
      end
        
      def backup_target_model(model_information)
        model_information.models.each do |resource|
          if resource.file_exist?
            resource.copy_to(resource.file_path + '.backup')            
          end
        end
      rescue => e
        $stderr << "Error. I can't backup target file: #{e.message}" + $/
      end

    end        
    
    class RepositoryError < RubyTL::BaseError; end
    class NoHandlerError < RepositoryError; end
  end
end
