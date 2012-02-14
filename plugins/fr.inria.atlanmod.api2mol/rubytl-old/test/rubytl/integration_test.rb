require 'rubytl_base_unit'

# Test the behaviour of the whole engine.
#
class IntegrationTest < Test::Unit::TestCase
  include RubyTL::TestLaunchers

  # Test the transformation class2table located in files/class2table
  def test_class2table
    launcher = rubytl_launcher_class2table
    launcher.evaluate

    asserts_for_class2table(launcher)
  end
  
  def test_class2table_with_phases
    launcher = rubytl_launcher_class2table_phases
    launcher.evaluate
    
    asserts_for_class2table(launcher)
  end

private
  def asserts_for_class2table(launcher)
    classM = launcher.loaded_source.first.proxy
    tableM = launcher.loaded_target.first.proxy

    classes = classM.all_objects_of(classM::Class)   
    tables  = tableM.all_objects_of(tableM::Table)

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
