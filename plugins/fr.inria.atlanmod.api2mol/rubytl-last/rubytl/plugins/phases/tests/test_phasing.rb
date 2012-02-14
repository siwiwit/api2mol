

class PhasesTest < Test::Unit::TestCase  
  include TestHelper

  def setup
    set_plugin_path(__FILE__)
  end

  def test_phasing_with_a_good_ordering
    rubytl = RubyTL::Launcher.new(:source_metamodel => metamodel('class2table/ClassM.emof'),
                                  :target_metamodel => metamodel('class2table/TableM.emof'),
                                  :source_model     => model('class2table/source.rb'),
                                  :module => 'Class2TablePhasing', :serialize => false,
                                  :transformation   => plugin_file('class2table.phasing.rb'))
    rubytl.selected_plugins = [:default, :set_type, :top_rules, :ignore_conflicts, :explicit_calls, :phases]
    rubytl.evaluate   
    # TODO: El problema de esta transformaci�n es que machaca la anterior, si se ejecuta s�la s� funciona
    check_transformation(rubytl)
  end

  def test_phasing_with_a_bad_ordering
    rubytl = RubyTL::Launcher.new(:source_metamodel => metamodel('class2table/ClassM.emof'),
                                  :target_metamodel => metamodel('class2table/TableM.emof'),
                                  :module => 'Class2TablePhasing', :serialize => false,
                                  :source_model     => plugin_file('source.phases.rb'),
                                  :transformation   => plugin_file('class2table.phasing.rb'))
    rubytl.selected_plugins = [:default, :set_type, :top_rules, :ignore_conflicts, :explicit_calls, :phases]
    rubytl.evaluate   
    
    check_transformation(rubytl)
  end

  def test_refinement_rule_resolving_binding
    rubytl = RubyTL::Launcher.new(:source_metamodel => metamodel('class2table/ClassM.emof'),
                                  :target_metamodel => metamodel('class2table/TableM.emof'),
                                  :source_model     => model('class2table/source.rb'),
                                  :module => 'Class2TablePhasing', :serialize => false,
                                  :transformation   => plugin_file('class2table.refinement.rb'))
    rubytl.selected_plugins = [:default, :set_type, :top_rules, :ignore_conflicts, :explicit_calls, :phases]
    rubytl.evaluate   
    # TODO: El problema de esta transformaci�n es que machaca la anterior, si se ejecuta s�la s� funciona
    check_transformation(rubytl)
  end


  def test_matching_more_than_one_target_metaclass
    # This comes from the examination assistant example
    raise "TODO: Improve plugin testing support"
  end

private
  def check_transformation(rubytl)
    source, target = packages(rubytl)
  
    classes = source.all_objects_of(source::Class)
    tables = target.all_objects_of(target::Table)
    assert_equal classes.size, tables.size

    # Is Pet properly transformed
    tpet = tables.find_by_name('Pet')
    assert_equal   2, tpet.cols.size

    assert_not_nil tpet.cols.find_by_name('name')
    assert_not_nil tpet.cols.find_by_name('age')

    assert_equal   1, tpet.pkeys.size
    assert_equal   tpet.cols.find_by_name('name'), tpet.pkeys.find_by_name('name')

    # Is Job properly transformed
    tjob = tables.find_by_name('Job')
    assert_equal   3, tjob.cols.size  # 2 columns + 1 fkey

    assert_not_nil tjob.cols.find_by_name('name')
    assert_not_nil tjob.cols.find_by_name('address')
    assert_not_nil tjob.cols.find_by_name('best_employee_Person_name')

    assert_equal   2, tjob.pkeys.size
    assert_equal   tjob.cols.find_by_name('name'), tjob.pkeys.find_by_name('name')
    assert_equal   tjob.cols.find_by_name('address'), tjob.pkeys.find_by_name('address')

    
    # Is Person properly transformed
    tperson = tables.find_by_name('Person')
    assert_equal   5, tperson.cols.size   # 2 cols + 1 pet-fkey + 2 job-fkey

    assert_not_nil tperson.cols.find_by_name('name')
    assert_not_nil tperson.cols.find_by_name('age')
    assert_not_nil tperson.cols.find_by_name('pet_Pet_name')
    assert_not_nil tperson.cols.find_by_name('job_Job_name')
    assert_not_nil tperson.cols.find_by_name('job_Job_address')    

    assert_equal   1, tperson.pkeys.size
    assert_equal   tperson.cols.find_by_name('name'), tperson.pkeys.find_by_name('name')  
  end
end

