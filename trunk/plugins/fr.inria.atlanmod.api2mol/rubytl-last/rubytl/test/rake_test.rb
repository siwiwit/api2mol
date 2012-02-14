require 'rubytl_base_unit'
require 'stringio'

# Load Rake
begin
  require 'rake'
rescue LoadError => e
  $LOAD_PATH << File.join(RUBYTL_ROOT, '..', 'thirdparty', 'rake')
  require 'rake'
end

require File.join(RUBYTL_ROOT, "tasks", "rake_extension")
require File.join(RUBYTL_ROOT, "tasks", "model_to_model_task")
require File.join(RUBYTL_ROOT, "tasks", "model_to_code_task")

# Test the use of rake task to compose several transformations
# either model-to-model and model-to-code.
#
class RakeTasksTest < Test::Unit::TestCase

  def setup
    RubyTL::BaseTaskLib.logical_mapper = TestWriteLogicalMapper.new(files_dir)
    RubyTL::BaseTaskLib.uri_resolver = TestURIResolver.new
    RubyTL::BaseTaskLib.model_mappings = nil
  end

  def test_model_to_model_tasklib    
    task = RubyTL::TransformationTask.new('test_task') do |t|
      t.sources 'Class1' => ['test:/class2table/source.rb', 'test:/class2table/ClassM.emof'],
                'Class2' =>  'test:/class2table/source.rb'
      t.targets 'Table1'  => [:memory, 'test:/class2table/TableM.emof'],
                'Table2'  => '/tmp/target.emof'
      t.transformation 'Class2Table' => 'test:/class2table/class2table.rb'
      t.parameters 'param1' => 'testparam1', 
                   'param2' => 'testparam2'
      t.parameters 'param3' => 'testparam3'
    end
    
    klass1source = task.collected_sources[0]
    klass2source = task.collected_sources[1]    
    table1target = task.collected_targets[0]
    table2target = task.collected_targets[1]    
    transformation = task.collected_transformation
    parameters   = task.collected_parameters

    assert klass1source
    assert klass2source
    assert table1target
    assert table2target    
    assert transformation    
    assert_equal 'Class1', klass1source.bind_name    
    assert_equal 'Class2', klass2source.bind_name    
    assert_equal 'Table1',  table1target.bind_name
    assert_equal 'Table2',  table2target.bind_name
    assert_equal 'test:/class2table/class2table.rb',  transformation
    assert_equal 3, parameters.size
    assert_equal %w{param1 param2 param3}, parameters.keys.sort
    assert_equal %w{testparam1 testparam2 testparam3}, parameters.values.sort

    assert klass1source.kind_of?(RubyTL::OverridingModel)
    assert klass2source.kind_of?(RubyTL::ShouldBindModel)
    assert table1target.kind_of?(RubyTL::OverridingModel)
    assert table2target.kind_of?(RubyTL::ShouldBindModel)    
  end

  def test_transformation_task      
    eval(simple_class2table_rakefile)
    Rake::Task[:class2table_unique].invoke
  end

  def test_2code_task    
    mapper = RubyTL::BaseTaskLib.logical_mapper
    
    eval(simple_2code)
    Rake::Task[:toklass].invoke

    job    = mapper.files['/tmp/Job.pseudo'].string
    pet    = mapper.files['/tmp/Pet.pseudo'].string
    person = mapper.files['/tmp/Person.pseudo'].string

    assert_equal 3 + 2, job.split($/).size
    assert_equal 2 + 2, pet.split($/).size
    assert_equal 4 + 2, person.split($/).size    
  end

  def test_composing_task    
    mapper = RubyTL::BaseTaskLib.logical_mapper    
    eval(class2table_rakefile)
    
    Rake::Task[:generate].invoke    

    tables = mapper.files['/tmp/tables.sql'].string  

    assert tables.include?("create table Job (")
    assert tables.include?("create table Pet (")
    assert tables.include?("create table Person (")    
    assert tables.include?("ALTER TABLE ADD CONSTRAINT FOREIGN KEY (pet_Pet_name)")    
    assert tables.include?("ALTER TABLE ADD CONSTRAINT FOREIGN KEY (job_Job_name, job_Job_address)")        
    assert tables.include?("ALTER TABLE ADD CONSTRAINT FOREIGN KEY (best_employee_Person_name)")        
  end

end

def simple_class2table_rakefile
  %{
  model_to_model :class2table_unique do |t|
    t.sources 'ClassM' => ['test:/class2table/source.rb', 'test:/class2table/ClassM.emof']
    t.targets 'TableM' => [:memory                , 'test:/class2table/TableM.emof']
    t.transformation 'Class2Table' => 'test:/class2table/class2table.rb'
  end 
  
  }
end

def simple_2code
  %{
  model_to_code :toklass do |t|
    t.sources 'ClassM' => ['test:/class2table/source.rb', 'test:/class2table/ClassM.emof']
    
    t.codebase = '/tmp' 
    t.generate  'class2table/gen/genclass.2code'
  end
  }
end

def class2table_rakefile
  %{
  model_to_model :class2table do |t|
    t.source :package   => 'ClassM',
             :metamodel => 'test:/class2table/ClassM.emof',
             :model     => 'test:/class2table/source.rb'

    t.target :package   => 'TableM',
             :metamodel => 'test:/class2table/TableM.emof',
             :model     => :memory # by default
    t.transformation 'test:/class2table/class2table.rb'
  end 
  
  model_to_code :tosql => :class2table do |t|
    t.codebase = '/tmp' 
    t.generate  'class2table/gen/gentable.2code'
  end
  
  task :generate => :tosql do 
    # mkdir ...
    # mkdir ...
  end
  }
end

