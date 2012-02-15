require 'base_unit'
include RMOF

class FormatGuesserTest < Test::Unit::TestCase

  def xx_test_guess_ecore_format_from_xsi
    ecore_metamodel = %{
      <?xml version="1.0" encoding="UTF-8"?>
      <ecore:EPackage xmi:version="2.0"
          xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xmlns:ecore="http://www.eclipse.org/emf/2002/Ecore" name="library"
          nsURI="http://www.example.eclipse.org/Library" nsPrefix="library">
        <eClassifiers xsi:type="ecore:EClass" name="Book">
        </eClassifiers>
      </ecore:EPackage>
    }
    #doc = REXML::Document.new(ecore_metamodel)
    doc = RMOF::XMLReaderAdapter.load(ecore_metamodel)
 
    assert_equal RMOF::ECoreParser, FormatGuesser.guess(doc)
  end

  def test_guess_ecore_format_from_xmi
    ecore_metamodel = %{
      <?xml version="1.0" encoding="UTF-8"?>
        <eAnnotations xmi:id="_0Uu_XLQqEduLKbKp0g28zA" source="ePackages">
          <contents xmi:type="ecore:EPackage" xmi:id="_0Uu_XbQqEduLKbKp0g28zA" name="MyProfile_0" nsURI="http:///MyProfile_0_0OfNQLQqEduLKbKp0g28zA.profile.uml2" nsPrefix="MyProfile_0">
            <eClassifiers xmi:type="ecore:EClass" xmi:id="_0Uu_XrQqEduLKbKp0g28zA" name="MyProfile__EJBClass">
              <eAnnotations xmi:id="_0Uu_X7QqEduLKbKp0g28zA" source="stereotype" references="_0Uu_cLQqEduLKbKp0g28zA"/>
              <eStructuralFeatures xmi:type="ecore:EAttribute" xmi:id="_0Uu_YLQqEduLKbKp0g28zA" name="javaName" ordered="false" lowerBound="1" defaultValueLiteral="">
                <eType xmi:type="ecore:EDataType" href="http://www.eclipse.org/emf/2002/Ecore#//EString"/>
              </eStructuralFeatures>
            </eClassifiers>
          </contents>
        </eAnnotations>
    }
    # doc = REXML::Document.new(ecore_metamodel)
    doc = RMOF::XMLReaderAdapter.load(ecore_metamodel)
    assert_equal RMOF::EMofParser, FormatGuesser.guess(doc)
  end
end
