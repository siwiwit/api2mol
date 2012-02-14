$stdout.sync = true

class ExplicitCallsTest < Test::Unit::TestCase  
  include TestHelper

  def setup
    set_plugin_path(__FILE__)
  end

  def test_explicit_calls
    rubytl = RubyTL::Launcher.new(:source_metamodel => plugin_file('AB.xmi'), 
                                  :target_metamodel => plugin_file('CD.xmi'), 
                                  :source_model     => plugin_file('ABModel.xmi'), 
                                  :module => 'ExplicitCall', :serialize => false,
                                  :transformation   => explicit_calls)

    rubytl.selected_plugins = [:default, :explicit_calls]
    rubytl.evaluate

    ab, cd = packages(rubytl)    
    aes = ab.all_objects_of(ab::A)
    des = cd.all_objects_of(cd::D)

    assert_equal aes.size, des.size
  end

  def test_explicit_calls_without_creation
    rubytl = RubyTL::Launcher.new(:source_metamodel => plugin_file('AB.xmi'), 
                                  :target_metamodel => plugin_file('CD.xmi'), 
                                  :source_model     => plugin_file('ABModel.xmi'), 
                                  :module => 'ExplicitCallWithoutCreation', :serialize => false,
                                  :transformation   => explicit_calls_without_creation)
    rubytl.selected_plugins = [:default, :explicit_calls]
    rubytl.evaluate

    ab, cd = packages(rubytl)    
    aes = ab.all_objects_of(ab::A)
    des = cd.all_objects_of(cd::D)

    assert_equal aes.size, des.size
  end  
    
  def test_explicit_calls_with_creation
    rubytl = RubyTL::Launcher.new(:source_metamodel => plugin_file('AB.xmi'), 
                                  :target_metamodel => plugin_file('CD.xmi'), 
                                  :source_model     => plugin_file('ABModel.xmi'), 
                                  :module => 'ExplicitCallWithCreation', :serialize => false,
                                  :transformation   => explicit_calls_with_creation)
    rubytl.selected_plugins = [:default, :copy_rules, :explicit_calls]
    rubytl.evaluate

    ab, cd = packages(rubytl)    
    aes = ab.all_objects_of(ab::A)
    des = cd.all_objects_of(cd::D)

    assert_equal 3 * aes.size, des.size
  end  
end


def explicit_calls
<<-END_OF
rule 'A2C' do
  from    AB::A
  to      CD::C          
  mapping do |a, c|
    ExplicitCall(a)
  end
end
      
rule 'ExplicitCall' do            
  from    AB::A
  to      CD::D
  mapping do |a,d|
    d.name = a.name
  end
end
END_OF
end

def explicit_calls_without_creation
<<-END_OF
    rule 'A2C' do
      from    AB::A
      to      CD::C          
      mapping do |a, c|
        ExplicitCall(a)
        ExplicitCall(a)
        ExplicitCall(a)
      end
    end
      
    rule 'ExplicitCall' do            
      from    AB::A
      to      CD::D
      mapping do |a,d|
        d.name = a.name
      end
    end
END_OF
end
def explicit_calls_with_creation
<<-END_OF
    rule 'A2C' do
      from    AB::A
      to      CD::C          
      mapping do |a, c|
        ExplicitCall(a)
        ExplicitCall(a)
        ExplicitCall(a)
      end
    end
      
    copy_rule 'ExplicitCall' do            
      from    AB::A
      to      CD::D
      mapping do |a,d|
        d.name = a.name
      end
    end
END_OF
end