class DefaultTest < Test::Unit::TestCase  
  include TestHelper

  def setup
    set_plugin_path(__FILE__)
  end

  #
  def test_default_conformance
    #TODO: "To test: default conformance"
  end

  def test_error_on_empty_transformation
    # rubytl = RubyTL::Launcher.new(:source_metamodel => 'AB', 
    #                              :target_metamodel => 'CD', 
    #                              :source_model     => 'ABModel', 
    #                              :module => 'EmptyTransformation',
    #                              :transformation   => empty)
    # rubytl.selected_plugins = [:default]
    # assert_raise(RuntimeError) { rubytl.evaluate }
    #
    # Este test nunca se va a pasar correctamente porque una 
    # transformaci�n sin reglas no se registra
    # TODO: Test
  end

  def test_only_first_rule
    rubytl = RubyTL::Launcher.new(:source_metamodel => plugin_file('AB.xmi'), 
                                  :target_metamodel => plugin_file('CD.xmi'), 
                                  :source_model     => plugin_file('ABModel.xmi'), 
                                  :module => 'OnlyFirst', :serialize => false,
                                  :transformation   => only_first)
    rubytl.selected_plugins = [:default]
    rubytl.evaluate
    
    ab, cd = packages(rubytl)
    aes = ab.all_objects_of(ab::A)
    ces = cd.all_objects_of(cd::C)
    des = cd.all_objects_of(cd::D)
    
    assert_equal aes.size, ces.size
    assert_equal 0, des.size        
  end

  class RubyTL::ConflictingRules < RubyTL::EvaluationError; end;
  def test_rule_conflicts
    rubytl = RubyTL::Launcher.new(:source_metamodel => plugin_file('AB.xmi'), 
                                  :target_metamodel => plugin_file('CD.xmi'), 
                                  :source_model     => plugin_file('ABModel.xmi'), 
                                  :module => 'RuleConflicts', :serialize => false,
                                  :transformation   => rule_conflicts)
    rubytl.selected_plugins = [:default]
    assert_raise(RubyTL::ConflictingRules) { rubytl.evaluate }
  end

  def test_should_be_an_error
    rubytl = RubyTL::Launcher.new(:source_metamodel => plugin_file('AB.xmi'), 
                                  :target_metamodel => plugin_file('CD.xmi'), 
                                  :source_model     => plugin_file('ABModel.xmi'), 
                                  :module => 'ShouldBeAnError', :serialze => false,
                                  :transformation   => should_be_an_error)
    rubytl.selected_plugins = [:default]
    assert_raise(RubyTL::InvalidSyntax) { rubytl.evaluate }  
  end

  # Test that RubyTL throws an exception if a binding cannot be resolved
  # due to being unable to find an applicable rule.
  def test_no_rule_applicable
    rubytl = RubyTL::Launcher.new(:source_metamodel => plugin_file('AB.xmi'), 
                                  :target_metamodel => plugin_file('CD.xmi'), 
                                  :source_model     => plugin_file('ABModel.xmi'), 
                                  :module => 'NoRuleApplicable', :serialize => false,
                                  :transformation   => no_rule_applicable)
    rubytl.selected_plugins = [:default]
    assert_rubytl_exception('::RubyTL::NoRuleFoundError') { rubytl.evaluate }   
  end


  def test_sharing_an_element
    rubytl = RubyTL::Launcher.new(:source_metamodel => plugin_file('ClassM.emof'),
                                  :target_metamodel => metamodel('metamodels/JavaM.emof'),
                                  :source_model     => plugin_file('class-source-multiple-inheritance.rb'),
                                  :module => 'Class2JavaToTestCreation', :serialize => false,
                                  :transformation   => plugin_file('class2java.sharing.rb'))
    rubytl.selected_plugins = [:default, :ignore_conflicts, :copy_rules]
    rubytl.evaluate   

    classm, javam = packages(rubytl)    

    methods = javam.all_objects_of(javam::Method)
    methods.select { |m| m.name =~ /operation/ }.each do |m|
      assert m.type
    end
    
    # TODO: Until here everything is ok, but an aggregated object is
    # shared, so it should have been detected because it can cause problems
    # when serializing
  end  
  
  def test_nil_values_on_the_right  
    rubytl = RubyTL::Launcher.new(:source_metamodel => plugin_file('AB.xmi'), 
                                  :target_metamodel => plugin_file('CD.xmi'), 
                                  :source_model     => plugin_file('ABModel.xmi'), 
                                  :serialize => false,:transformation   => nil_values_on_the_right)
    rubytl.selected_plugins = [:default]
    rubytl.evaluate
  end

end

def empty
  "module EmptyTransformation " + $/ +  
  "end"
end

def should_be_an_error
<<-END_OF
    rule 'A' do
    end
END_OF
end

def only_first
<<-END_OF
    rule 'A' do
      from    AB::A
      to      CD::C          
      mapping do |a, c|
        c.name = a.name
      end
    end
      
    rule 'no_applicable' do            
      from    AB::A
      to      CD::C
      mapping do |a,c| end
    end
END_OF
end

def rule_conflicts
<<-END_OF_TRANSFORMATION
    rule 'AtoC' do
      from  AB::A
      to    CD::C
      mapping do |a,c| 
        c.des = a.bes   
      end
    end 
    rule 'BtoD' do
      from AB::B
      to CD::D
      mapping do |a,d|
        d.name='tipo1'
      end
    end
    rule 'BtoD_version2' do
      from AB::B
      to CD::D
      mapping do |a,d|
        d.name='tipo2'
      end
    end
END_OF_TRANSFORMATION
end

def no_rule_applicable
<<-END_OF_TRANSFORMATION
    rule 'AtoC' do
      from  AB::A
      to    CD::C
      mapping do |a,c| 
        c.des = a.bes   
      end
    end 
END_OF_TRANSFORMATION
end

def nil_values_on_the_right
<<-END_OF
    rule 'A' do
      from    AB::A
      to      CD::C          
      mapping do |a, c|
        c.name = nil
        c.des  = [nil] + a.bes
      end
    end
    
    rule 'BtoD_version2' do
      from AB::B
      to CD::D
      mapping do |a,d|
        d.name='tipo2'
      end
    end    
END_OF
end