

class SettypeTest < Test::Unit::TestCase  
  include TestHelper
  
  def setup
    set_plugin_path(__FILE__)
  end

  def test_set_type
    rubytl = RubyTL::Launcher.new(:source_metamodel => metamodel('class2table/ClassM.emof'),
                                  :target_metamodel => metamodel('class2table/TableM.emof'),
                                  :source_model     => model('class2table/source.rb'),
                                  :module => 'Class2TableSetType', :serialize => false,
                                  :transformation   => plugin_file('class2table.set_type.rb'))
    rubytl.selected_plugins = [:default, :copy_rules, :top_rules, :ignore_conflicts, :explicit_calls, :set_type]
    rubytl.evaluate   
  end

  def test_set_type_with_ecore
    rubytl = RubyTL::Launcher.new(:source_metamodel => metamodel('class2table/ClassM.ecore'),
                                  :target_metamodel => metamodel('class2table/TableM.ecore'),
                                  :source_model     => model('class2table/source.rb'),
                                  :module => 'Class2TableSetType', :serialize => false,
                                  :transformation   => plugin_file('class2table.set_type.rb'))
    rubytl.selected_plugins = [:default, :copy_rules, :top_rules, :ignore_conflicts, :explicit_calls, :set_type]
    rubytl.evaluate   
  end
end

