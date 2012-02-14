require 'rubytl_base_unit'

class RepositoryTest < Test::Unit::TestCase
  include RubyTL::Base
  include RubyTL::Mock

  def setup
    @model_info_1 = ModelInformation.new('MM1', Resource.new('/tmp/mm.handler1'), Resource.new('/tmp/m.handler1'))
    @model_info_2 = ModelInformation.new('MM2', Resource.new('/tmp/mm.handler2'), Resource.new('/tmp/m.handler2'))
    @model_info_invalid = ModelInformation.new('MMInvalid', Resource.new('/tmp/mm.invalid'), Resource.new('/tmp/m.invalid'))
  end

  def test_model_information
    inf = ModelInformation.new('namespace', Resource.new('/tmp'), Resource.new('/tmp/model'))
    assert_equal 'Namespace', inf.namespace
  end

  def test_loaded_model
    fail("TODO: test_loaded_model")
  end

  def test_repository_load_source_model
    handler1 = TestHandler.new('handler1')
    handler2 = TestHandler.new('handler2')
    repository = Repository.new([handler1, handler2])
    
    loaded_model = repository.load_source_model(@model_info_1)
    assert loaded_model.kind_of?(LoadedModel)
    assert loaded_model.model_information == @model_info_1
    
    assert_raise(NoHandlerError) {
      repository.load_source_model(@model_info_invalid)
    }        
  end

  def test_repository_load_target_model
    handler1 = TestHandler.new('handler1')
    handler2 = TestHandler.new('handler2')
    repository = Repository.new([handler1, handler2])
    
    loaded_model = repository.load_target_model(@model_info_2, :none)
    assert loaded_model.kind_of?(LoadedModel)
    assert loaded_model.model_information == @model_info_2

    
    # Repository in-place mock
    class << repository
      attr_accessor :backup_used
      def backup_target_model(model_information)
        @backup_used ||= 0
        self.backup_used += 1 
      end
    end
    
    loaded_model = repository.load_target_model(@model_info_2, :backup)
    assert loaded_model.kind_of?(LoadedModel)
    assert loaded_model.model_information == @model_info_2
    assert_equal 1, repository.backup_used

    assert_raise(NoHandlerError) {
      repository.load_target_model(@model_info_invalid)
    }        

    # TODO: Test incremental consistency mode
  end


=begin
# CONVERTIR AL NUEVO ESTILO
  def test_model_loader_loading_emof
    context = Module.new
    loader  = RubyTL::CustomModelLoader.new        
    loader.load_metamodel_in_context(context, "#{files_dir}/class2table/ClassM.emof")
    
    package = context.const_get('ClassM')    
    assert package
    assert_equal 'ClassM', package.name 
    assert_equal Module, package.class
    assert package::Class    
    assert_equal Class, package::Class.class
  end
  
  def test_model_loader_reading_xmi
    context = Module.new
    loader  = RubyTL::CustomModelLoader.new        
    loader.load_metamodel_in_context(context, "#{files_dir}/metamodels/TableM.emof")
    loader.load_model_in_context(context, "#{files_dir}/models/table.emof")    

    # TODO: Test
  end
  

  # Test if a new model can be created
  def test_create_new_model
    repository = RubyTL::Repository.new(RubyTL::HandlerRMOF.new, TestURIResolver.new)
    model_proxy = repository.new_model("file://#{files_dir}/class2table/ClassM.emof")

    1.upto(10) { |i|
      model_proxy::Class.new do |klass|       
        klass.attrs << model_proxy::Attribute.new(:name => i.to_s)
      end
    }
    assert_equal 10, model_proxy.all_objects_of(model_proxy::ClassM::Class).size
    assert_equal 10, model_proxy::Class.all_objects.size    
  end
  
  # Test is a transformation is able to properly load an input model
  def test_loading_a_source_with_rmof_handler
    repository = RubyTL::Repository.new(RubyTL::HandlerRMOF.new, TestURIResolver.new)

    assert repository.metamodel?("file://#{files_dir}/class2table/ClassM.emof") == true
    assert repository.metamodel?("file://#{files_dir}/class2table/Class.emof")  == false

    assert repository.metamodel("file://#{files_dir}/class2table/ClassM.emof").kind_of?(Module)
    assert repository.metamodel("file://#{files_dir}/class2table/ClassM.emof").name =~ /ClassM$/
    
    model_proxy = repository.model("file://#{files_dir}/class2table/source.rb",
                                   "file://#{files_dir}/class2table/ClassM.emof")
    
    klasses = model_proxy.all_objects_of(model_proxy::Class)
    attrs   = model_proxy.all_objects_of(model_proxy::Attribute)
    ptypes  = model_proxy.all_objects_of(model_proxy::PrimitiveType)

    assert_equal 3, klasses.size
    assert_equal 3, ptypes.size
    assert_equal 9, attrs.size    
    
    assert_equal 1, klasses.select { |k| k.name == 'Job' }.size
    assert_equal 1, klasses.select { |k| k.name == 'Pet' }.size
    assert_equal 1, klasses.select { |k| k.name == 'Person' }.size        
    
    person = klasses.select { |k| k.name == 'Person' }.first
    job    = klasses.select { |k| k.name == 'Job' }.first

    assert_equal 4, person.attrs.size
    assert_equal 3, job.attrs.size    
  end

  # Test emof handler loading an xmi model
  def test_emof_handler_loading_an_xmi_model
    repository = RubyTL::Repository.new(RubyTL::HandlerRMOF.new, TestURIResolver.new)

    assert repository.model?("file://#{files_dir}/models/table.emof")
    model_proxy = repository.model("file://#{files_dir}/models/table.emof",
                                   "file://#{files_dir}/metamodels/TableM.emof")

    # is ownership handled?            
    assert_equal  3, model_proxy.all_objects_of(model_proxy::Table).size
    assert_equal 10, model_proxy.all_objects_of(model_proxy::Column).size
    
    assert_equal  3, model_proxy::Table.all_objects.size
    assert_equal 10, model_proxy::Column.all_objects.size
    
  end
  
  # This test ensures that a model conforming a metamodel with an element called
  # type is properly loaded, since there is a conflict if we have something
  # like:
  # <JavaM.Class ...>
  #   <features xmi:type='JavaM.Method' type='Interface_1'.../>
  # </JavaM.Class>
  def test_load_java_model_with_type_attribute_conflict_in_xmi
    repository = RubyTL::Repository.new(RubyTL::HandlerRMOF.new, TestURIResolver.new)
    model_proxy = repository.model("file://#{files_dir}/models/java_set_methods_without_type.emof",
                                   "file://#{files_dir}/metamodels/JavaM.emof")
    
  end
  
  # Test proper errors are raise with bad uris 
  def test_bad_uri
    repository = RubyTL::Repository.new(RubyTL::HandlerRMOF.new, TestURIResolver.new)

    assert_raise(URI::InvalidURIError) { repository.metamodel?('adsf://#adsf') }
    assert_raise(RubyTL::URINotSupportedError) { repository.metamodel?('repository://metamodel/something') }    
    assert_raise(RMOF::NoMetamodelExistError) { repository.metamodel("file://#{files_dir}/class2table/source.rb") }
  end

  # Test if all_instances properly handles superclasses
  def test_all_instances
    repository = RubyTL::Repository.new(RubyTL::HandlerRMOF.new, TestURIResolver.new)
    model_proxy = repository.model("file://#{files_dir}/class2table/source.rb",
                                   "file://#{files_dir}/class2table/ClassM.emof")
    
    classifiers = model_proxy.all_objects_of(model_proxy::ClassM::Classifier)
    classes     = model_proxy.all_objects_of(model_proxy::ClassM::Class)
    ptypes      = model_proxy.all_objects_of(model_proxy::ClassM::PrimitiveType)

    assert_equal 6, classifiers.size
    assert_equal classes.size + ptypes.size, classifiers.size
    assert_equal 3, classes.size
    assert_equal 3, ptypes.size   

    assert model_proxy::Class.conforms_to(model_proxy::Class)
    assert model_proxy::Class.all_super_classes.include?(model_proxy::Classifier)
  end

  # Test if metaclass runtim extension is possible.
  def test_metaclass_extension
    repository = RubyTL::Repository.new(RubyTL::HandlerRMOF.new, TestURIResolver.new)
    model_proxy = repository.model("file://#{files_dir}/class2table/source.rb",
                                   "file://#{files_dir}/class2table/ClassM.emof")
    mod = set_up_context 
    mod.load_helper_set(mod, 'test_load_helper')        
    mod.const_set('ClassM', model_proxy)

    mod.module_eval %q{
      test_load_helper 'files/helpers/feature_inclusion'
      
      module ClassM
        class Class
          def test_me; "i'm ok Class";  end
          def self.test_me; "i'm Class"; end
        end
      end
      
      class ClassM::Attribute
        def test_me; "i'm ok Attribute";  end
        def self.test_me; "i'm Attribute"; end      
      end

      module ClassM::Classifier::Extensions
        def super_method; "i belong to #{self.class}"; end
        def are_you_a_classifier?; true end 
      end
      
      class ClassM::Class
        include FeatureInclusion
      end
    }

    classifiers = model_proxy.all_objects_of(model_proxy::ClassM::Classifier)
    classes     = model_proxy.all_objects_of(model_proxy::ClassM::Class)
    ptypes      = model_proxy.all_objects_of(model_proxy::ClassM::PrimitiveType)
    attributes  = model_proxy.all_objects_of(model_proxy::ClassM::Attribute)

    (classes + attributes).each do |klass|
      assert_equal "i'm ok #{klass.class.name.split(':').last}", klass.test_me
    end
    (classes + classifiers + ptypes).each do |element|
      assert_equal "i belong to #{element.class}", element.super_method
      assert_equal true, element.are_you_a_classifier?
    end
    assert_equal "i'm Class", model_proxy::ClassM::Class.test_me
    assert_equal "i'm Attribute", model_proxy::ClassM::Attribute.test_me
    
    (classes).each do |element|
      assert_equal "i'm a feature", element.a_feature
      assert_equal true, element.are_you_a_class?
    end
  end
  
  def test_serialize_model_exo
    repository = RubyTL::Repository.new(RubyTL::HandlerRMOF.new, TestURIResolver.new)
    model_proxy = repository.new_model("file://#{files_dir}/metamodels/ExoMetamodelPages.emof",
                                       "file:///tmp/test.emof")
    
    page_set = model_proxy::PageSet.new
    page_set.pages << model_proxy::Page.new(:name => 'test')
    
    # This exception is always raised because Page has reference called 'container'
    # and it causes a name crashing. To solve this problem (in a bad manner) the 
    # reference PageSet.pages can be set to 'containment == true'. This makes not trying
    # to access the container to resolve the container.xmi_id.
    # The solution (the correct way) is to shadow the 'container' accessor to avoid
    # name crashes.
    assert_raise(NoMethodError) {
      model_proxy.serialize
    }
  end
  
  
  def test_serialize_model_state_machine
    $test = false
    repository = RubyTL::Repository.new(RubyTL::HandlerRMOF.new, TestURIResolver.new)
    model_proxy = repository.new_model("file://#{files_dir}/metamodels/Onekin.emof",
                                       "file:///tmp/test.emof")
    state_machine = model_proxy::StateMachine.new
    puts state_machine.regions.class
    state_machine.regions.add(model_proxy::Region.new do |region|
    $test =true
      region.states.add(model_proxy::RootState.new(:name => 'root') do |root|
        root.regions.add(model_proxy::Region.new do |region2|
          region2.states.add(model_proxy::SimpleState.new(:name => 'simple1'))
        end)
      end)
    end)                                    

    model_proxy.serialize 
  end  
  
  def test_ruby_names_for_packages_and_multiple_root_packages
    repository = set_up_repository_rmof2
    context = RubyTL::TransformationContext.new
    
    RubyTL::OverridingModel.new('rubyname', :memory,
                                'test://metamodels/non_ruby_names.ecore'.to_repo).bind_as_target(repository, context)
    
    assert context::Rubyname
    assert context::Rubyname::RubyPackageName
    assert context::Rubyname::Norubynames
    assert context::Rubyname::Norubynames::DowncaseClass
    assert context::Rubyname::Norubynames::AnotherNoRubyName
    
  end
=end  
end
