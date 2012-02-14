require 'rexml/document'
require 'logger'

module RMOF

  # Base class to provide basic parsing capabilities for eCore and
  # EMOF parser. 
  # Subclasses must implement the following methods:
  #
  # * <tt>parse_top_level(root)</tt>. Because each serialization scheme deals with top level
  #                                   elements in a different way.
  # * <tt>switch_type</tt>.
  #
  #
  # == Use
  # This class makes use of a delegate to access the repository. As the parser is not concerned
  # with storage issues, the model delegate should be able to perform the following operations.
  #
  # * <tt>resolve_model(uri)</tt>. Given a uri string a new model is resolved, probably 
  #                                loading it by demand, and a Model object is returned. 
  #
  # Moreover, this class contains methods needed to query the metamodel in a meta-metamodel
  # independent way.
  #
  # * <tt>instantiate_metaclass(metaclass_name, metamodel)</tt>. This method receives the name of the
  #       metaclass to instantiante and the metamodel uri to which it belongs to.
  # * <tt>is_enum?(metaclass)</tt>
  # * <tt>is_class?(metaclass)</tt>
  # * <tt>is_primitive?(metaclass)</tt>  
  #
  # For instance,
  #
  #    model = ModelDelegate.new
  #    model.instantiate_metaclass('EPackage', 'http://www.eclipse.org/emf/2002/Ecore')
  #
  # == Conventions
  # 
  # In this class, variables named <tt>element</tt> refers to xml elements (document nodes),
  # while variables named <tt>object</tt> refers to model objects (probably instantiated
  # from the information gathered from a corresponding xml element). Finally, <tt>metaclass</tt>
  # is used to refer the metamodel class of a given model object.
  #
  class BaseParser
    include RMOF::CommonMixin
    PRIMITIVE    = 'PrimitiveType'
    ENUMERATION  = 'Enumeration'
    METACLASS    = 'Metaclass'

    # Initializes a new parsing class, that can handle either an io object
    # or a string containing the xml document.
    #
    # * <tt>io_or_string</tt>. The IO object (e.g. a file) or a string. It also
    #                          accepts an REXML::Document or a Nokogiri object.
    # * <tt>delegate</tt>. A delegate to access the repository.
    # * <tt>options</tt>. Additional options.  
    #
    def initialize(io_or_string, delegate, options = {})
      init_parser(io_or_string, delegate, options)    
      @reader = if io_or_string.kind_of?(XMLReaderAdapter)
         io_or_string
      else
         XMLReaderAdapter.load(io_or_string) 
      end
      #if io_or_string.kind_of? REXML::Document
      #  @root = io_or_string.root
      #else
      #  @root = REXML::Document.new(io_or_string).root
      #end
    end
  
    def parse
      parse_init {
         @model.root_elements = parse_document(@reader.root)
      }
      @model
   end

    def parse_document(root)
      top_level_nodes(root).map do |element|
        parse_element(element)
      end.compact
    end  

    # Return the list of top XML nodes.
    def top_level_nodes(root)
      return @reader.elements_of(root) if root.name == 'XMI'
      return [root]
    end    
        
    # Parse the content of a given element by recursively traversing its children.
    # There are four steps:
    # 1. Create the corresponding object.
    # 2. Assign the object to its parent if necessary.
    # 3. Parse the attributes of the elements. Values are resolved and asigned to the
    #    correct property of the object.
    # 4. Traverse element's children recursively.
    # 
    # == Explanation
    #
    # In XMI, objects corresponding to inner XML nodes have a containment
    # relationship with the parent's node object. 
    #
    # == Arguments
    # 
    # * <tt>element</tt>. The XML element to be parsed.
    # * <tt>parent_object</tt>. The parent object if it exists, nil if it exists.
    #
    def parse_element(element, parent_object = nil)
      object = instantiate_from(element, parent_object)
      custom_element_parsing(object, element) if respond_to? :custom_element_parsing
            
      if object
        @reader.each_attribute_of(element) { |a| parse_attribute(a, object) }          
        @reader.each_element_of(element) do |element|
          parse_element(element, object)
        end    
        @model.add_object(object)
      end

      return object
    end

    # Parse a given xml attribute. There are three cases according to
    # the corresponding meta-property.# 
    # 1. The meta-property is Primitive 
    # 2. The meta-property is an Enumeration
    # 3. The meta-property is a Class (it corresponds to a reference)
    #
    # TODO: Deal with prefixes and namespaces
    def parse_attribute(attribute, object)
      return if skip_attribute(attribute)
      
      metaclass = object.metaclass
      if property = metaclass.property(attribute.name)
        set_property_value_according_to_type(property, object, attribute.value)
      else
        #@logger << "Property #{attribute.name} does not exist for #{metaclass}" + $/        
      end
    end

    # Creates a new model object from an xml element. This method looks up
    # namespaces to ensure that the model object correspond to a proper
    # metamodel.
    #
    # There are two cases depending on whether a parent objects exists or not.
    #
    # 1. If no parent object exists, then the tag name is a metaclass name that
    #    should be instantiated.
    # 2. Otherwise, the tag name represents a reference that should verify that
    #    <tt>'reference.containment == true'</tt>.
    #
    # == Arguments
    #
    # * <tt>element</tt>. The xml node from which the model object will be instantiated.
    # * <tt>parent_object</tt>. The parent object to which this elements belongs. 
    #
    # The result is a new model object.
    def instantiate_from(element, parent_object = nil)      
      if parent_object        
        metaclass      = parent_object.metaclass
        property       = metaclass.property(element.name)
        raise "Feature #{element.name} does not exist" unless property
        
        if property.is_attribute?
          set_property_value_according_to_type(property, parent_object, element.text)      
          return nil
        end

        reference = property
        if reference.containment && ! href_get(element)
          # TODO: Improve it
          resolve_reference_type(element, reference) do |type, prefix, namespace|
            namespace ||= @reader.resolve_prefix(element, prefix)
            object = instantiate_metaclass(type, namespace)
            set_value(reference, parent_object, object)          
            return object
          end
        else
          raise "Invalid reference #{element.name}" unless href = href_get(element)
          raise "Invalid href at top level" if parent_object.nil?
          
          resolve_href(reference, parent_object, href)
          return nil
        end
      else
        namespace = @reader.resolve_namespace(element)
        return instantiate_metaclass(element.name, namespace)      
      end
      # TODO: Deal with types looking into xsi/xmi:types
    end

protected   
    def href_get(element)
      @reader.attribute_of(element, 'href')
    end
    
   
  end

end
