

class CreationTest < Test::Unit::TestCase  
  include TestHelper

  def setup
    set_plugin_path(__FILE__)
  end

  def test_creation
    rubytl = RubyTL::Launcher.new(:source_metamodel => plugin_file('AB.xmi'), 
                                  :target_metamodel => plugin_file('CD.xmi'), 
                                  :source_model     => plugin_file('ABModel.xmi'), 
                                  :module => 'InstacesOf_D_ShouldBeCreated', :serialize => false,
                                  :transformation   => creation)
    rubytl.selected_plugins = [:default, :copy_rules]
    rubytl.evaluate   
    
    ab, cd = packages(rubytl)    
    bes = ab.all_objects_of(ab::B)
    des = cd.all_objects_of(cd::D)
    
    assert_equal bes.size * 2, des.size       
  end
  

end


def creation
<<-TRANSFORMATION
#module InstacesOf_D_ShouldBeCreated
  rule 'A' do
    from    AB::A
    to      CD::C
        
    mapping do |a, c|
      c.name = a.name
      # Bindings must be executed two times
      c.des = a.bes
      c.des = a.bes      
    end
  end
    
  copy_rule 'createD' do            
    from    AB::B
    to      CD::D
    mapping do |c, d|
      d.name = c.name 
    end
  end
#end
TRANSFORMATION
end