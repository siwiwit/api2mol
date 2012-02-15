
module RubyTL
  module Base
    NamespaceMetamodelBinding = Struct.new(:namespace, :metamodel)    
    NamespaceProxyBinding     = Struct.new(:namespace, :proxy)
    
    # This class creates a proxy to access a certain model through the
    # names provided by its metamodel. It can be parametrized to handle
    # 
    # The proxy will be a module providing a Ruby class for each metamodel's
    # classifiers. The proxy provides the following reflective query methods:
    #
    # * <tt>classifiers</tt>. Return all metamodel classifiers within the main package.
    # * <tt>packages</tt>. Return all subpackages within the proxy.
    #
    # Proxies generated for metaclasses allow object creation using the 'new' method.
    # Strategies for customizing the created objects are supported. They are 
    # kept by an StrategyProvider.
    #
    # == Arguments
    # * <tt>metamodels</tt>. A list of NamespaceMetamodelBinding objects.
    # * <tt>models</tt>
    # * <tt>strategy_provider</tt>
    # 
    class RmofProxyBuilder
      def initialize(metamodels, models, strategy_provider)
        @metamodels  = metamodels
        @models      = [*models]
        @strategy_provider = strategy_provider
      end
      
      # It creates an empty proxy, that is, metaclasses can be accessed
      # and instantiated, but no objects are available.
      def empty_proxy        
        coordinator = ProxyCoordinator.new
        create_strategies(coordinator)
        proxys = @metamodels.map { |namespace_mm| 
          proxy = create_metamodel_proxy(namespace_mm.metamodel, coordinator)
          NamespaceProxyBinding.new(namespace_mm.namespace, proxy) 
        }
        ProxyBuilderResult.new(proxys, coordinator)
      end
      
      # It fill the proxy with the model objects.
      # Metaclasses not belonging to any metamodel specified in the metamodel
      # won't be considered.
      #
      def filled_proxy
        result = empty_proxy
        @models.each { |model| 
          model.objects.each { |object| 
            metaclass_proxy = result.coordinator.query_metaclass_proxy(object.metaclass)
            metaclass_proxy.__add_object_and_alter(object) if metaclass_proxy 
          }
        }
        result     
      end
      
      protected
      
      # It creates an empty proxy. The +metamodel_model+ is a model for the metamodel
      # that contains the classifiers to be wrapped by the proxy.
      #
      # == Arguments
      # * <tt>metamodel_model</tt>. The metamodel model containing EClassifiers.
      # * <tt>coordinator</tt>. The ProxyCoordinator in charge of proxy operations common to several proxies.
      #
      def create_metamodel_proxy(metamodel_model, coordinator)
        MetamodelProxy.new(metamodel_model, coordinator, @strategy_provider)
      end
      
      def create_strategies(coordinator)
        keep = KeepAllObjectsStrategy.new(coordinator)
        @strategy_provider.filling_strategies  << keep
        @strategy_provider.creation_strategies << keep	      
      end
      
    end  
    
    # This class is in charge of implementing operations that affects to
    # proxies related by a common model-type definition.
    # 
    # Each proxy is in charge in adding itself to the list of proxies
    # maintained by the coordinator.
    #
    class ProxyCoordinator
      attr_reader :proxys
      def initialize
        @proxys = []
      end
      
      def query_metaclass_proxy(metaclass_proxy)
        @proxys.each do |p|
          result = p.__query_metaclass_proxy(metaclass_proxy)
          return result if result
        end
        return nil
      end
      
      def collect_root_objects
        @proxys.map { |p| p.__root_objects }.flatten.uniq
        #self.all_objects.select { |o| o.__container__ == nil } #+
        #@proxy_subpackages.map { |pkg| pkg.collect_root_objects }.flatten +
        #@referenced_pkgs.values.map { |pkg| pkg.collect_root_objects }.flatten
        # TODO: Handle subpackages, and do it more efficiently
        
      end
    end
    
    # This class contains the set of proxys that are created by the ProxyBuilder.
    # It provides global operations on the proxys, such as serialize.
    class ProxyBuilderResult
      attr_accessor :rmof_adapter
      attr_reader :coordinator
      
      def initialize(namespace_proxy_bindings, coordinator)
        @namespace_proxy_bindings = namespace_proxy_bindings
        @coordinator = coordinator
      end  
      
      def proxys
        @namespace_proxy_bindings.map { |np| np.proxy }
      end
      
      def namespace_proxy_bindings
        @namespace_proxy_bindings.each do |np|
          yield(np.namespace, np.proxy)
        end
      end   
      
      def serialize(file_resource, serializer_options)
        serializer_class = serializer_options ? 
            serializer_options.serializer_class :
            RMOF::ECore::Serializer

        model = RMOF::Model.new('file://' + file_resource.file_path, 
                                self.collect_root_objects)     
        serializer = serializer_class.new(model, rmof_adapter)
        File.open(file_resource.file_path, 'w') do |f|
          serializer.serialize(f)
        end
        $stderr << "Warning: Serializing empty model #{file_resource.file_path}#{$/}" if model.root_elements.empty?
      end
      
      def collect_root_objects
        @coordinator.collect_root_objects
      end         
    end
    
    class PackageProxy < Module
      attr_reader :classifiers
      attr_reader :subpackages
      
      def initialize(package, strategy_provider = nil)
        @package = package
        @strategy_provider = strategy_provider.merge(RubyTL::Base::StrategyProvider.new) # TODO: clone... hack
        initialize_structure()
        super()
      end
      
      def pkg_name
        @package.name
      end
      
      def all_klasses
        self.classifiers.select { |c| c.respond_to?('is_metaclass?') && c.is_metaclass? }
      end
      
      # Look up a proxy corresponding to the passed metaclass (RMOF metaclass).
      # It searchs the root package metamodel, all subpackages and also all
      # referenced metamodel that has been specified along with this metamodel
      # in the model type definition.
      #
      # Returns +nil+ if no correspondence is found. This likely to happen if
      # the metaclass belongs to a metamodel not specified as part of the model type. 
      #
      def __query_metaclass_proxy(metaclass)
        if metaclass.ePackage == @package
          find_proxy_here(metaclass)
        else
          find_proxy_in_other_packages(metaclass)
        end
      end
      
      def __root_objects
        @proxies.values.select { |p| p.respond_to? :all_objects }.
        map { |p| p.all_objects.select { |o| o.__container__ == nil } }.flatten.uniq +
        @subpackages.map { |pkg| pkg.__root_objects }.flatten
      end
      
      def const_missing(name)
        raise NameError.new("Classifier '#{name}' not exist for package '#{@package.name}'")
      end
      
      def all_klasses
        @classifiers.select { |c| c.kind_of?(MetaclassProxy) }
      end
      
      def all_subpackages
        [self] + @subpackages.map { |p| p.all_subpackages }.flatten
      end
      
      protected
      def initialize_structure()	      
        @classifiers = []
        @subpackages = []
        @proxies     = {}
        
        @package.classifiers.each do |element|
          select_by_type(element) do |proxy, alternative|
            @classifiers << proxy
            @proxies[element] = proxy
            set_proxy_element(element, proxy, alternative)
          end
        end
        
        @package.eSubpackages.each do |pkg|
          @subpackages << proxy = PackageProxy.new(pkg, @strategy_provider)
          set_proxy_element(pkg, proxy, 'P')
        end
      end
      
      def set_proxy_element(element, proxy, alternative_letter)
        self.const_set(element.non_qualified_name.to_ruby_constant_name(alternative_letter), proxy)
      end
      
      def select_by_type(element)    
        if element.is_metaclass?
          yield MetaclassProxy.new(element, @strategy_provider), 'C'  
        elsif element.is_enumeration?
          yield EnumerationProxy.new(element), 'E'
        elsif element.is_primitive? && !element.is_enumeration?
          yield DataTypeProxy.new(), 'D'
        else
          raise "Not considered #{element}"
        end
      end
      
      def find_proxy_here(metaclass)
        metaclass = metaclass.real_klass if metaclass.respond_to? :real_klass
        result = @proxies[metaclass]
        #This assertion has proved to be satisfied: removed for performance
        #raise ProxyNotExistForMetaclass.new("Proxy not exist for metaclass #{metaclass.name}") unless result
        result
      end
      
      # Find a proxy for a metaclass in some subpackage or on a referenced
      # package.
      def find_proxy_in_other_packages(metaclass)
        @subpackages.each do |pkg|
          p = pkg.__query_metaclass_proxy(metaclass)
          return p if p
        end
        # TODO: Improve performance
        return nil
      end
      
    end
    
    # An special kind of module that represents metamodels.
    #
    class MetamodelProxy < PackageProxy
      
      def initialize(metamodel, coordinator, strategy_provider)
        @metamodel = metamodel
        @coordinator = coordinator
        @coordinator.proxys << self
        
        super(root_package(), strategy_provider)      
      end
      
      protected
      
      # Returns the root package to be considered in this proxy. 
      # If the metamodel has more than one root package, an anonymous
      # root package containing the root packages is created.
      def root_package
        if @metamodel.root_elements.size == 1
          @metamodel.root_elements.first
        else
          pkg = ECore::EPackage.new(:name => 'AnonymousMainPkg')
          @metamodel.root_elements.each { |p| pkg.eSubpackages << p }
          pkg
        end      
      end
      
      
    end
    
    class MetaclassProxy
      include RubyTL::RumiRMOF::ClassInterface
      
      attr_reader :real_klass
      
      def initialize(metaclass, strategy_provider = nil)
        @real_klass = metaclass
        @strategy_provider = strategy_provider
        @objects = Set.new
        @decorators = []
        @decmod = Module.new
        @strategy_provider.adapt_metaclass_proxy(self) if @strategy_provider
      end
      
      def __add_object(object)
        #@decorators.each { |d| object.instance_eval(&d) }
        object.send(:extend, @decmod)
        @objects << object      
      end
      
      def __add_object_and_alter(object)
        if @strategy_provider
          @strategy_provider.alter_object(object, self) 
          @strategy_provider.fill_with_object(object)
        end
        __add_object(object)
      end
      
      # Initialization method, simulating the standard Ruby method
      # in classes.
      def new(initial_values = {})
        object = if @real_klass.kind_of?(ECore::EClass)
          RMOF::ModelObject.new(@real_klass)
        else
          @real_klass.new()
        end
        
        @strategy_provider.alter_object(object, self)  if @strategy_provider
        @strategy_provider.create_object(object, initial_values) if @strategy_provider
        __add_object(object)        
        object.auto_set_features(initial_values)
        
        #alter_object(object)
        #object.auto_set_features(initial_values)
        # @package_module.add_object(object) TODO: ADD THE OBJECT
        yield(object) if block_given?
        object
      end    
      
      def all_objects
        @objects.to_a
      end
      
      # Decorate the metaclass by evaluationg a block (which actually decorates the class) 
      # in the context of  
      def decorate(block)
        @decorators << block
        @decmod.module_eval(&block)
        #@objects.each do |o|
        #  o.instance_eval(&block)
        #end
      end
      
    end
    
    class EnumerationProxy < Module
      def initialize(element)
        element.eLiterals.each do |literal|
          self.const_set(literal.name.to_ruby_constant_name("L"), literal)
        end      
        super()
      end
    end
    
    class DataTypeProxy < Module
    end
    
    class ProxyNotExistForMetaclass < RubyTL::BaseError; end;        
  end      
end
