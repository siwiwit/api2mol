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
class ParameterDSLTest < Test::Unit::TestCase

  def setup
    RubyTL::BaseTaskLib.logical_mapper = TestWriteLogicalMapper.new(files_dir)
    RubyTL::BaseTaskLib.uri_resolver = TestURIResolver.new
    RubyTL::BaseTaskLib.model_mappings = nil
  end

  # TODO: Fine-grained testing for the DSL

  def test_parameters_from_rake_point_of_view
    eval(simple_tree_phases_rakefile)
    Rake::Task[:tree_phases].invoke
  end


end

def simple_tree_phases_rakefile
  %{
  model_to_model :tree_phases do |t|
    t.sources 'STree' => ['test:/models/DeepTree.ecore', 'test:/metamodels/Tree.ecore']
    t.targets 'TTree' => [:memory                , 'test:/metamodels/Tree.ecore']
    t.transformation 'tree' => 'test:/transformations/tree.phases.rb'
    t.plugins :default, :top_rules, :phases
    t.switched_off_phases 'more_nodes', 'last_phase'
  end 
  
  }
end

