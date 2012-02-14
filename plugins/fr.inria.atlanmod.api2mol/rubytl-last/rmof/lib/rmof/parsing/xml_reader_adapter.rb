require 'rexml/document'

module RMOF
  # This class is an adapter to make the parsing of XMI files
  # indepedent of the XML library. It is used as a base class
  # for the others adapters. It is not intended for "external"
  # extension, since (for simplicity) it knows its subclasses.
  #
  # It automatically selects the best implementation depending
  # what it is installed in the system.
  # 
  # It currently supports REXML and Nokogiri. 
  #
  class XMLReaderAdapter
    def initialize(document)
      @document = document
    end 

    def self.force(what)
      @force = what
    end

    def self.load(io_or_object)  
      if is_nokogiri_available? && ! io_or_object.kind_of?(REXML::Document) && (@force.nil? || @force == :nokogiri)
        return NokogiriReaderAdapter.adapt(io_or_object)    if io_or_object.kind_of?(Nokogiri::XML)
        return NokogiriReaderAdapter.adapt_io(io_or_object) 
      end 
      return REXMLReaderAdapter.adapt(io_or_object) if io_or_object.kind_of?(REXML::Document)
      return REXMLReaderAdapter.adapt_io(io_or_object)      
    end   

   private
    def self.is_nokogiri_available?
      require 'rubygems'
      require 'nokogiri'  
      true
    rescue LoadError
      false 
    end
  end

  class REXMLReaderAdapter < XMLReaderAdapter
    def self.adapt(document)
      self.new(document)
    end

    def self.adapt_io(io)
      self.adapt(REXML::Document.new(io))
    end

    def root
      @document.root
    end 

    def elements_of(element, &block) 
      result = element.elements
      result.each(&block) if block_given?
      result
    end
  
    def each_element_of(element, &block)
       element.each_element(&block)
    #  self.elements_of(element, &block)
    end

    # Returns the attribute value
    def attribute_of(element, name)      
      element.attributes[name]
    end

    def attribute_with_prefix_of(element, prefix, name)
      attribute_of(element, "#{prefix}:#{name}")
    end

    def attribute_has_prefix?(attribute, prefix)
      attribute.prefix == prefix
    end 

    def each_attribute_of(element, &block)
      element.attributes.each_attribute(&block)
    end

    # Get the href part of the namespace of a given xml element.
    def resolve_namespace(element) 
      if element.prefix.empty?
        return resolve_namespace(element.parent)
      else
        return element.namespace
      end
    end
   
    # Return the href part of the namespace for an element
    # with a given prefix. 
    def resolve_prefix(element, prefix, original = element)
      unless (ns = element.namespace(prefix))
        raise "Namespace for '#{prefix}' not resolved" unless element.parent
        return resolve_prefix(element.parent, prefix, original)
      else
        return ns
      end      
    end

  end

  class NokogiriReaderAdapter < XMLReaderAdapter
     def self.adapt(document)
      self.new(document)
    end

    def self.adapt_io(io)
      self.adapt(Nokogiri::XML(io))
    end

    def root
      @document.root
    end

    def xpath(string)
      @document.xpath(string)
    end
 

    def elements_of(element)
      element.children.select { |n| n.elem? }
    end

    def each_element_of(element, &block)
      element.children.each { |n| 
        yield(n) if n.elem? 
      }
    end

    def attribute_of(element, name)
      a = element.attribute(name)
      a ? a.value : nil
    end

    def each_attribute_of(element, &block)
      element.attribute_nodes.each(&block)
    end

    def attribute_with_prefix_of(element, prefix, name)
      # a = element.xpath("@#{prefix}:#{name}").first 
      a = element.attribute_nodes.find { |n| n.name == name && (n.namespace ? n.namespace.prefix == prefix : false) }
      a ? a.value : nil
    end

    def attribute_has_prefix?(attribute, prefix)
      ns = attribute.namespace
      ns ? ns.prefix == prefix : false
    end

    def resolve_namespace(element) 
      n = element.namespace
      if n.prefix.nil?
        return resolve_namespace(element.parent)
      else
        return n.href
      end
    end
    
    # Return the href part of the namespace for an element
    # with a given prefix. 
    def resolve_prefix(element, prefix, original = element)
       n = element.namespaces["xmlns:#{prefix}"]
       unless n
         raise "Namespace for '#{prefix}' not resolved" if element.kind_of?(Nokogiri::XML::Document)
         return resolve_prefix(element.parent, prefix, original)
       else
         return n
      end      
    end


  end
end


