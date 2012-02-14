require 'rubytl_base_unit'

class ObjectPrintTest < Test::Unit::TestCase

  def setup
  end

  def test_simple_object_printing
    id_property = Test::PrintableMock::Property.new('id')
    irrelevant  = Test::PrintableMock::Property.new('irrelevant')
    
    mock = Test::PrintableMock.new
    mock.add_property(id_property)
    mock.add_property(irrelevant)    
    mock.id = 'the_id'

    assert_equal [id_property], mock.relevant_properties
    assert_equal "id = 'the_id'", mock.to_s
  end
  
  def test_recognizing_names
    name_property = Test::PrintableMock::Property.new('personName')
    id_property   = Test::PrintableMock::Property.new('objectId')
    irrelevant    = Test::PrintableMock::Property.new('irrelevant')
  
    mock = Test::PrintableMock.new
    mock.add_property(name_property)    
    mock.add_property(irrelevant)    
    mock.add_property(id_property)
    
    mock.objectId = 12345
    mock.personName = 'Homer Simpson'
  
    assert mock.relevant_properties.size == 2
    assert mock.relevant_properties.include?(id_property)
    assert mock.relevant_properties.include?(name_property)    

    assert mock.to_s =~ /objectId = 12345/
    assert mock.to_s =~ /personName = 'Homer Simpson'/    
  end
end
