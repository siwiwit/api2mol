module RMOF

  # This class is in charge of parsing eMOF compliant XMI files.
  #
  #
  class EMofParser < ECoreParser

    def custom_element_parsing(object, element)
      if xmi_id = element.attributes['xmi:id']
        @model.xmi_id_set(object, xmi_id) if object
      end
    end
  
    def resolve_reference_type(reference_element, reference)
      if type = reference_element.attributes['xmi:type'] 
        # TODO: Is always like this? What about cross-file references?
        type =~ SPLIT_TYPE
        yield($2, $1, nil)
      else
        yield(reference.eType.non_qualified_name, 
              reference.eType.ePackage.nsPrefix,
              reference.eType.ePackage.nsURI)
      end
    end
    
    def skip_attribute(attribute) 
      attribute.prefix == 'xmi'
    end
    

    MATCH_EMOF_REFERENCE = /^(.+\s)?([^\s\t\r\n\f#]+)?#?(.+)$/
    
    def lookup_reference_string(property, ref_string, model)
      concrete_type, model_uri, path = match_reference(ref_string)
      model = resolve_model(model, model_uri)                   
      if path.include?('//') # ecore format...
        return model.lookup_object(path), model    
      else
        return model.lookup_xmi_id(path), model
      end
    end
    
    def match_reference(ref_string)
      if ref_string.include?('#')
        ref_string =~ MATCH_EMOF_REFERENCE        
        return $1, $2, $3
      else        
        return nil, nil, ref_string
      end
    end
  end
end
      