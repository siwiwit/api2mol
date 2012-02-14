
module RubyTL
  module XSD

    # This class is a facade to the XSD parser. It is able to read
    # XML Schema files (XSD) and XML files according to the corresponding 
    # XSD. 
    # 
    # It is in charge of adapting the XML Schema to make it act as a metamodel
    # so that and XML file can act as a model. To do so, a model proxy is
    # created.
    #
    class HandlerXSD < RubyTL::Base::ModelHandler 
    
      # Creates a new handler.
      # 
      # == Arguments
      # * <tt>config</tt>. A RubyTL::Base::Configuration objet.
      #
      def initialize(config)
        super(config)
      end
      
      # Returns true when the model can be handled by the XSD/XML parser.
      # Local resources with 'xsd' file extension are supported.
      # 
      def support?(model_information)
        return false if model_information.multi_metamodel?
        return model_information.metamodel.is_local_resource? &&
               model_information.metamodel.file_extension == 'xsd' 
      end

      # Load the given model and metamodel.
      # It returns a RubyTL::Base::LoadedModel object, which in turn contains
      # the proxy for the mode.
      # 
      # == Arguments
      # * <tt>model_information</tt>. An object describing the model/metamodel.
      # 
      def load(model_information) 
        raise "Only one model supported" if model_information.models.size > 1
        
        create_empty_proxy(model_information.metamodel) do |schema, proxy|          
          model_resource = model_information.models.first
    
          model = load_model(schema, model_resource)      
          fill_proxy(proxy, model)
          #proxy.model_set(model)
        
          #proxy.model_file = model_information.models.first.file_path
          proxy.model_information = model_information
  
          RubyTL::Base::LoadedModel.new(model_information, proxy)
        end        
      end
    
      # Creates a new model conforming a metamodel.
      # It returns a proxy.    
      def new_model(model_information)
        raise "Only one model supported" unless model_information.models.size == 1
        
        create_empty_proxy(model_information.metamodel) do |schema, proxy|
          proxy.model_information = model_information
          RubyTL::Base::LoadedModel.new(model_information, proxy)
        end        
      end        

    
    private
  
      def load_schema(schema_resource)
        file   = File.new(schema_resource.file_path)
        parser = XSD::XSDParser.new(XML::ParserWrapper.new(file))
        schema = parser.parse  
      end

      def create_empty_proxy(schema_resource)
        schema = load_schema(schema_resource)
        proxy  = SchemaProxy.create_model_proxy(schema)
        yield(schema, proxy)
      end
  
      def load_model(schema, model_resource)
        file   = File.new(model_resource.file_path)
        parser = XSD::XMLParser.new(XML::ParserWrapper.new(file), schema)      
        parser.parse
      end
  
      # Add the objects of a model to a proxy which represents the model.
      # 
      # * <tt>proxy</tt>
      # * <tt>model</tt>
      #
      def fill_proxy(proxy, model)
      	#proxy.add_object(model.root, :alter_object => true)
        model.objects.each { |object| proxy.add_object(object, :alter_object => true)  }
      end	  
    end
  
    module SchemaProxy
    
      # Creates a new proxy for the given schema.
      # 
      # == Arguments
      # * <tt>schema</tt>. The schema to be wrapped by this proxy.
      #
      def self.create_model_proxy(schema)
        mod = Module.new
        mod.extend RubyTL::Base::ModelProxyMixin
        mod.extend SchemaProxy::ClassMethods
        #mod.pextend SchemaProxy::ClassMethods, :schema => schema
        mod.schema = schema
        mod
      end
      
      # Utility methods mixin. It is intended to "extend" a 
      # SchemaProxy.
      module ClassMethods
        #parameter   :schema
        #initializer :do_initialize


        def schema=(schema)
          @schema = schema
          @proxy_types = {}
          @objects_by_klass = {}
          @objects = []
          
          all_types do |type|
            @proxy_types[type] = proxy = create_type_proxy(type)
            @objects_by_klass[type.name] = Set.new
              
            self.const_set(type.name.to_ruby_constant_name, proxy)
          end
        end

        #one_use_method :schema=   

        def add_object(object, options = {})
          add_object_by_child_metaclass(object, object.metaclass)
  
          if options[:alter_object]
            return unless @proxy_types.key?(object.metaclass)
            @proxy_types[object.metaclass].send(:alter_object, object)
          end
        end

        # Returns an array containing all objects of a specified class.
        def all_objects_of(klass)
          @objects_by_klass[klass.name].to_a || []
        end
                                  
      private        
        def all_types
          @schema.typeDefinitions.each { |t| yield(t) }
        end   

        def create_type_proxy(xsd_type)
          klass = Class.new
          klass.extend XSDTypeProxy::ClassMethods
          klass.initialize_proxy(self, xsd_type)
          klass
        end

      private  
        # Add an object to the list of objects of a child metaclass, that is,
        # a metaclass which is within a package.
        def add_object_by_child_metaclass(object, metaclass)
          @objects << object
          ([metaclass] + metaclass.all_super_types).each do |klass|
            raise "No metaclass '#{klass.name}' exist in the package" unless @objects_by_klass[klass.name]
            @objects_by_klass[klass.name] << object
          end 
        end

      end
      
    end

    module XSDTypeProxy
      module ClassMethods
        include RubyTL::RumiXSD::ClassInterface
        
        attr_reader :real_klass
        
        def initialize_proxy(schema, real_klass)
          @schema = schema
          @real_klass = real_klass
          @decorators = []
        end

        def new(initial_values = {})
          object = XMLTreeNode.new(nil, @real_klass)
          alter_object(object)
          raise "Autoset features not supported yet for XML objects" if initial_values.size > 0
          @schema.add_object(object)
          yield(object) if block_given?
          object
        end
                        
        def all_objects(&block)
          result = @schema.all_objects_of(@real_klass) 
          result.each(&block) if block_given?
          result
        end
        
        def name
          @real_klass.name
        end
      
      private
      
        def alter_object(object)
          is_module = object.kind_of?(Module)
          object.extend(RubyTL::RumiXSD::XMLNodeInterface)
          object.virtual_klass = self
          object.extend(XSDTypeProxy::InstanceMethods)
            
          object.instance_eval do
            class << self
              alias_method :old_set, :set
              
              def set(property, value) 
                if value.kind_of?(Array)
                  value.each { |v| set(property, v, resolve_inverse) }
                  return
                end
                return if value.nil?
                old_set(property, value)
              end
            end        
          end unless is_module # When loading an ECORE metamodel, the ECore::EBoolean is not a class...
    
                    
          object.instance_eval(@bindings_text, __FILE__, __LINE__) if @bindings_text
          object.__binding_semantics__ = @binding_semantics
    
          #object.extend @package_module.extension_modules[@real_klass]
        end
      end
    
      module InstanceMethods
        attr_writer :__binding_semantics__
      end
    end
  end
end


