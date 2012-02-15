require 'base_unit'
include RMOF


# Test parsing of ecore files.
class ParseEMOFTest < Test::Unit::TestCase
  
  def test_mof_definition_of_uml2_using_ecore_metamodel
    repository = RMOF::CacheRepository.new(RMOF::Config::CACHE_DIR)
    repository.load_metamodel('http://www.eclipse.org/emf/2002/Ecore') 
        
    adapter = RMOF::ECore::FileModelAdapter.new
    model   = RMOF::ECoreParser.new(File.new(UML_FILE), adapter).parse() 
    adapter.add_mapping('http://www.eclipse.org/uml2/1.0.0/UML', UML_FILE)
    model   = RMOF::EMofParser.new(File.new(SMALL_UML_MODEL), adapter).parse()    
  end

  def test_match_references    
    emofparser = Class.new(EMofParser) do
      def initialize; end
    end
    parser = emofparser.new
    # $1 -> concrete_type, 
    # $2 -> model_uri
    # $3 -> fragment path
    
    # Simple model paths
    concrete_type, model_uri, path = parser.match_reference("pathmap://UML2_LIBRARIES/JavaPrimitiveTypes.library.uml2#_RjmyoK86EdieaYgxtVWN8Q")
    assert_equal nil, concrete_type
    assert_equal 'pathmap://UML2_LIBRARIES/JavaPrimitiveTypes.library.uml2', model_uri
    assert_equal '_RjmyoK86EdieaYgxtVWN8Q', path

    concrete_type, model_uri, path = parser.match_reference('_0UlOQ7QqEduLKbKp0g28zA')
    assert_equal nil, concrete_type
    assert_equal nil, model_uri
    assert_equal '_0UlOQ7QqEduLKbKp0g28zA', path
  end


private
  def classifier(package, classifier_name)
    classifier = package.eClassifiers.select { |c| c.non_qualified_name == classifier_name }.first
    assert_not_nil classifier
    classifier
  end  
  
  def reference(klass, reference_name)
    reference = klass.eStructuralFeatures.select { |r| r.name == reference_name }.first
    assert_not_nil reference
    assert reference.kind_of?(ECore::EReference)
    reference
  end

  def attribute(klass, attribute_name)
    attribute = klass.eStructuralFeatures.select { |r| r.name == attribute_name }.first
    assert_not_nil attribute
    assert attribute.kind_of?(ECore::EAttribute)
    attribute
  end

end
