require 'rubytl_base_unit'

# Test the behaviour of the whole engine.
#
class IntegrationTest < Test::Unit::TestCase

  # Test the transformation class2table located in files/class2table
  def test_class2table
    launcher = RubyTL::Launcher.new(:source_metamodel => metamodel('class2table/ClassM.emof'),
                                    :target_metamodel => metamodel('class2table/TableM.emof'),
                                    :source_model     => model('class2table/source.rb'),
                                    :module => 'Class2Table',
                                    :transformation   => transformation('class2table/class2table.rb'),
                                    :module => 'Class2Table', :serialize => false)
    launcher.selected_plugins = [:default, :set_type, :explicit_calls]
    launcher.evaluate
    rubytl = launcher    

    classM, tableM = packages(rubytl)

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
  
  def test_inherited_references_through_class2java
    launcher = RubyTL::Launcher.new(:source_metamodel => metamodel('class2java/ClassM.emof'),
                                    :target_metamodel => metamodel('class2java/JavaM.emof'),
                                    :module => 'Class2Java', :serialize => false,
                                    :source_model     => model('class2java/class-source.rb'),
                                    :transformation   => transformation('class2java/class2java.rb'))
    launcher.selected_plugins = [:default, :set_type, :explicit_calls]
    launcher.evaluate
    rubytl = launcher      
    # TODO: nothing to check here?
  end
  
  def test_class2java_with_ecore
    launcher = RubyTL::Launcher.new(:source_metamodel => metamodel('class2java/ClassM.ecore'),
                                    :target_metamodel => metamodel('class2java/JavaM.ecore'),
                                    :module => 'Class2Java', :serialize => false,
                                    :source_model     => model('class2java/class-source.rb'),
                                    :transformation   => transformation('class2java/class2java.rb'))
    launcher.selected_plugins = [:default, :set_type, :explicit_calls]
    launcher.evaluate
    rubytl = launcher      
    # TODO: nothing to check here?
  end  
  
  def test_result_as_a_serialized_xmi_file
    # Note the parameters -> :serialize = true & target_model
    require 'tmpdir'
    target_model = File.join(Dir.tmpdir, 'rubytl_testserialized.emof')
    launcher = RubyTL::Launcher.new(:source_metamodel => metamodel('class2java/ClassM.emof'),
                                    :target_metamodel => metamodel('class2java/JavaM.emof'),
                                    :module => 'Class2Java',
                                    :source_model     => model('class2java/class-source.rb'),
                                    :transformation   => transformation('class2java/class2java.rb'),
                                    :target_model => target_model, :serialize => true)
    launcher.selected_plugins = [:default, :set_type, :explicit_calls]
    launcher.evaluate

    assert File.exist?(target_model)
    File.open(target_model) do |f|
      xmi = f.read
      assert xmi =~ /class2java\/JavaM\.emof/    
    end
  ensure
    File.delete(target_model) if File.exists?(target_model)
  end  
end