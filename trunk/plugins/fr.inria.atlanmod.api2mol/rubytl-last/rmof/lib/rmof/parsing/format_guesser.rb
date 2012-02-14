
module RMOF

  # This module applies heuristics to determine the format of a file
  # being parsed and returns a concret parser able to read the model.
  # 
  module FormatGuesser
    
    # Guess a format given the xml dom tree (which is wrapper in an XMLREader adapter).
    # The heuristics are simple:
    # * If there is some xsi:type, is ecore format
    # * If there is some xmi:type, is emof format
    # * Else, raise RMOF::UnknownFormat
    def self.guess(xml_reader, default_parser = nil)        
      #return RMOF::ECoreParser if xml_reader.xpath('//@xsi:type') != nil
      #return RMOF::EMofParser  if xml_reader.xpath('//@xmi:type') != nil
      #return default_parser   
      return recursive_visit(xml_reader, xml_reader.root) || default_parser
    end
  
  private

    def self.recursive_visit(xml_reader, element)
      xml_reader.each_attribute_of(element) do |a| 
        # TODO: This doesn't work with Nokogiri unless xmi or xsi are declared as namespaces
        if a.name == 'type'
          return RMOF::ECoreParser if xml_reader.attribute_has_prefix?(a, 'xsi')
          return RMOF::EMofParser if xml_reader.attribute_has_prefix?(a, 'xmi')
        end
      end  
      
      xml_reader.each_element_of(element) do |element|
        result = recursive_visit(xml_reader, element)
        return result if result
      end   
      nil 
    end

  end
  
end
