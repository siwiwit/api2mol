require 'rubytl_base_unit'

class XSDParserTest < Test::Unit::TestCase
  include RubyTL

  def setup
    
  end

  def test_xsd_parse_schema
    parser = XSD::XSDParser.new(XML::ParserWrapper.new(File.new(TestFiles.ship_order_xsd.file_path)))
    schema = parser.parse
    
    assert_not_nil schema
    assert_equal 1, schema.elements.size    

    ship_order = schema.elements[0]
    assert_equal 'shiporder', ship_order.name
    assert_not_nil ship_order.anonymousTypeDefinition

    assert_equal 1, ship_order.anonymousTypeDefinition.attributes.size
    # Look out! There is no "content" as is, in XSDElementDeclaration 
    
    ship_order_type = ship_order.anonymousTypeDefinition
    assert ship_order_type.content.kind_of?(Xsd::ModelGroup)
    
    model_group = ship_order_type.content
    assert_equal 3, model_group.elements.size
    
    assert_equal 1, model_group.elements.select { |element| element.name == 'shipto' }.size
    shipto = model_group.elements.select { |element| element.name == 'shipto' }.first
    assert_not_nil shipto    
    assert         shipto.kind_of?(Xsd::ElementDefinition)  
    assert_not_nil shipto.anonymousTypeDefinition
    assert_nil     shipto.typeDefinition

    
=begin
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xs:element name="shiporder">
 <xs:complexType>
  <xs:sequence>
   <xs:element name="orderperson" type="xs:string"/>
   <xs:element name="shipto">
    <xs:complexType>
     <xs:sequence>
      <xs:element name="name" type="xs:string"/>
      <xs:element name="address" type="xs:string"/>
      <xs:element name="city" type="xs:string"/>
      <xs:element name="country" type="xs:string"/>
     </xs:sequence>
    </xs:complexType>
   </xs:element>
   <xs:element maxOccurs="unbounded" name="item">
    <xs:complexType>
     <xs:sequence>
      <xs:element name="title" type="xs:string"/>
      <xs:element minOccurs="0" name="note" type="xs:string"/>
      <xs:element name="quantity" type="xs:positiveInteger"/>
      <xs:element name="price" type="xs:decimal"/>
     </xs:sequence>
    </xs:complexType>
   </xs:element>
  </xs:sequence>
  <xs:attribute name="orderid" type="xs:string" use="required"/>
 </xs:complexType>
</xs:element>

</xs:schema>    
=end

  end
  
  def test_xsd_parse_schema_named_types
    parser = XSD::XSDParser.new(XML::ParserWrapper.new(File.new(TestFiles.ship_order_xsd_named_types.file_path)))
    schema = parser.parse

  assert_equal 7, schema.typeDefinitions.size
=begin
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">

<xs:simpleType name="stringtype">
 <xs:restriction base="xs:string"/>
</xs:simpleType>

<xs:simpleType name="inttype">
 <xs:restriction base="xs:positiveInteger"/>
</xs:simpleType>

<xs:simpleType name="dectype">
 <xs:restriction base="xs:decimal"/>
</xs:simpleType>

<xs:simpleType name="orderidtype">
 <xs:restriction base="xs:string">
  <xs:pattern value="[0-9]{6}"/>
 </xs:restriction>
</xs:simpleType>

<xs:complexType name="shiptotype">
 <xs:sequence>
  <xs:element name="name" type="stringtype"/>
  <xs:element name="address" type="stringtype"/>
  <xs:element name="city" type="stringtype"/>
  <xs:element name="country" type="stringtype"/>
 </xs:sequence>
</xs:complexType>

<xs:complexType name="itemtype">
 <xs:sequence>
  <xs:element name="title" type="stringtype"/>
  <xs:element minOccurs="0" name="note" type="stringtype"/>
  <xs:element name="quantity" type="inttype"/>
  <xs:element name="price" type="dectype"/>
 </xs:sequence>
</xs:complexType>

<xs:complexType name="shipordertype">
 <xs:sequence>
  <xs:element name="orderperson" type="stringtype"/>
  <xs:element name="shipto" type="shiptotype"/>
  <xs:element maxOccurs="unbounded" name="item" type="itemtype"/>
 </xs:sequence>
 <xs:attribute name="orderid" type="orderidtype" use="required"/>
</xs:complexType>

<xs:element name="shiporder" type="shipordertype"/>

</xs:schema>
=end  
  end

  def test_xsd_parse_xml_according_to_schema
    parser = XSD::XSDParser.new(XML::ParserWrapper.new(File.new(TestFiles.ship_order_xsd.file_path)))
    schema = parser.parse

    parser = XSD::XMLParser.new(XML::ParserWrapper.new(File.new(TestFiles.ship_order_xml.file_path)),
                                schema)
    xml_tree = parser.parse
    
    assert_not_nil xml_tree
    assert_not_nil xml_tree.root
    
    assert_equal 4, xml_tree.root.children.size
    
    assert_equal 16, xml_tree.objects.size 
  end

=begin
<shiporder orderid="889923" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:noNamespaceSchemaLocation="shiporder.xsd">
	
 <orderperson>John Smith</orderperson>
 <shipto>
  <name>Ola Nordmann</name>
  <address>Langgt 23</address>
  <city>4000 Stavanger</city>
  <country>Norway</country>
 </shipto>
 <item>
  <title>Empire Burlesque</title>
  <note>Special Edition</note>
  <quantity>1</quantity>
  <price>10.90</price>
 </item>
 <item>
  <title>Hide your heart</title>
  <quantity>1</quantity>
  <price>9.90</price>
 </item>
</shiporder>
=end  
  
end
