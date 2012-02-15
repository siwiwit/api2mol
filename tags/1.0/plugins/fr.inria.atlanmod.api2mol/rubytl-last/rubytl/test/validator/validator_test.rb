require 'rubytl_base_unit'

# Test the model checker.
#
class ValidatorTest < Test::Unit::TestCase
  include RubyTL::TestLaunchers
  
  def setup
    @config = RubyTL::Base::Configuration.new
  end
  
  def test_implies_extension
    assert_equal true,  true.implies(true)
    assert_equal false, true.implies(false)
    assert_equal true,  false.implies(true)
    assert_equal true,  false.implies(false)
  end

  def test_context_checking_invariants_without_errors
    handler = RubyTL::HandlerRMOF2.new(@config)
    class_model = RubyTL::TestFiles.class_source_model
    model_proxy = handler.load(class_model).proxy

#    repository = RubyTL::Repository.new(RubyTL::HandlerRMOF.new, TestURIResolver.new)
#    model_proxy = repository.model("file://#{files_dir}/class2table/source.rb",
#                                   "file://#{files_dir}/class2table/ClassM.emof") 
                                   
    context    = RubyTL::Checker::Context.new(model_proxy::Class)
    invariant1 = RubyTL::Checker::Invariant.new('test-name', context) { self.name != nil }
    invariant2 = RubyTL::Checker::Invariant.new('test-implies', context) { 
      (self.name == 'Trabajo').implies( self.attrs.any? { |a| a.name == 'nombre' } ) 
    }
    
    context.check_invariant(invariant1)
    context.check_invariant(invariant2)    
    
    assert_equal false, context.any_error?           
  end
  
  # Test that all errors in the invariants are kept in an error
  # list rather than being thrown.
  def test_context_captures_errors
    # TODO: test_context_captures_errors
  end
  
  # Test the associated DSL language.
  #
  def test_dsl_language
    launcher = checker_launcher_classes
    launcher.evaluate   

    assert_equal 1, launcher.errors_by_invariant.size   
    assert_equal 1, launcher.errors_by_invariant['test-a-false'].size    
    assert_equal 'test-a-false', launcher.errors_by_invariant['test-a-false'].first.invariant.name
  end
  
  
end
