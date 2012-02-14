
module RMOF

  # This module applies heuristics to determine the format of a file
  # being parsed and returns a concret parser able to read the model.
  # 
  module FormatGuesser
    class << self
      alias_method :old_recursive_visit, :recursive_visit
    end  

    # Override the default FormatGuesser.
    # if it encounters -> xmlns:uml="http://www.eclipse.org/uml2/2.1.0/UML"     
    def self.recursive_visit(xml_reader, element) 
      xml_reader.each_attribute_of(element) do |a| 
        if a.name == 'uml' && xml_reader.attribute_has_prefix?(a, 'xmlns') && a.value == 'http://www.eclipse.org/uml2/2.1.0/UML'        
          return RubyTL::UML2::Parsers::EUml2_1_0          
        end
        if a.name == 'uml' && xml_reader.attribute_has_prefix?(a, 'xmlns') && a.value == 'http://schema.omg.org/spec/UML/2.0'        
          return RubyTL::UML2::Parsers::ParserMD_12_5
        end
      end  
      old_recursive_visit(xml_reader, element)     
    end    

  end
end  