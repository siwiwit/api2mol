require 'rubytl_base_unit'

class HandlerRMOF2Test < Test::Unit::TestCase
  include RubyTL
  include RubyTL::Base  
  include RubyTL::Mock

  def setup
    @config = RubyTL::Base::Configuration.new
    @model_info_1 = ModelInformation.new('MM1', Resource.new('/tmp/mm.ecore'), Resource.new('/tmp/m.xmi'))
    @model_info_2 = ModelInformation.new('MM2', Resource.new('http://uri.not/registered'), Resource.new('/tmp/m.xmi'))
    @model_info_ecore = ModelInformation.new('MM2', Resource.new('http://www.eclipse.org/emf/2002/Ecore'), Resource.new('/tmp/result.ecore'))
  end

  def test_support
    handler = HandlerRMOF2.new(@config)
    
    assert handler.support?(@model_info_1)    
    assert ! handler.support?(@model_info_2)    
    assert handler.support?(@model_info_ecore)
  end
  
  def test_load_metamodel
    handler = HandlerRMOF2.new(@config)
    model_information = RubyTL::TestFiles.library_source_model
    metamodel = handler.send(:load_metamodel, model_information.metamodel)
  
    assert_not_nil metamodel
  end
  
  def test_load
    handler = HandlerRMOF2.new(@config)
    library_model = RubyTL::TestFiles.library_source_model
    result = handler.load(library_model)
    
    assert result.kind_of?(LoadedModel)
    assert_equal library_model, result.model_information
    assert result.proxy.kind_of?(ModelProxyMixin)
    
    assert_equal 'Library', result.proxy.package_name
  end

  # This is a regression test, to ensure that subclasses in differente
  # subpackages are properly resolved
  def test_load_with_subclasses_in_differente_subpackages
puts "test"
        handler = HandlerRMOF2.new(@config)
    package_model = RubyTL::TestFiles.package_model
    result = handler.load(package_model)
    
    assert result.kind_of?(LoadedModel)
    assert_equal package_model, result.model_information
    assert result.proxy.kind_of?(ModelProxyMixin)
    
    
    assert_equal 2, result.proxy::Subpackage::InheritingClass.all_objects.size
    assert_equal 3, result.proxy::ClassInMainPackage.all_objects.size
  end
  
  
  def test_new_model
    handler = HandlerRMOF2.new(@config)
    memory_model = RubyTL::TestFiles.relational_target_model

    result = handler.new_model(memory_model)    

    assert result.kind_of?(LoadedModel)
    assert_equal memory_model, result.model_information
    assert result.proxy.kind_of?(ModelProxyMixin)

    assert_equal 'TableM', result.proxy.package_name
  end

  def test_rumi_support
    eclass = ECore::EClass.new
    eclass.name = 'MyEClass'
  
    eref = ECore::EReference.new
    eref.eType = eclass
    
    assert_equal eclass, eref.rumi_type
    
    # TODO: Rumi_kind_of? at instance level...
    # TODO: Test with a the class proxy instead of directly loading the model
    handler = HandlerRMOF2.new(@config)
    library_model = RubyTL::TestFiles.class_source_model
    proxy = handler.load(library_model).proxy

    proxy::PrimitiveType.all_objects.each do |ptype|
      assert   ptype.kind_of?(proxy::PrimitiveType)      
      assert   ptype.respond_to?(:name)
      assert ! ptype.respond_to?(:inexistent_property)
    end
    
    ptype = proxy::PrimitiveType.new
    assert   ptype.respond_to?(:name)
    assert ! ptype.respond_to?(:inexistent_property)
    
    assert_equal 2, proxy::Class.rumi_all_properties.size
  end

  def test_decorator_in_source_model
    handler = HandlerRMOF2.new(@config)
    library_model = RubyTL::TestFiles.class_source_model
    proxy = handler.load(library_model).proxy

    proxy::Classifier.decorate(Proc.new do
      def test_decorate_in_classifier
        "ok"
      end
    end)

    proxy::Class.decorate(Proc.new do
      def test_decorate_in_class
        "ok"
      end

      def test_decorate_in_classifier
        "class ok"
      end
    end)

    assert_equal "ok", proxy::Class.all_objects.first.test_decorate_in_class
    assert_raise(RMOF::FeatureNotExist) {
      proxy::PrimitiveType.all_objects.first.test_decorate_in_class
    }

    assert_equal "ok", proxy::PrimitiveType.all_objects.first.test_decorate_in_classifier
    assert_equal "class ok", proxy::Class.all_objects.first.test_decorate_in_classifier  
  
    # This is regression test. In a hierarchy such as Element <- Node <- Tree,
    # a decorator in Tree should not be used in Node.
    handler = HandlerRMOF2.new(@config)
    cst_model = RubyTL::TestFiles.cst_model
    proxy = handler.load(cst_model).proxy    

    proxy::Tree.decorate(Proc.new do
      def nodes
        self.children.select { |n| n.metaclass.name == 'Node' }
      end
    end)
    
    assert_raise(RMOF::FeatureNotExist) {
      proxy::Node.all_objects.first.nodes
    }    
    
    # Test that decorators are added in cross-referenced classes
  end  

=begin
  # Test is a transformation is able to properly load an input model
  def test_loading_bpmn_source_with_rmof_handler2

    repository = RubyTL::Repository.new(RubyTL::HandlerRMOF2.new, TestURIResolver.new)
    assert repository.metamodel?("file://#{files_dir}/metamodels/BPMN.ecore") == true

    assert repository.metamodel("file://#{files_dir}/metamodels/BPMN.ecore").kind_of?(Module)
    assert repository.metamodel("file://#{files_dir}/metamodels/BPMN.ecore").name == 'Bpmn'
    
    model_proxy = repository.model("file://#{files_dir}/models/bpmn.rb",
                                   "file://#{files_dir}/metamodels/BPMN.ecore")
    
    activities = model_proxy.all_objects_of(model_proxy::Activity)

    assert_equal 2, activities.size
    # TODO: Further testing: complete the test model
  end

  # Test is a transformation is able to properly load an input model
  # It performs the following tests:
  # * The model and metamodel are properly loaded
  # * ConcreteType.all_objects returns the correct values
  # * AbstractType.all_objects also returns instances of the subclasses
  #
  def test_loading_a_source_with_rmof_handler2
    repository = RubyTL::Repository.new(RubyTL::HandlerRMOF2.new, TestURIResolver.new)

    assert repository.metamodel?("file://#{files_dir}/class2java/ClassM.ecore") == true
    assert repository.metamodel?("file://#{files_dir}/class2java/Class.ecore")  == false

    assert repository.metamodel("file://#{files_dir}/class2java/ClassM.ecore").kind_of?(Module)
    assert repository.metamodel("file://#{files_dir}/class2java/ClassM.ecore").name == 'ClassM'    
    model_proxy = repository.model("file://#{files_dir}/class2java/class-source.rb",
                                   "file://#{files_dir}/class2java/ClassM.ecore")
    
    klasses = model_proxy.all_objects_of(model_proxy::Class)
    attrs   = model_proxy.all_objects_of(model_proxy::Attribute)
    ptypes  = model_proxy.all_objects_of(model_proxy::PrimitiveType)
    
    assert_equal 3, klasses.size
    assert_equal 3, ptypes.size
    assert_equal 7, attrs.size    
    
    assert_equal 1, klasses.select { |k| k.name == 'Trabajo' }.size
    assert_equal 1, klasses.select { |k| k.name == 'Mascota' }.size
    assert_equal 1, klasses.select { |k| k.name == 'Persona' }.size        
    
    person = klasses.select { |k| k.name == 'Persona' }.first
    job    = klasses.select { |k| k.name == 'Trabajo' }.first

    assert_equal 4, person.attrs.size
    assert_equal 2, job.attrs.size    

    # The number of objects of a superclass such as Classifier, should
    # include all instances of the subclasses
    classifiers  = model_proxy.all_objects_of(model_proxy::Classifier)
    assert_equal 6, classifiers.size 
    assert_equal 1, classifiers.select { |k| k.name == 'Trabajo' }.size
    assert_equal 1, classifiers.select { |k| k.name == 'Mascota' }.size
    assert_equal 1, classifiers.select { |k| k.name == 'Persona' }.size        
    assert_equal 1, classifiers.select { |k| k.name == 'Integer' }.size  
    assert_equal 1, classifiers.select { |k| k.name == 'String' }.size  
    assert_equal 1, classifiers.select { |k| k.name == 'Boolean' }.size  
  end

  # Test is a transformation is able to properly load an input model
  def test_kind_of_stuff
    repository  = RubyTL::Repository.new(RubyTL::HandlerRMOF2.new, TestURIResolver.new)
    model_proxy = repository.new_model("file://#{files_dir}/class2java/ClassM.ecore")

    aKlass = model_proxy::Class.new
    assert aKlass.kind_of?(model_proxy::Class)
    assert aKlass.kind_of?(model_proxy::Classifier)
  end
  
  # Test if decoration is properly implemented
  def test_decoration
    repository  = RubyTL::Repository.new(RubyTL::HandlerRMOF2.new, TestURIResolver.new)
    model_proxy = repository.new_model("file://#{files_dir}/class2java/ClassM.ecore")

    model_proxy::Classifier.decorate(Proc.new do
      def test_decorate_in_classifier
        "ok"
      end
    end)

    model_proxy::Class.decorate(Proc.new do
      def test_decorate_in_class
        "ok"
      end

      def test_decorate_in_classifier
        "class ok"
      end
    end)

    assert_equal "ok", model_proxy::Class.new.test_decorate_in_class
    assert_raise(RMOF::FeatureNotExist) {
      model_proxy::PrimitiveType.new.test_decorate_in_class
    }

    assert_equal "ok", model_proxy::PrimitiveType.new.test_decorate_in_classifier
    assert_equal "class ok", model_proxy::Class.new.test_decorate_in_classifier
  end
  
  def test_decoration_loaded_models
    repository = RubyTL::Repository.new(RubyTL::HandlerRMOF2.new, TestURIResolver.new)

    assert repository.metamodel("file://#{files_dir}/metamodels/ClassM.ecore").name == 'ClassM'    
    model_proxy = repository.model("file://#{files_dir}/models/class_model.ecore.xmi",
                                   "file://#{files_dir}/metamodels/ClassM.ecore")

    model_proxy::Classifier.decorate(Proc.new do
      def test_decorate_in_classifier
        "ok"
      end
    end)

    model_proxy::Class.decorate(Proc.new do
      def test_decorate_in_class
        "ok"
      end

      def test_decorate_in_classifier
        "class ok"
      end
    end)

    assert_equal "ok", model_proxy::Class.all_objects.first.test_decorate_in_class
    assert_raise(RMOF::FeatureNotExist) {
      model_proxy::PrimitiveType.all_objects.first.test_decorate_in_class
    }

    assert_equal "ok", model_proxy::PrimitiveType.all_objects.first.test_decorate_in_classifier
    assert_equal "class ok", model_proxy::Class.all_objects.first.test_decorate_in_classifier
  
  end

  def test_resolving_subpackages
    repository = RubyTL::Repository.new(RubyTL::HandlerRMOF2.new, TestURIResolver.new)

    model_proxy = repository.new_model("file://#{files_dir}/metamodels/Packages.ecore")

    assert model_proxy::ClassInMainPackage
    assert model_proxy::Subpackage
    assert model_proxy::Subpackage::ClassInSubpackage

    model_proxy::ClassInMainPackage.new
    model_proxy::ClassInMainPackage.new
    model_proxy::Subpackage::ClassInSubpackage.new

    assert_equal 2, model_proxy::ClassInMainPackage.all_objects.size
    assert_equal 1, model_proxy::Subpackage::ClassInSubpackage.all_objects.size
    assert_equal 3, model_proxy.collect_root_objects.size
  end
  
  def test_loading_referenced_models_when_target
    repository = RubyTL::Repository.new(RubyTL::HandlerRMOF2.new, TestURIResolver.new)

    model_proxy = repository.new_model("file://#{files_dir}/metamodels/School.ecore")  
    model_proxy.modify_assignments_for_binding_semantics { "test_semantics" }
    library_proxy = model_proxy.referenced_pkg('library')

    assert library_proxy.class == Module
    assert library_proxy != nil    
    assert_equal 'Book', library_proxy::Book.new.metaclass.name

    # Create an object that is a subclass of Book, the instance should be properly
    # added to the list of existing Book objects.
    model_proxy::SpecialBook.new    
    assert_equal 2, library_proxy::Book.all_objects.size

    # TODO: Try SERIALIZATION of created objects
  end
  
  def test_loading_referenced_models_when_source
    repository = RubyTL::Repository.new(RubyTL::HandlerRMOF2.new, TestURIResolver.new)    
    model_proxy = repository.model("file://#{files_dir}/models/school2.ecore.xmi",
                                   "file://#{files_dir}/metamodels/School.ecore")
    model_proxy.modify_assignments_for_binding_semantics { "test_semantics" }
    library_proxy = model_proxy.referenced_pkg('library')
    
    assert_equal 3, library_proxy::Book.all_objects.size
    assert_equal 2, library_proxy::Library.all_objects.size
    assert_equal 5, library_proxy::Writer.all_objects.size
    
    # TODO: Test bindings are set
  end  

  def test_decorators_with_referenced_models_when_source
    repository = RubyTL::Repository.new(RubyTL::HandlerRMOF2.new, TestURIResolver.new)    
    model_proxy = repository.model("file://#{files_dir}/models/school.ecore.xmi",
                                   "file://#{files_dir}/metamodels/School.ecore")
    model_proxy.modify_assignments_for_binding_semantics { "test_semantics" }
    library_proxy = model_proxy.referenced_pkg('library')

    library_proxy::Book.decorate(Proc.new do
      def test_decorate_in_referenced_class
        "ok"
      end
    end)    
    
    library_proxy::Book.all_objects.each do |book|
      assert_equal 'ok', book.test_decorate_in_referenced_class
    end
  end    

=end
end
