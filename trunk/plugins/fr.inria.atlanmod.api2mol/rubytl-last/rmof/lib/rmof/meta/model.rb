require 'set'

module RMOF

  # A model object represents an abstract way to access to 
  # the high level features of a model. 
  #
  # A model is the containment of model objects, and it acts
  # as a resource, document or extent (depending on the meta-metamodel
  # terminology.
  #
  class Model
    # include InverseResolvers
      
    attr_accessor :uri
    attr_reader :root_elements
    attr_reader :objects
    attr_reader :referenced_models
    
    def initialize(uri, root_elements = [])
      @uri = uri
      @objects = Set.new
      @referenced_models = Set.new
      @xmi_id_map = Hash.new
      self.root_elements = root_elements
    end
    
    def root_elements=(root_elements)
      @root_elements = [] # ContainmentList.new(self, reference)
      root_elements.each { |e| add_root_element(e) }    
    end
    
    def add_object(object)
      @objects.add(object)
    end
    
    # Add a new root element setting this model as its containing
    # model.
    #
    # == Usage
    # TODO: What is the usage style? Like EMF?
    #
    # == Arguments 
    # * <tt>element</tt>. The element to be added to the model.
    #
    def add_root_element(element)
      element.owning_model = self
      @root_elements << element
    
      # TODO: Check the following
      # - If the element already belongs to another model, remove the element from root_elements of such a model (�use an inverse_resolving_list?)
      # - If the elements has a container (is part of a containment relationship), raise an Exception (or remove it from such a relationship)
    end
    
    # Sets the xmi:id to an object, and the id is registered in the
    # model.
    def xmi_id_set(object, xmi_id)
      raise "XMI:ID alread set" if object.xmi_id
      @xmi_id_map[xmi_id] = object
      object.xmi_id = xmi_id
    end
    
    def lookup_xmi_id(xmi_id)      
      raise "XMI:ID '#{xmi_id}' not found" unless @xmi_id_map.key?(xmi_id)
      @xmi_id_map[xmi_id]
    end
    
    # Given an object path it looks up the object in the
    # model. The implementation is similar (but not equals) to the EMF one.
    #
    # == Arguments
    # * <tt>path</tt>. The path of an object in this model, as a '/' separated list.
    #
    def lookup_object(path)
      # TODO: Check the path with a regular expression
      if path[0..0] == '/'
        return locate_object(path[1..-1].split('/'))
      else
        raise "Path #{path} cannot be resolved"  #"TODO: Get by ID '#{path}'
      end
    end
    
    # Looks for an object, of a certain type, identified by an attribute which specifies
    # its ID.
    #  
    # == Arguments
    # * <tt>type</tt> The type of the object to look for.
    # * <tt>id_attribute</tt>. The attribute that identifies the object.
    # * <tt>id</id>. A value identifiying the object
    def lookup_object_by_id(type, id_attribute, id)
      # TODO: Make it more efficient
      @objects.find { |o| o.metaclass.eIDAttribute == id_attribute && 
                          o.get(id_attribute) == id }
    end
    
    def uri_segment(object)
      index = root_elements.index(object)
      raise "Object not included root elements" unless index
      if self.root_elements.size == 1
        '#/'
      else
        "#/" + index.to_s
      end
    end

    # 
    # Look up for a package, given its +path+. For example,
    #    
    #  model 
    #    + package
    #      + subpackage
    #
    #   model.package_as_model('/package/subpackage') => :Model
    # 
    # == Arguments
    # * <tt>path</tt>. A string containing a reference to a package.
    # 
    def fragment_as_model(fragment_path)
      # First try, assuming that fragment_path is an XMI_ID
      unless package = @xmi_id_map[fragment_path]
        # Fragment path is expected to refer to a package     
        package = lookup_object(fragment_path)        
      end        
      return Model.new(package.nsURI, [package]) 
    end
    
    # Add a model to the list of models referenced by this model.
    # The model is not added if it has been already added.
    # 
    # == Arguments
    # * <tt>model</tt>. The model to add.
    # 
    def add_to_referenced_models(model)
      @referenced_models.add(model) if model != nil
    end
    
  private
    # If the path is an empty list, the first (and 
    #
    def locate_object(path)     
      return @root_elements.first if ( path.size == 0 )

      object = @root_elements.at(path.first == '' ? 0 : path.first.to_i)  
      path[1..-1].each do |fragment|
        object = object.lookup_object(fragment)
        raise FragmentNotFound.new("Fragment not found '#{fragment}' for '#{path.join('/')}'") unless object
      end
      object
    end   
  end
  
  # The metamodel class represents a metamodel, that is,
  # a model of models. In RMOF, the main difference between this two
  # classes is that metamodels ... 
  # TODO: Make it clearer to me myself...
  # 
  # With the new implementation of Model, this class should probably disappear
  #
  class Metamodel < Model
    def initialize(root_module)
      @root_module = root_module
      super(root_module.nsURI, [@root_module])
    end
    
    def instantiate_metaclass(metaclass_name)
      eval("::#{@root_module.name}::#{metaclass_name}").new
      #TODO: Capture errors
    end

    def lookup_xmi_id(xmi_id)      
      unless result = @xmi_id_map[xmi_id]
        result = @root_module.lookup_object(xmi_id)    
        raise "XMI:ID '#{xmi_id}' not found" unless result
      end
      result
    end
    
  end
 
end
