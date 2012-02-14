require 'rubytl_base_unit'

class TransformationDSLTest < Test::Unit::TestCase

  def test_language_keywords
    context = RubyTL::TransformationContext.new
    context.generate_dsl
    context.instance_eval do
      phase 'top_phase' do
      
      end
    
      rule 'myrule' do
        from Object
        to   Object
      end
    end
  end


  def test_language_read_file
    context = RubyTL::TransformationContext.new
    context.load_transformation(%{      
      rule 'myrule' do
        from Object
        to   Object
        mapping do |x, y|
        
        end
      end    
    }, "test-file")
  end


  def test_adding_a_new_keyword
    context = RubyTL::TransformationContext.new
    context.generate_dsl
    syntax  = context.syntax
    
    syntax.create_method('test_method', ['param1', 'param2'], %{
      "value" + param1.to_s + param2.to_s
    }) 
    syntax.create_method('test_method2', 'param1', %{ param1.to_s })     
    syntax.create_method('test_empty', %{ 'empty' })     
    
    assert 'value2bye', context.module_eval { test_method(2, 'bye') }
    assert 'test',      context.module_eval { test_method2('test') }
    assert 'empty',     context.module_eval { test_empty }  
  end
  
  def test_setting_transformation_header
    context, transformation, repository = set_up_uml2java
    RubyTL::ShouldBindModel.new('UML', 'test://models/class_model.ecore.xmi'.to_repo).bind_as_source(repository, context)
    RubyTL::ShouldBindModel.new('Java', :memory).bind_as_target(repository, context)

    load_simple_header(context)
    assert_equal 'class2java', transformation.name
    
    # Test the decorator added the method in the subclasses
    klass = context.module_eval %{ Java::Class.new }
    ptype = context.module_eval %{ Java::PrimitiveType.new }
   
    assert_equal 'Class', klass.your_name
    assert_equal 'PrimitiveType', ptype.your_name

    # Test the decorator works properly with existing objects
    model = context.module_eval %{ UML::Model.all_objects.first }
    assert_equal 'extension', model.method_extension
  end
  
  # Test that metamodel definitions should have a model bound when executed.
  def test_undefined_model
    context, transformation, repository = set_up_uml2java
    # Dont't bind source models, and test that proper exceptions are raised
    # repository.bind_as_source('UML', 'test://models/class_model.ecore.xmi') 
    # repository.bind_as_target('Java', :memory) 

    assert_raise(RubyTL::UndefinedModel) { load_input_output_header(context) }
    
    context, transformation, repository = set_up_uml2java  
    RubyTL::ShouldBindModel.new('UML', 'test://models/class_model.ecore.xmi'.to_repo).bind_as_source(repository, context)
    assert_raise(RubyTL::UndefinedModel) { load_input_output_header(context) }
  end

  def test_with_overriding_model
    context, transformation, repository = set_up_uml2java
    RubyTL::OverridingModel.new('UML', 'test://models/class_model.ecore.xmi'.to_repo,
                               'test://metamodels/ClassM.ecore'.to_repo).bind_as_source(repository, context)
    RubyTL::OverridingModel.new('Java', :memory, 
                                'test://metamodels/JavaM.ecore'.to_repo).bind_as_target(repository, context)

    load_simple_header(context)
  
  end

private
  def set_up_uml2java
    context = RubyTL::TransformationContext.new
    context.generate_dsl
    repository = set_up_repository_rmof2
    transformation = RubyTL::Transformation.new(context, repository)
    context.transformation_ = transformation
    
    return context, transformation, repository  
  end

  def load_input_output_header(context)
    context.load_transformation(%{
      transformation 'class2java'      
      input 'UML' => 'test://metamodels/ClassM.ecore'.to_repo
      output 'Java' => 'test://metamodels/JavaM.ecore'.to_repo
    }, 'test')    
  end

  def load_simple_header(context)
    context.load_transformation(%{
      transformation 'class2java'      
      input 'UML' => 'test://metamodels/ClassM.ecore'.to_repo
      output 'Java' => 'test://metamodels/JavaM.ecore'.to_repo

      decorator UML::Model do
        def method_extension
          "extension"
        end
      end

      decorator Java::Classifier do
        def your_name
          self.metaclass.name
        end
      end
    }, 'test')  
  end
  
  # def test_dependencies_between_keywords_are_satified
  #  
  # end

  
end

