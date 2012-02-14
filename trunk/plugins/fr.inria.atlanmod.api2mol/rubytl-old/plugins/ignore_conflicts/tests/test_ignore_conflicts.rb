class TestIgnoreConflicts < Test::Unit::TestCase  
  include TestHelper

  def setup
    set_plugin_path(__FILE__)
  end

  def test_rule_conflicts_resolved
    rubytl = RubyTL::Launcher.new(:source_metamodel => plugin_file('AB.xmi'), 
                                  :target_metamodel => plugin_file('CD.xmi'), 
                                  :source_model     => plugin_file('ABModel.xmi'), 
                                  :module => 'RuleConflictsResolved', :serialize => false,
                                  :transformation   => rule_conflicts_resolved)
    rubytl.selected_plugins = [:default, :ignore_conflicts]
    rubytl.evaluate
    
    ab, cd = packages(rubytl)
    bes = ab.all_objects_of(ab::B)
    des = cd.all_objects_of(cd::D)  
    assert_equal bes.size * 2, des.size       
  end

end


def rule_conflicts_resolved
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