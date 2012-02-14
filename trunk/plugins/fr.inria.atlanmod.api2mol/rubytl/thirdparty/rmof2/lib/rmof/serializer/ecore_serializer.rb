
module RMOF
  module ECore
    class Serializer < RMOF::BaseSerializer
            
      def specialize_root_element(root)
        root.attributes['xmi:version'] = "2.0"
        root.attributes['xmlns:xmi']   = "http://www.omg.org/XMI"
        root.attributes['xmlns:xsi']   = "http://www.w3.org/2001/XMLSchema-instance"
        
        location = @schema_locations.map { |uri, path| "#{uri} #{path}" }.join(' ')
        root.attributes['xsi:schemaLocation'] = location if location.size > 0
      end
      
      def specialize_serialization(element, object, parent_property = nil)
        if parent_property && parent_property.type != object.metaclass
          prefix = object.metaclass.ePackage.nsPrefix
          element.add_attribute("xsi:type", "#{prefix}:#{object.metaclass.non_qualified_name}")
          store_namespace(prefix, object)
        end
      end
      
      # Returns the id (or an XPath expression) to reference a given object
      #
      # == Arguments
      # * <tt>object</tt>. The object to compute its ID
      #
      def id_for_non_containment_reference(object, reference)
        if id_attribute = reference.eType.eIDAttribute
          object.get(id_attribute)
        else
          object.compute_uri_fragment
        end
      end    
    end
  end
end