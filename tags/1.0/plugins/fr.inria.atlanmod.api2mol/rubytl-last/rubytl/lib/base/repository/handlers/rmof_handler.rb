
module RubyTL
  class ModelIdGenerator
    def initialize; @id = 0; end
    def next; @id += 1; end 
  end
	
  class SimpleRMOFHandler < RubyTL::Base::ModelHandler 
    include RubyTL::Base::RubyModelLoading

    IdGenerator = ModelIdGenerator.new
	
      def initialize(config)
        super(config)
        @adapter = RMOF::ECore::FileModelAdapter.new(RUBYTL_REPOSITORY)
        # Traverse config.mappings and 
        #   @adapter.add_mapping
      end

      #def basic_strategy_provider(other_provider = nil)
      def basic_strategy_provider(other_provider, model_id = nil)
        provider = RubyTL::Base::StrategyProvider.new
        provider.add RubyTL::Base::AdaptToRUMI.new
        provider.add RubyTL::Base::ModifySetMethod.new
        provider.add RubyTL::Base::SetModelId.new(model_id) if model_id        
        return provider.merge(other_provider) if other_provider
        return provider
      end      
      
      # Checks whether a certain model / metamodel is suitable to be
      # loaded by this handler.
      # 
      # == Arguments
      #
      # * <tt>model_information</tt>. A ModelInformation object containing information
      #                               about the model and the metamodel.
      #      
      def support?(model_information)
        condition = lambda { |mi|           
	        if mi.metamodel.is_uri?
	          @adapter.can_handle?(mi.metamodel.uri_string)
	        elsif mi.metamodel.is_local_resource?
	          mi.metamodel.file_extension == 'ecore' 
	        end
        }
        return condition.call(model_information) unless model_information.multi_metamodel?
        return model_information.model_informations.all?(&condition)
      end
  
      # It loads a model but do not generate a proxy for it.
      # Returns a PlainModel object. 
      def plain_load(model_information)
      raise "TODO"
        load_metamodel(model_information.metamodel, @adapter)
        raise "Only one model supported" if model_information.models.size > 1
  
        model_resource = model_information.models.first
        raise "Plain loading not supported for rb models" if model_resource.file_extension == 'rb'
  
        RubyTL::Base::PlainModel.new(self, load_model(model_resource, @adapter))      
      end
  
      # It loads a model, creating a proxy for it. 
      # Returns a LoadedModel object.
      # 
      def load(model_information, strategy_provider)
        is_rb_model        = model_information.models.all? { |m| m.file_extension == 'rb' } 
        is_there_xmi_model = model_information.models.any? { |m| m.file_extension != 'rb' }
        raise "Mixing .rb models and .xmi models is not allowed" if is_rb_model && is_there_xmi_model 
        
        metamodels = load_metamodels(model_information, @adapter)
        model_id = IdGenerator.next
        result = if not is_rb_model
          models  = model_information.models.map { |mres| load_model(mres, @adapter) }        
          builder = RubyTL::Base::RmofProxyBuilder.new(metamodels, models, basic_strategy_provider(strategy_provider, model_id))  
          builder.filled_proxy       
        else
          raise "Only one model supported" if model_information.models.size > 1
          model_resource = model_information.models.first
          
          empty_model = RMOF::Model.new(model_resource.file_path, [])  
          builder  = RubyTL::Base::RmofProxyBuilder.new(metamodels, empty_model, basic_strategy_provider(strategy_provider, model_id))#basic_strategy_provider)# basic_strategy_provider(strategy_provider))          
          result   = builder.empty_proxy
          raise "Only mono-metamodel model supported" if result.proxys.size > 1
          proxy = result.proxys.first
          load_ruby_source_model(model_resource.file_path, proxy, model_information.namespace)
          result                
        end
        
        #proxy.model_file = model_information.models.first.file_path
        #proxy.model_information = model_information
        result.rmof_adapter = @adapter
        RubyTL::Base::LoadedMultiModel.new(model_information, result)
      end
      
      # Creates a new model conforming a metamodel.
      # It returns a proxy.    
      def new_model(model_information, strategy_provider)
        raise "Only one model supported" unless model_information.models.size == 1
        
        metamodels = load_metamodels(model_information, @adapter)
        model_id = IdGenerator.next
        builder   = RubyTL::Base::RmofProxyBuilder.new(metamodels, nil, basic_strategy_provider(strategy_provider, model_id))       
        result    = builder.empty_proxy
        #proxy = PackageProxy2.create_model_proxy(model, RubyTL::HandlerRMOF2::IdGenerator.next)      
        
        # TODO: What about in memory files?
        #proxy.model_information = model_information#.models.first
        result.rmof_adapter = @adapter
        RubyTL::Base::LoadedMultiModel.new(model_information, result)
      end        
  
      # It adds a mapping to the adapter used to load models / metamodels.
      #
      # == Arguments
      # * <tt>mapping</tt>.
      def add_mapping(mapping)
        if mapping.is_uri_to_uri?
          @adapter.add_uri_mapping(mapping.uri, mapping.resource_name)
        else      
          @adapter.add_mapping(mapping.uri, mapping.resource_name, mapping.fragment)
        end        
      end
  
      
    private
  
      def load_metamodels(model_information, adapter)
        model_information.model_informations.map do |mi|
          metamodel = load_metamodel_resource(mi.metamodel, adapter)          
          RubyTL::Base::NamespaceMetamodelBinding.new(mi.namespace, metamodel)
        end
      end
    
      def load_metamodel_resource(metamodel_resource, adapter = nil)
        adapter = @adapter if adapter.nil?
        if metamodel_resource.is_uri?
          return @adapter.resolve_uri(metamodel_resource.uri_string)
        elsif metamodel_resource.is_local_resource?
          # Hack...
          if loaded = adapter.instance_variable_get('@loaded')
            model = loaded[metamodel_resource.file_path]
          end       
          if not model
            model   = RMOF::ECoreParser.new(File.new(metamodel_resource.file_path), adapter).parse()     
            raise "There should be at least one root element" if model.root_elements.size < 1
            # raise "There should be only one root element" if model.root_elements.size > 1
            adapter.add_loaded(metamodel_resource.file_path, model)
          end
        end        
        model
      end
  
      def load_model(model_resource, adapter)
        @config.parsing.rmof_model_parse(model_resource.file_path, adapter)

        #xml_reader = RMOF::XMLReaderAdapter.load(file)    
        #parser = RMOF::FormatGuesser.guess(xml_reader, RMOF::ECoreParser)
        #parser.new(xml_reader, adapter, :file_path => file.path).parse()
     end
  
      # Add the objects of a model to a proxy which represents the model.
      # 
      # * <tt>proxy</tt>
      # * <tt>model</tt>
      #
      def fill_proxy(proxy, model)
        model.objects.each { |object| 
          # TODO: Change ePackage and look up by ePackage to avoid naming conflicts
          pkgproxy = proxy.find_package(object.metaclass.ePackage) 
          if pkgproxy
            pkgproxy.add_object(object, :alter_object => true) 
          end
          # TODO: If pkgproxy == nil this means an object whose metaclass has been imported (cross-referenced)
        }
      end
  end
end
