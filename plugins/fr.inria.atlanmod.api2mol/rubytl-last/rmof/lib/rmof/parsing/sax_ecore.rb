
module RMOF
  class SAXEcoreParser < Nokogiri::XML::SAX::Document
    include CommonMixin
    include ECoreCommonMixin

    def initialize(io_or_string, model_adapter, options = {})
      init_parser(io_or_string, model_adapter, options)
      @io_or_string = io_or_string
      @namespaces = {}
    end
     
    def parse
      parse_init {
        @stack = []
        @s_idx = 0
        @reference_cache ||= {} # This is needed by common_mixin#EcoreCommon

        p = Nokogiri::XML::SAX::Parser.new(self)    
        p.parse(@io_or_string)
      }
      @model
    end

    def start_element_namespace(name, attrs = [], prefix = nil, uri = nil, ns = [])
      xsi_type_str    = nil
      href            = nil
      schema_location = nil

      property_attrs  = []
      object          = nil

      attrs.each do |a|
        if a.prefix == 'xsi' && a.localname == 'type'
          xsi_type_str = a.value
        elsif a.localname == 'href'
          href = a.value
        elsif a.localname == 'schemaLocation' && a.prefix == 'xsi'
          schema_location = a.value
        else
          property_attrs << a
        end
      end

      if @parent_object
        metaclass = @parent_object.metaclass
        property  = metaclass.property(name)
        
        if property.is_attribute?
          @read_text_for_property = property
          #set_property_value_according_to_type(property, parent_object, element.text)
#          raise "Not implemented yet. Attribute as text"
        elsif property.containment && ! href
          # xsi_str = xsi_type ? xsi_type.value : nil
          get_concrete_type_for_reference(property, xsi_type_str) do |type, prefix_, namespace|
            namespace ||= resolve_prefix(prefix_)      
            object = instantiate_metaclass(type, namespace)
            set_value(property, @parent_object, object)
          end
        else
          resolve_href(property, @parent_object, href)
        end
      else     
        record_namespaces(ns)
        parse_schema_location(schema_location) if schema_location

        if prefix == 'xmi' && name == 'XMI'
        else
          #puts "=> #{name}: #{prefix} #{resolve_prefix(prefix)} (also: #{uri})"
          object = instantiate_metaclass(name, resolve_prefix(prefix))        
          @model.add_root_element(object)
        end
      end

      if object
        property_attrs.each { |a| set_attribute(object, a.localname, a.value, a.prefix) }
        @parent_object = object
        @model.add_object(object)
      end
      @stack[@s_idx] = object
      @s_idx += 1

      #puts "Start element: #{name} #{attrs.map { |x| x }.join(', ')} #{prefix} #{uri} #{ns}"
    end

    def end_element(name)
      @s_idx -= 1
      last = @stack[@s_idx]
      @parent_object = @parent_object.__container__ if @parent_object && last
    end

    def characters(string) 
      if @read_text_for_property
        set_property_value_according_to_type(@read_text_for_property, @parent_object, string)
        @read_text_for_property = nil
      end
    end

  protected
    # This is duplicated with ecore.rb
    def skip_attribute(attr_name, prefix)
      prefix == 'xsi' || prefix == 'xmlns'
    end

    def set_attribute(object, attr_name, attr_value, prefix)
      return if skip_attribute(attr_name, prefix)

      metaclass = object.metaclass
      if property = metaclass.property(attr_name)
        set_property_value_according_to_type(property, object, attr_value)
      else
        #@logger << "Property #{attribute.name} does not exist for #{metaclass}" + $/
      end
    end
    
    def record_namespaces(ns_list)
      ns_list.each do |ns|
        @namespaces[ns[0]] = ns[1]
      end
    end

    def resolve_prefix(prefix)
      @namespaces[prefix]
    end
  end
end

