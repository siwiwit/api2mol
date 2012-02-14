require 'rubytl_base_unit'

# This test class try to ensure that errors that may happen in
# a RubyTL transformation are properly handled, so that the user
# can follow the error until its root.
#
# 
#
class ErrorTest < Test::Unit::TestCase

  # Test that a syntax error ocurred when the transformation is going
  # to be loaded, is properly captured
  def test_ruby_syntax_error_no_matching_end
    transformation = <<-TEND
      module Class2Table
        rule 'rule-without-end' do
      end  
    TEND
    
    launcher = RubyTL::Launcher.new(:source_metamodel => metamodel('class2table/ClassM.emof'),
                                    :target_metamodel => metamodel('class2table/TableM.emof'),
                                    :source_model     => model('class2table/source.rb'),
                                    :module => 'Class2Table', :serialize => false,
                                    :transformation   => transformation)
    launcher.selected_plugins = [:default]
    assert_raises(RubyTL::RubySyntaxError) { launcher.evaluate }
  end

  # Test that a RubyTL::RubySyntaxError is raised when a name cannot be resolved
  # when loading a transformation.
  def test_ruby_name_not_exist
    transformation = <<-TEND
      no_existing_method
    TEND
    
    launcher = RubyTL::Launcher.new(:source_metamodel => metamodel('class2table/ClassM.emof'),
                                    :target_metamodel => metamodel('class2table/TableM.emof'),
                                    :source_model     => model('class2table/source.rb'),
                                    :module => 'Class2Table', :serialize => false,
                                    :transformation   => transformation)
    launcher.selected_plugins = [:default]
    assert_raises(RubyTL::RubySyntaxError) { launcher.evaluate }
  end

  
  def test_no_method_exist_error
    source_model = RubyTL::OverridingModel.new('STree', model('models/DeepTree.ecore'), metamodel('metamodels/Tree.ecore'))
    target_model = RubyTL::OverridingModel.new('TTree', :memory, metamodel('metamodels/Tree.ecore'))
    launcher = RubyTL::Launcher.new(:source_models  => [source_model], :target_models => [target_model],
                                    :transformation => { 'TreeError' => transformation('tree_error.rb') } )
    launcher.selected_plugins = [:default]  
    
    begin
      launcher.evaluate
    rescue RubyTL::EvaluationError => e
      e.print_error($stderr, transformation('tree_error.rb'))
      #puts e.prettify(transformation('tree_error.rb'))
    else
      fail("Expected RubyTL::EvaluationError")
    end
  end
  
end