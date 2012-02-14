module RubyTL
  module PureVariants
    
    # This class is a facade to pure::variants files. It uses the XSD / XML
    # parser provided by the RubyTL::XSD module to read pure::variants
    # compliant models, providing an interface to query about variants.
    #
    # Thus, for each feature model the following classes and methods are 
    # available in the model proxy:
    #
    # * <tt>TODO</tt>
    #
    class HandlerPureVariants < RubyTL::Base::ModelHandler     
      # The consul model schema, which is the base for pure::variants models
      @@consul_model_schema = nil
            
      # Returns true when the model corresponds to a pure::variants model.
      # Currently, feature models (are supported), that is, those with +.xfm+ extension . 
      def support?(model_information)
        return false if model_information.multi_metamodel?
        return model_information.metamodel.is_local_resource? &&
               model_information.metamodel.file_extension == 'xfm' 
      end      
      
      # Load the given model and metamodel, where a model is a variant model
      # while a metamodel is a feature model.
      # 
      # It returns a RubyTL::Base::LoadedModel object, which in turn contains
      # the proxy for the model.
      # 
      # == Arguments
      # * <tt>model_information</tt>. An object describing the model/metamodel.
      # 
      def load(model_information) 
        raise "Only one model supported" if model_information.models.size > 1
        
        create_empty_proxy(model_information.metamodel) do |xfm, proxy|          
          model_resource = model_information.models.first
    
          vdm = load_xml_feature_model(model_resource)
          proxy.model_information = model_information
          proxy.fill_with_model(xfm, vdm)
          
          
          RubyTL::Base::LoadedModel.new(model_information, proxy)
        end        
      end      
      
      # New models are not supported for pure::variants      
      def new_model(model_information)
        raise "Not supported"
      end        
      
    private
      def consul_model_schema        
        @@consul_model_schema ||= XSD::XSDParser.new(XML::ParserWrapper.new(File.new(File.join(XSD_MODELS, 'ConsulModel.xsd')))).parse 
      end
      
      def create_empty_proxy(metamodel)
        xml_feature_model = load_xml_feature_model(metamodel)
        proxy = PureVariantsProxy.create_proxy(xml_feature_model)
        yield(xml_feature_model, proxy)
      end
      
      def load_xml_feature_model(model)
        mfile  = File.new(model.file_path)
        parser = XSD::XMLParser.new(XML::ParserWrapper.new(mfile), consul_model_schema)
        return parser.parse        
      end
    end
    
    module PureVariantsProxy
      def self.create_proxy(xml_feature_model)
        mod = Module.new
        mod.extend RubyTL::Base::ModelProxyMixin
        mod.extend FeaturesMixin
        mod.initialize_proxy(xml_feature_model)
        mod
      end
      
      module FeaturesMixin
        ELEMENT = 'elementType'
        
        def initialize_proxy(xml_feature_model)
          @feature_map = {}
          
          xml_feature_model.objects.each do |o|
            add_feature(o, @feature_map) if o.metaclass.name == ELEMENT
          end
        end

        def fill_with_model(xfm, xml_vdm)
          merged = XMLMerger.new(xml_vdm, xfm)
          xml_vdm.objects.each do |o|
            fill_with_element(merged, o) if o.metaclass.name == ELEMENT
          end          
        end
                
      private      
        def add_feature(element, feature_map)
          feature_map[element] = feature = RubyTL::VariantSupport::Feature.new(element.name)
          
          #puts element.get('id')
          #puts element.metaclass.name
          (class << self; self; end).send(:define_method, feature.name) do
            feature
          end
        end
        
        def fill_with_element(merged_trees, element)
          element.relations.each do |r|
            next if r.get('class') != 'ps:references'
            
            raise "Not supported #{element.get('id')}" if r.relation.size > 1
            relation = r.relation.first
            raise "Not supported #{element.get('id')}" if relation.target.size > 1
            target   = relation.target.first
            
            list = target.value.split('/')
            raise "I'm assuming only two elements" if list.size != 2
            tree, node = merged_trees.node_by_id(list[0])
            raise "No node with id = #{list[0]}" unless node
            
            node = tree.node_by_id(list[1])
            raise "No node with id = #{list[1]}" unless node
            
            feature = @feature_map[node]
            type = element.get('type')
            case type
            when 'ps:unselected' then feature.selected = false
            when 'ps:selected'   then feature.selected = true
            else raise "Not considered #{type}"      
            end
          end
        rescue => e
          # TODO: This is temporal
          $stderr << "Warning: #{e.message}" + $/
        end
      end
      
    end        

    class XMLMerger
      def initialize(main, *other_trees)
        @main  = main
        @trees = [main] + other_trees
      end
      
      def node_by_id(id)
        return @main, @main.root if id == '.'
        @trees.each do |tree|
          node = tree.node_by_id(id)
          return tree, node if node
        end
        return nil
      end
    end
    
  end  
end