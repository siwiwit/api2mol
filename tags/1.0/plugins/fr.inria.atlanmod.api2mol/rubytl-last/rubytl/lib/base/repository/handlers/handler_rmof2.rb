
module RubyTL
  class ModelIdGenerator
    def initialize; @id = 0; end
    def next; @id += 1; end 
  end

  # This class accesses the RMOF repository, providing a set of
  # 'standard'f operations to work with it.
  class HandlerRMOF2 < RubyTL::Base::ModelHandler 
    include RubyTL::Base::RubyModelLoading
    
    IdGenerator = ModelIdGenerator.new
  
    def initialize(config)
      super(config)
      @adapter = RMOF::ECore::FileModelAdapter.new(RUBYTL_REPOSITORY)
      # Traverse config.mappings and 
      #   @adapter.add_mapping
    end
    
    def support?(model_information)
      return false if model_information.multi_metamodel?
      if model_information.metamodel.is_uri?
        return @adapter.can_handle?(model_information.metamodel.uri_string)
      elsif model_information.metamodel.is_local_resource?
        return model_information.metamodel.file_extension == 'ecore' 
      end
      return false
    end

    def plain_load(model_information)
      load_metamodel(model_information.metamodel, @adapter)
      raise "Only one model supported" if model_information.models.size > 1

      model_resource = model_information.models.first
      raise "Plain loading not supported for rb models" if model_resource.file_extension == 'rb'

      RubyTL::Base::PlainModel.new(self, load_model(model_resource, @adapter))      
    end

    #
    # It returns a LoadedModel object.
    # 
    def load(model_information) 
      proxy   = PackageProxy2.create_model_proxy(load_metamodel(model_information.metamodel, @adapter), 
                                                 RubyTL::HandlerRMOF2::IdGenerator.next)
      
      raise "Only one model supported" if model_information.models.size > 1
      model_resource = model_information.models.first

      if model_resource.file_extension != 'rb'
        model = load_model(model_resource, @adapter)      
        fill_proxy(proxy, model)
        proxy.model_set(model)
      else
        load_ruby_source_model(model_resource.file_path, proxy, model_information.namespace)                
      end
      
      #proxy.model_file = model_information.models.first.file_path
      proxy.model_information = model_information
      proxy.rmof_adapter = @adapter
      RubyTL::Base::LoadedModel.new(model_information, proxy)
    end
    
    # Creates a new model conforming a metamodel.
    # It returns a proxy.    
    def new_model(model_information)
      raise "Only one model supported" unless model_information.models.size == 1
      
      model = load_metamodel(model_information.metamodel, @adapter)
      proxy = PackageProxy2.create_model_proxy(model, RubyTL::HandlerRMOF2::IdGenerator.next)      
      
      # TODO: What about in memory files?
      proxy.model_information = model_information#.models.first
      proxy.rmof_adapter = @adapter
      RubyTL::Base::LoadedModel.new(model_information, proxy)
    end        

    def add_mapping(mapping)
      if mapping.is_uri_to_uri?
        @adapter.add_uri_mapping(mapping.uri, mapping.resource_name)
      else      
        @adapter.add_mapping(mapping.uri, mapping.resource_name, mapping.fragment)
      end        
    end

    
  private

    def load_metamodel(metamodel_resource, adapter = nil)
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
      file = File.new(model_resource.file_path)
      xml_reader = RMOF::XMLReaderAdapter.load(file)      
      parser = RMOF::FormatGuesser.guess(xml_reader, RMOF::ECoreParser)
      parser.new(xml_reader, adapter, :file_path => file.path).parse()
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

  # A module to be mixed inside a dynamic proxy for a metamodel package.
  # It provides methods to get modified classes from the package, so that
  # these classes register its instances within the package each time
  # they are created.
  # 
  #  
  module PackageProxy2

    # Create an empty proxy for a metamodel.
    #
    # * <tt>package</tt>. The root package of the metamodel.
    #
    def self.create_model_proxy(model_or_package, model_id)
      if model_or_package.respond_to? :root_elements
        model   = model_or_package
        package = if model_or_package.root_elements.size == 1
            model_or_package.root_elements.first
        else
            epackage = ECore::EPackage.new
            model_or_package.root_elements.each { |p| epackage.eSubpackages << p }
            epackage 
        end
      else
        model   = nil
        package = model_or_package
      end
      mod = Module.new
      mod.extend RubyTL::Base::ModelProxyMixin
      mod.extend PackageProxy2::ClassMethods
      mod.extend SerializableModel2::ClassMethods
      mod.element_set(package, model_id, model)
      mod
    end

    module ClassMethods
      attr_reader :_element
      attr_reader :extension_modules
      attr_accessor :parent_package
      
      def model_set(model)
        @model = model
      end

      # Sets the meta-element that is handled by the proxy
      def element_set(rmof_package, model_id, metamodel_model = nil)
        @metamodel = metamodel_model
        @objects = Set.new
        @objects_by_klass = {}
        @package = rmof_package
        @proxy_subpackages = []
        @proxys = {}
        @extension_modules = {}
        @subclasses = {}
        @referenced_pkgs = {}
        @pending_external_objects = {}
        @model_id = model_id
        @rumi_model_id = model_id
        
        all_klasses do |element|          
          @proxys[element] = proxy = create_klass_proxy(element)
          @extension_modules[element] = create_extension_module(element)
          @objects_by_klass[element.name] = Set.new
          self.const_set(element.non_qualified_name.to_ruby_constant_name, proxy)
          fill_subclasses(@subclasses, element)
        end
        
        all_enumerations do |element|
          literal_mod = Module.new
          self.const_set(element.non_qualified_name.to_ruby_constant_name("E"), literal_mod)
          element.eLiterals.each do |literal|
            literal_mod.const_set(literal.name.to_ruby_constant_name("L"), literal)
          end
        end

        # TODO: How to use them in a rule??
        all_datatypes do |element|
          self.const_set(element.non_qualified_name.to_ruby_constant_name("D"), create_datatype_proxy(element))
        end

        @package.eSubpackages.each do |subpackage|
          @proxy_subpackages << proxy_subpackage = PackageProxy2.create_model_proxy(subpackage, @model_id)
          proxy_subpackage.parent_package = self          
          self.const_set(subpackage.name.to_ruby_constant_name("P"), proxy_subpackage)
        end        
      end

      def proxy_classes; @proxys.values; end
      def proxy_packages; @proxy_subpackages; end
      def rmof_package; @package; end                          
      def name
        @package.name.to_metamodel_name
      end

      def referenced_pkg(pkg_name, options = {})
        raise "External packages can only be imported from the root namespace" unless @metamodel
        available_pkg_names = @metamodel.referenced_models.map { |m| m.root_elements.map { |p| p.name } }.join(', ')
        import_kind = [:partial, :contained, :none].include?(options[:import]) ? options[:import] : :full
        @metamodel.referenced_models.each do |model|
          model.root_elements.each do |pkg|
            return find_or_create_referenced_package(pkg, model, @model, import_kind) if pkg.name == pkg_name
          end    
        end
        raise InvalidReferencedPackage.new(pkg_name, available_pkg_names)
      end

      def find_package(pkg_object)
        return self if @package == pkg_object
        @proxy_subpackages.each do |pkg|
          p = pkg.find_package(pkg_object)
          return p if p
        end
        return nil
      end

      def all_objects
        @objects
      end

      # Returns an array containing all objects of a specified class.
      def all_objects_of(klass)
        @objects_by_klass[klass.name].to_a || []
      end

      def create_klass_proxy(rmof_klass)
        klass = Class.new
        klass.extend ClassProxy2::ClassMethods
        klass.initialize_proxy(self, rmof_klass)
        klass
      end

      def create_datatype_proxy(rmof_datatype)
        Module.new
      end
      
      def create_extension_module(rmof_klass)
        Module.new
      end

      # Override properties which are references, i.e., properties whose
      # type is not primitives in order to add to the assigment the semantics
      # of the binding.
      # 
      # == Arguments
      # * <tt>block</tt>. A block that will be called each time a binding have to
      #                   be resolved. It provides the binding semantics.
      # 
      def modify_assignments_for_binding_semantics(&block)
        @binding_semantics = block
        @proxys.values.each do |proxy|
          proxy.set_binding_semantics(&block)
        end
        @proxy_subpackages.each { |pkg| pkg.modify_assignments_for_binding_semantics(&block) }
      end
      
      def all_klasses
        @package.classifiers.each do |e| 
          if e.is_metaclass?
            yield(e) if block_given?          
          end
        end
      end
      
      def all_enumerations
        @package.classifiers.each do |e| 
          if e.is_enumeration?
            yield(e) if block_given?          
          end
        end      
      end

      def all_datatypes
        @package.classifiers.each do |e| 
          if e.is_primitive? && !e.is_enumeration?
            yield(e) if block_given?          
          end
        end      
      end

      #def add_to_pending_objects(object)
      #  klass = object.metaclass
      #  @pending_external_objects[klass.ePackage] ||= []
      #  @pending_external_objects[klass.ePackage] << object      
      #end

      def add_object(object, options = {})
        add_object_by_child_metaclass(object, object.metaclass)

        if options[:alter_object]
          RubyTL::Base::HideUtility.hide_inverse(object)
          # TODO: Handle better reference to other metamodels
          # For this moment, just ignore the situation
          #raise "Metaclass #{object.metaclass.name} does not exist" unless @proxys.key?(object.metaclass)
          return unless @proxys.key?(object.metaclass)
          @proxys[object.metaclass].send(:alter_object, object)
          object.model_id = @model_id # TODO: Warning: This was befor add_object_by_child_metaclass
        end
      end

      # Traverse the list of extension modules of a metaclass
      def extension_modules_for(rmof_klass)
        ((@subclasses[rmof_klass] || []) + [rmof_klass]).map do |type|
          extmod = @extension_modules[type]
          $stdout << "Warning: No extension module found for #{rmof_klass.name} #{type}" + $/ unless extmod
          yield(extmod)
        end
      end
            
    protected
      # Add an object to the list of objects of a child metaclass, that is,
      # a metaclass which is within a package.
      def add_object_by_child_metaclass(object, metaclass)      
        @objects << object
        ([metaclass] + metaclass.all_super_types).each do |klass|
          if external_metaclass?(klass) 
            ref = metamodel_pkgs[klass.ePackage] || @referenced_pkgs[klass.ePackage]
            ref.add_object_by_child_metaclass(object, klass) if ref # Look out, the specific metaclass (klass) need to be used to avoid recursivity
          else
            raise "No metaclass '#{klass.name}' exist in the package" unless @objects_by_klass[klass.name]
            @objects_by_klass[klass.name] << object
          end
        end 
      end
      
      def metamodel_pkgs
        return @parent_package.metamodel_pkgs if @parent_package
        unless @all_proxy_subpackages
          @all_proxy_subpackages = {}
          ([self] + self.all_proxy_subpackages).each do |p|
            @all_proxy_subpackages[p.rmof_package] = p
          end      
        end
        @all_proxy_subpackages
      end
      
      def all_proxy_subpackages
        self.proxy_packages + self.proxy_packages.map { |p| p.all_proxy_subpackages }.flatten
      end
      
      def fill_subclasses(subclasses, element)       
        element.all_super_types.each do |super_type|
          subclasses[super_type] ||= []
          subclasses[super_type] << element
        end
      end
      
      def external_metaclass?(klass)
        klass.ePackage != @package
      end
      
      # TODO: This is a quick hack, test that it really works in complex cases
      def find_or_create_referenced_package(pkg, metamodel, main_model, import_kind)
        if referenced = @referenced_pkgs[pkg]
          return referenced
        end
        @referenced_pkgs[pkg] = referenced = PackageProxy2.create_model_proxy(pkg, @model_id)
        
        if @binding_semantics
          referenced.modify_assignments_for_binding_semantics(&@binding_semantics) 
        end

        #pending = @pending_external_objects[pkg]
        #if pending
        #  pending.each { |o| referenced.add_object(o) }
        #  @pending_external_objects[pkg] = nil
        #end

        return referenced unless main_model        
        
        model_list = if import_kind == :full
          ([main_model] + main_model.referenced_models.to_a)
        elsif import_kind == :partial || import_kind == :contained
          [main_model]
        else
          []
        end
        
        # TODO: Factorize      
        model_list.each do |model|
          if model.referenced_models.include?(metamodel)
            model.objects.each do |object|
              if import_kind == :contained && (object.owning_model != main_model)
                # skip
              else
                pkgproxy = referenced.find_package(object.metaclass.ePackage) 
                pkgproxy.add_object(object, :alter_object => true) if pkgproxy
              end
            end
          end
        end
        
        referenced
      end
    end
  end
 
  module ClassProxy2
    module ClassMethods
      include RubyTL::RumiRMOF::ClassInterface
      
      attr_reader :real_klass
      
      def initialize_proxy(package_module, real_klass)
        @package_module = package_module
        @real_klass = real_klass
        @decorators = []
      end
      
      def new(initial_values = {})
        object = if @real_klass.kind_of?(ECore::EClass)
          RMOF::ModelObject.new(@real_klass)
        else
          @real_klass.new()
        end
        alter_object(object)
        object.auto_set_features(initial_values)
        @package_module.add_object(object)
        yield(object) if block_given?
        object
      end
    
      def all_objects(&block)
        result = @package_module.all_objects_of(@real_klass) 
        result.each(&block) if block_given?
        result
      end
    
      def name
        @real_klass.name
      end

      # TODO: Exactly determine when this method is called, and when is called
      # thde Ecore::EClass method...
      #
      # Conformance means that +this+ object is an instance of the
      # passed +metaclass+ or of any of this superclasses. This means
      # that +self.metaclass+ is a subclass of the passed +metaclass+, and
      # so it can be assigned to any instance of such metaclass.
#      def conforms_to(metaclass)
#        metaclass = metaclass.real_klass if metaclass.respond_to? :real_klass 
#        return true if metaclass == @real_klass
#        return true if @real_klass.all_super_types.include? metaclass        
#        return false        
#      end            

      # Decorate the metaclass by evaluationg a block (which actually decorates the class) 
      # in the context of 
      def decorate(block)
        @package_module.extension_modules_for(@real_klass) do |extmod|
          extmod.module_eval(&block)
        end
      end

      def set_binding_semantics(&block)
        @binding_semantics = block
        @bindings_text = @real_klass.all_references.map do |reference|
          new_method = <<-METHOD 
            def #{reference.name}=(value)
              binding = RubyTL::Rtl::BindingAssignment.new(value, self, '#{reference.name}')
              @__binding_semantics__.call(binding)
            end
          METHOD
        end.join
      end      
      
    private
      # Alter the +object+, gathered from RMOF, to make it compatible with RubyTL
      # It creates some singleton methods such as:
      # * <tt>kind_of?</tt>
      #
      def alter_object(object)
        is_module = object.kind_of?(Module)
        object.extend(RubyTL::RumiRMOF::ModelObjectInterface)
        object.virtual_klass = self
        object.extend(ClassProxy2::InstanceMethods)
        
        object.instance_eval do
          class << self
            alias_method :old_set, :set
          
            def set(property, value, resolve_inverse = true) 
              if value.kind_of?(Array)
                value.each { |v| set(property, v, resolve_inverse) }
                return
              end
              return if value.nil?
              old_set(property, value, resolve_inverse)
            end
          end        
        end unless is_module # When loading an ECORE metamodel, the ECore::EBoolean is not a class...

                
        object.instance_eval(@bindings_text, __FILE__, __LINE__) if @bindings_text
        object.__binding_semantics__ = @binding_semantics

        #@package_module.extension_modules_for(@real_klass) do |extmod|
        #  object.extend(extmod)
        #end
        object.extend @package_module.extension_modules[@real_klass]
      end
    end
    
    module InstanceMethods
      attr_writer :__binding_semantics__
      #attr_writer :virtual_klass
      
#      alias_method :old_kind_of?, :kind_of?
#      def kind_of?(klass)
#        if klass.respond_to?(:real_klass)
#          @virtual_klass.conforms_to(klass.real_klass)  
#        else
#          return old_kind_of?(klass)
#        end
#      end

        
    end
  end 
end


module SerializableModel2
  module ClassMethods
    #attr_accessor :model_file
    attr_accessor :rmof_adapter
  
    def serialize(file_resource)
      model = RMOF::Model.new('file://' + file_resource.file_path,
                              self.collect_root_objects.uniq)      
      serializer = RMOF::ECore::Serializer.new(model, rmof_adapter)
      File.open(file_resource.file_path, 'w') do |f|
        serializer.serialize(f)
      end
    end
    
    def collect_root_objects
      self.all_objects.select { |o| o.__container__ == nil } +
        @proxy_subpackages.map { |pkg| pkg.collect_root_objects }.flatten +
        @referenced_pkgs.values.map { |pkg| pkg.collect_root_objects }.flatten
    end
  end
end


# Adapt RMOF
#
module ECore
  class EReference
    def endType
      self.eType
    end
  end
end

module ECore
  class EClass
      
    # TODO: Merge with the other conforms_to
    # TODO: Reuse 'compatiblity_test'
    def conforms_to(metaclass) 
      metaclass = metaclass.real_klass if metaclass.respond_to? :real_klass   
      return true if metaclass == self
      return true if self.all_super_types.include? metaclass
      return false
    end            
  end
end

module RMOF
  class ModelObject
    attr_accessor :model_id # TODO: Added to alter_object -> remove here
    undef_method :type if method_defined?(:type)
    
    def isInstanceOf(metaclass)
      metaclass = metaclass.real_klass if metaclass.respond_to? :real_klass
      self.is_instance_of?(metaclass)
    end
    
    # TODO: Added to alter_object -> remove here    
    def set_reference_value(reference, value)
      if value.kind_of? Array
        value.each { |v| set_reference_value(reference, v) }
      else
        self.set(reference, value)         
      end
    end

    # I can't add this... How to do this...
#    alias_method :old_set, :set
#    def set(property, value, resolve_inverse = true)   
#      return if value.nil?
#      old_set(property, value, resolve_inverse)
#    end
    
    def linked?
      @__trace__ && @__trace__.size > 0
    end
    
    def add_trace_information(hash)
      @__trace__ ||= {}
      @__trace__.merge!(hash)
    end    
  end
end