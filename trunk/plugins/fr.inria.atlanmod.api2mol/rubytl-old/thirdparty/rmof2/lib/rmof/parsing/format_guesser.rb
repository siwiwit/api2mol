
module RMOF

  # This module applies heuristics to determine the format of a file
  # being parsed and returns a concret parser able to read the model.
  # 
  module FormatGuesser
    
    # Guess a format given the xml dom tree. The heuristics are simple:
    # * If there is some xsi:type, is ecore format
    # * If there is some xmi:type, is emof format
    # * Else, raise RMOF::UnknownFormat
    def self.guess(xml_dom, default_parser = nil)
      #return RMOF::ECoreParser if REXML::XPath.first(xml_dom, '//[@xsi:type]')
      #return RMOF::EMofParser if REXML::XPath.first(xml_dom, '//[@xmi:type]')
    
      return recursive_visit(xml_dom.root) || default_parser
    end
  
  private
    def self.recursive_visit(element)
      element.attributes.each_attribute do |a| 
        if a.name == 'type'
        return RMOF::ECoreParser if a.prefix == 'xsi'
        return RMOF::EMofParser if a.prefix == 'xmi'
        end
      end  
      
      element.each_element do |element|
        result = recursive_visit(element)
        return result if result
      end   
      nil 
    end
  end
  
end