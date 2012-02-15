require 'ostruct'
require 'base_unit'
include RMOF


# Test parsing of ecore files.
class ParseEcoreTest < Test::Unit::TestCase
  ECORE_FILE         = File.join(RMOF::Config::MODELS_ROOT, 'Ecore.ecore')
  XMLTYPE_FILE       = File.join(RMOF::Config::MODELS_ROOT, 'XMLType.ecore')

  def test_ecore_parsing_at_package_level
    adapter = RMOF::ECore::FileModelAdapter.new
    results = ECoreParser.new(File.new(ECORE_FILE), adapter).parse().root_elements
    
    assert_equal 1, results.size
    package = results.first
    assert_equal ECore::EPackage, package.class
    assert_equal 'http://www.eclipse.org/emf/2002/Ecore', package.nsURI    
    assert_equal 'ecore', package.nsPrefix
  end

  def test_ecore_parsing
    #results = ECoreParser.new(File.new(ECORE_FILE), BootstrapParseModel.new).parse()
    adapter = RMOF::ECore::FileModelAdapter.new
    results = ECoreParser.new(File.new(RMOF::ECore::FileModelAdapter::ECORE_FILE), adapter).parse()
    results = results.root_elements
    
    assert_equal 1, results.size
    package = results.first

    assert_equal 32 + 18, package.eClassifiers.size # check if all classifiers are parsed
    assert_equal 18, package.eClasses.size   # check if all classifiers are parsed
    assert_equal 32, package.eDataTypes.size # check if all classifiers are parsed

    # test some supertypes
    eattribute = package.eClassifiers.select { |e| e.name == 'EAttribute' }.first
    estructural_feature = package.eClassifiers.select { |e| e.name == 'EStructuralFeature' }.first

    assert_equal 1, eattribute.eSuperTypes.size
    assert_equal [estructural_feature], eattribute.eSuperTypes    
  end
  
  # This is a nice test case, since EStringToStringMapEntry does not
  # inherit from anything, so its superclass is EObject, which
  # provides the eSet/eGet method.
  def test_estring_to_map_entry
    entry = ECore::EStringToStringMapEntry.new
    entry.set('value', 'thing')
    
    assert_equal 'thing', entry.get('value')
  end

  def test_specific_parsing
    require 'rmof/meta/ecore/specific_parser'
    parser = ECore::SpecificParser.new(File.new(ECORE_FILE))

    package = parser.parse    
    assert_equal 'ecore', package.name
    assert_equal 'http://www.eclipse.org/emf/2002/Ecore', package.nsURI    
    assert_equal 'ecore', package.nsPrefix
    assert_equal 32 + 18, package.eClassifiers.size # check if all classifiers are parsed
    assert_equal 18, package.eClasses.size   # check if all classifiers are parsed
    assert_equal 32, package.eDataTypes.size # check if all classifiers are parsed
    
      
    # test some supertypes
    eattribute = package.eClassifiers.select { |e| e.name == 'EAttribute' }.first
    estructural_feature = package.eClassifiers.select { |e| e.name == 'EStructuralFeature' }.first

    assert_equal [estructural_feature], eattribute.eSuperTypes
  end

  def test_ecore_library
    adapter = RMOF::ECore::FileModelAdapter.new
    model   = ECoreParser.new(File.new(LIBRARY_FILE), adapter).parse()
    # model = ECoreParser.new(File.new(LIBRARY_FILE), BootstrapParseModel.new).parse()
    package = model.root_elements.first
    
    assert_equal 1, model.root_elements.size
    assert_equal ECore::EPackage, package.class
    assert_equal 'library', package.name
    assert_equal 'library', package.nsPrefix
    assert_equal 'http://www.example.eclipse.org/Library', package.nsURI
    
    assert_equal 5, package.eClassifiers.size
    assert_equal 3, package.eClassifiers.select { |c| c.class == ECore::EClass }.size
    assert_equal 1, package.eClassifiers.select { |c| c.class == ECore::EDataType }.size
    assert_equal 1, package.eClassifiers.select { |c| c.class == ECore::EEnum }.size
  
    book = package.eClassifiers.select { |c| c.name == 'Book' }.first
    writer = package.eClassifiers.select { |c| c.name == 'Writer' }.first
    library = package.eClassifiers.select { |c| c.name == 'Library' }.first
  
    assert_equal 4, book.eStructuralFeatures.size
    assert_equal 2, writer.eStructuralFeatures.size
    assert_equal 3, library.eStructuralFeatures.size

    name_attribute = library.getEStructuralFeature('name')
    assert_not_nil name_attribute.eType
    # author_reference = book.getEStructuralFeature('author')
    # TODO: Add getEStructuralFeature to EClass objects
  end

  def test_xml_type
    adapter = RMOF::ECore::FileModelAdapter.new
    model   = ECoreParser.new(File.new(XMLTYPE_FILE), adapter).parse()
  end

  def test_parse_library_model
    adapter = RMOF::ECore::FileModelAdapter.new
    # adapter.add_mapping('http://www.example.eclipse.org/Library', LIBRARY_FILE)
    model   = ECoreParser.new(File.new(LIBRARY_MODEL_FILE), adapter).parse()
    
    library = model.root_elements.first
    
    assert_not_nil library
    assert_equal 1, model.root_elements.size
    assert_equal 'TestLibrary', library.name

    assert_equal 3, library.writers.size
    assert_equal 3, library.books.size
    
    godfather = library.books.select { |book| book.title == 'The Godfather' }.first
    puzo      = library.writers.select { |writer| writer.name == 'Mario Puzo' }.first
    assert_not_nil godfather
    assert_not_nil puzo
    assert_equal puzo, godfather.author
    assert puzo.books.include?(godfather)
  end
  
  def test_reference_uri_fragments
    package   = ECore::EPackage.new(:name => 'TestPackage')
    eclass    = ECore::EClass.new(:name => 'TestClass')
    reference = ECore::EReference.new(:name => 'testReference') 
    package.eClassifiers << eclass
    eclass.eStructuralFeatures << reference

    assert_equal '#//TestClass', eclass.compute_uri_fragment    
    assert_equal '#//TestClass/testReference', reference.compute_uri_fragment
    assert_equal '#/', package.compute_uri_fragment

  end
  
  def test_kind_of
    adapter = RMOF::ECore::FileModelAdapter.new
    model   = ECoreParser.new(File.new(LIBRARY_FILE), adapter).parse()
    package = model.root_elements.first    
    
    assert_equal 2, package.eClassifiers.select { |c| c.isInstanceOf(ECore::EDataType) }.size
  end
 
  def test_load_UML   
    adapter = RMOF::ECore::FileModelAdapter.new
    model = nil
    
    require 'benchmark'
    Benchmark.bm do |x|
      x.report { model = ECoreParser.new(File.new(UML_FILE), adapter).parse() }
     #adapter.add_mapping('http://www.eclipse.org/uml2/1.0.0/UML', UML_FILE)
    end
    
    package = model.root_elements.first   
    classifier = classifier(package, 'Classifier')
    assert_equal 12, classifier.eReferences.size
    reference  = reference(classifier, 'generalization')
    
    klass      = classifier(package, 'Class')
    assert  klass.all_super_types.include?(classifier)
    reference  = klass.getEStructuralFeature('generalization')
    assert_not_nil reference

    named_element = classifier(package, 'NamedElement')
    assert_not_nil named_element.getEStructuralFeature('name')    

    namespace     = classifier(package, 'Namespace')
    assert namespace.all_super_types.include?(named_element)

    uml_package     = classifier(package, 'Package')
    assert uml_package.all_super_types.include?(namespace)

    model     = classifier(package, 'Model')
    assert model.all_super_types.include?(namespace)
    assert model.all_super_types.include?(named_element)
    attribute = model.getEStructuralFeature('name')    
    
    # Test loading a model, and try to improve performance
    Benchmark.bm do |x|
      x.report { model = ECoreParser.new(File.new(UML_MODEL_FILE), adapter).parse() }
    end
    
  end

  def test_load_metamodel_school_reference_library
    adapter = RMOF::ECore::FileModelAdapter.new
    adapter.add_mapping('Library.ecore', LIBRARY_FILE)
    
    model   = ECoreParser.new(File.new(SCHOOL_FILE), adapter).parse()    
    package = model.root_elements.first   
    
    assert_equal 2, package.eClassifiers.size 
    school = package.eClassifiers[0]
    pupil  = package.eClassifiers[1]
    
    assert_equal 2, pupil.eStructuralFeatures.size
    # assert_equal 1, pupil.eReferences.size
    # it should hold
    books = pupil.eStructuralFeatures[0]
    assert_equal 'Book', books.eType.name
    assert books.owning_model != books.eType.owning_model
  end
  
  def test_load_model_school_reference_library
    adapter = RMOF::ECore::FileModelAdapter.new
    #adapter.add_mapping('Library.ecore', LIBRARY_FILE)
    #adapter.add_mapping('http://www.example.eclipse.org/Library', LIBRARY_FILE)
    #adapter.add_mapping('Library.xmi', LIBRARY_MODEL_FILE)
    #adapter.add_mapping('http://test.rmof/school', SCHOOL_FILE)
    
    model   = ECoreParser.new(File.new(SCHOOL_MODEL_FILE), adapter).parse()    
    school  = model.root_elements.first   
  
    assert_equal 2, school.pupils.size
    vito      = school.pupils[0]
    buttercup = school.pupils[1]
  
    assert_equal 2, vito.readBooks.size 
    assert_equal 1, buttercup.readBooks.size

    assert vito.owning_model != vito.readBooks[0].owning_model
    assert vito.owning_model != vito.readBooks[1].owning_model
    assert buttercup.owning_model != buttercup.readBooks[0].owning_model

    assert_equal 6, model.objects.size
  end
  
  def test_load_bpmn_file
    adapter = RMOF::ECore::FileModelAdapter.new
    model   = ECoreParser.new(File.new(BPMN_FILE), adapter).parse()
  
    assert model.root_elements.size == 1
  end
  
  # This test tries to clarify why the 'name' attribute is not properly inherited
  # by the Parameter class
  def test_regression_javam
    adapter = RMOF::ECore::FileModelAdapter.new
    model   = ECoreParser.new(File.new(JAVAM_FILE), adapter).parse()
    
    parameter = model.root_elements.first.eClassifiers.select { |c| c.name == 'Parameter' }.first
    assert_not_nil parameter
    assert_not_nil parameter.eAllStructuralFeatures.select { |f| f.name == 'name' }.first
    
    parameter.getEStructuralFeature('name')    
  end
  
  def test_parse_owl
    adapter = RMOF::ECore::FileModelAdapter.new
    model   = ECoreParser.new(File.new(OWL_FILE), adapter).parse()
    
    owl_package = model.root_elements.first
    rdf_package = adapter.resolve_uri('rdfs.ecore', OWL_FILE).root_elements.first

    # Test that a reference from owl.ecore -> rdfs.ecore works    
    owl_class = classifier(owl_package, 'OWLClass')
    rdf_class = classifier(rdf_package, 'RDFSClass')
    
    assert_equal 1, owl_class.eSuperTypes.size    
    assert_equal rdf_class, owl_class.eSuperTypes.first

    # Test that a reference from rdfs.ecore -> owl.ecore
    rdf_refByAVFRestriction = reference(rdf_class, 'refByAVFRestriction')
    owl_AllValuesFromRestriction = classifier(owl_package, 'AllValuesFromRestriction')
    owl_OWLAllValuesFrom = reference(owl_AllValuesFromRestriction, 'OWLAllValuesFrom')
    
    assert_equal owl_AllValuesFromRestriction, rdf_refByAVFRestriction.eType
    assert_equal owl_OWLAllValuesFrom, rdf_refByAVFRestriction.eOpposite
  end

  def test_parse_rdfs
    # In the other way around?
    adapter = RMOF::ECore::FileModelAdapter.new
    model   = ECoreParser.new(File.new(RDFS_FILE), adapter).parse()
  end
  # TODO: Test some UML and OWL models. In particular, test if opposites are ok handled.

  def test_load_generated_UML   
    repository = RMOF::CacheRepository.new(RMOF::Config::CACHE_DIR)
    package = repository.load_metamodel('http://www.eclipse.org/uml2/1.0.0/UML').root_elements.first
   
    #package = model.root_elements.first   
    classifier = classifier(package, 'Classifier')    
    reference  = reference(classifier, 'generalization')
    
    klass      = classifier(package, 'Class')
    assert  klass.all_super_types.include?(classifier)
    reference  = klass.getEStructuralFeature('generalization')
    assert_not_nil reference
    reference  = klass.getEStructuralFeature('ownedAttribute')
    assert_not_nil reference

    named_element = classifier(package, 'NamedElement')
    assert_not_nil named_element.getEStructuralFeature('name')    

    namespace     = classifier(package, 'Namespace')
    assert namespace.all_super_types.include?(named_element)

    uml_package     = classifier(package, 'Package')
    assert uml_package.all_super_types.include?(namespace)

    model     = classifier(package, 'Model')
    assert model.all_super_types.include?(namespace)
    assert model.all_super_types.include?(named_element)
    attribute = model.getEStructuralFeature('name')    
    
    # Test loading a model, and try to improve performance
    require 'benchmark'
    Benchmark.bm do |x|
      adapter = RMOF::ECore::FileModelAdapter.new
      x.report { model = ECoreParser.new(File.new(UML_MODEL_FILE), adapter).parse() }
    end
    
  end

  # Test that xsi:type is properly splited.
  def test_split_type
    regexp = ECoreParser::SPLIT_TYPE
    
    regexp =~ 'ecore:EClass'
    assert_equal 'ecore', $1
    assert_equal 'EClass', $2
    
    regexp =~ 'package.prefix:AMetaclass'
    assert_equal 'package.prefix', $1
    assert_equal 'AMetaclass', $2
    
    regexp =~ 'package_prefix:mymetaclass'
    assert_equal 'package_prefix', $1
    assert_equal 'mymetaclass', $2

    regexp =~ '1234abcABC:1234abcABC'
    assert_equal '1234abcABC', $1
    assert_equal '1234abcABC', $2
    
    
    # = /([a-zA-Z0-9._]+):(\w+)/
  end

  def test_match_references    
    regex = ECoreParser::MATCH_REFERENCE
    # $1 -> concrete_type, 
    # $2 -> model_uri
    # $3 -> fragment path
    
    #regex =~ 'pathmap://UML2_LIBRARIES/JavaPrimitiveTypes.library.uml2'

    # Metamodel paths
    regex =~ '#//MyMetaclass'    
    assert_equal nil, $1
    assert_equal nil, $3
    assert_equal '//MyMetaclass', $4
    
    # Datatype uris
    regex =~ 'ecore:EDataType http://www.eclipse.org/emf/2003/XMLType#//String'
    assert_equal 'ecore:EDataType ', $1
    assert_equal 'http://www.eclipse.org/emf/2003/XMLType', $3
    assert_equal '//String', $4
    
    # Simple model paths
    regex =~ "Library.xmi#//@books.2"
    assert_equal nil, $1
    assert_equal 'Library.xmi', $3
    assert_equal '//@books.2', $4   

    # This does not work, should it?
    # "pathmap://UML2_LIBRARIES/JavaPrimitiveTypes.library.uml2#_RjmyoK86EdieaYgxtVWN8Q"

    # This test a model path that contain spaces
    regex =~ "C:\\Document and Settings\\ptb\\Escritorio\\rdfs.ecore#//Ontology"
    assert_equal nil, $1
    assert_equal 'C:\\Document and Settings\\ptb\\Escritorio\\rdfs.ecore', $3
    assert_equal '//Ontology', $4 
    
    # Test a path that is a reference to the root package
    regex =~ "../execution-examples/ClassM.ecore#/"
    assert_equal nil, $1
    assert_equal '../execution-examples/ClassM.ecore', $3
    assert_equal '/', $4 
  end

  #
  #
  def test_parse_metamodel_with_xmi_top_level_element
    adapter = RMOF::ECore::FileModelAdapter.new
    model = ECoreParser.new(File.new(UML_ZOO_FILE), adapter).parse()  
    
    assert_equal 2, model.root_elements.size
  end


  # This test ensures that subpackages and references between subpackages are
  # properly read.
  def test_parse_subpackages
    adapter = RMOF::ECore::FileModelAdapter.new
    model = ECoreParser.new(File.new(SUBPACKAGES_FILE), adapter).parse()  
    
    assert_equal 1, model.root_elements.size
    package = model.root_elements.first
    mainclass = classifier(package, "ClassInMainPackage")
    
    assert_equal 2, package.eSubpackages.size
    subpackage = package.eSubpackages.first    
    subpkgclass = classifier(subpackage, "ClassInSubpackage")
    referencingclass = classifier(subpackage, "ReferencingClassInSubpackage")
    
    ref = reference(referencingclass, "classInSubpackage")
    assert_equal subpkgclass, ref.type
    
  end
  
  # TODO: This probably should go in another file
  def test_model_as_fragment
    adapter = RMOF::ECore::FileModelAdapter.new
    model = ECoreParser.new(File.new(SUBPACKAGES_FILE), adapter).parse()  

    assert_raise(RMOF::FragmentNotFound) {
      model.fragment_as_model('//inexistent_package')
    }
    assert model.fragment_as_model('//Subpackage') != nil    
  
    assert_raise(RMOF::FragmentNotFound) {
     ECORE_METAMODEL.fragment_as_model('//inexistent_package') 
    }
  end
  
  def test_parse_subpackages_in_a_model
    adapter   = RMOF::ECore::FileModelAdapter.new
    model     = ECoreParser.new(File.new(SUBPACKAGES_MODEL), adapter).parse()  
    metamodel_pkg = adapter.resolve_uri('http://rmof/test/package').root_elements.first
    sub_pkg   = package(metamodel_pkg, 'Subpackage')
  
    root = model.root_elements.first
        
    assert_equal classifier(metamodel_pkg, 'ClassInMainPackage'), root.metaclass

    c1 = root.elementsInSubpackages[0]
    c2 = root.elementsInSubpackages[1]
    
    assert_equal classifier(sub_pkg, 'ReferencingClassInSubpackage'), c1.metaclass
    assert_equal classifier(sub_pkg, 'ReferencingClassInSubpackage'), c2.metaclass
    
    assert_equal 'class1', c1.name
    assert_equal c2, c1.classInSubpackage
    assert_equal 'class2', c2.name        
  end

  def test_referenced_models
    adapter = RMOF::ECore::FileModelAdapter.new
    school_model      = ECoreParser.new(File.new(SCHOOL_MODEL_FILE), adapter).parse()
    school_metamodel  = adapter.loaded_get(SCHOOL_FILE)
    library_model     = adapter.loaded_get(LIBRARY_MODEL_FILE)
    library_metamodel = adapter.loaded_get(LIBRARY_FILE)

    assert school_model.referenced_models.include?(library_model)
    assert school_model.referenced_models.include?(school_metamodel) 
    assert_equal 2, school_model.referenced_models.size
    
    assert school_metamodel.referenced_models.include?(library_metamodel)
    assert_equal 2, school_metamodel.referenced_models.size
  end


  def test_parsing_annotations
    adapter = RMOF::ECore::FileModelAdapter.new
    model = nil
    
    require 'benchmark'
    Benchmark.bm do |x|
      x.report { model = ECoreParser.new(File.new(File.join(TEST_MODELS_ROOT, 'AnnotatedMetamodel.ecore')), adapter).parse() }
     #adapter.add_mapping('http://www.eclipse.org/uml2/1.0.0/UML', UML_FILE)
    end
  end

  def test_datatypes
    adapter = RMOF::ECore::FileModelAdapter.new
    adapter.add_mapping('Datatypes.ecore', DATATYPES_FILE)
    
    model   = ECoreParser.new(File.new(DATATYPES_MODEL), adapter).parse()    
    root = model.root_elements.first    
    
    assert_equal 3, root.strings.size
    assert_equal "String number one", root.strings[0]
    assert_equal "String number two", root.strings[1]
    assert_equal "String number three", root.strings[2]

    assert_equal 2, root.integers.size
    assert_equal 22, root.integers[0]
    assert_equal 33, root.integers[1]
    
    assert_not_nil root.test
    assert_equal 'testWrong', root.test.name
  end

  def test_id_attributes
    adapter = RMOF::ECore::FileModelAdapter.new
    adapter.add_mapping('IDs.ecore', IDS_FILE)
    
    model   = ECoreParser.new(File.new(IDS_MODEL), adapter).parse()    
    root = model.root_elements.first    
    
    assert_equal 4, root.objects.size
    assert_equal root.objects.find { |o| o.idValue == 1 }, root.mostImportant
    
    # TODO: Test multivalued referenced to ID objects
  end

private
  def package(package, subpkg_name)
    pkg = package.eSubpackages.select { |c| c.name == subpkg_name }.first
    assert_not_nil pkg
    pkg
  end  

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
