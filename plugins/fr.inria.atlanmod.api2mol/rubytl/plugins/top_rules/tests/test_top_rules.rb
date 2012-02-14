$stdout.sync = true

class TopRulesTest < Test::Unit::TestCase  
  include TestHelper

  def setup
    set_plugin_path(__FILE__)
  end
 

  def test_only_top_rules
    rubytl = RubyTL::Launcher.new(:source_metamodel => plugin_file('AB.xmi'), 
                                  :target_metamodel => plugin_file('CD.xmi'), 
                                  :source_model     => plugin_file('ABModel.xmi'), 
                                  :module => 'TestOnlyTops', :serialize => false,
                                  :transformation   => only_tops)
    rubytl.selected_plugins = [:default, :top_rules]
    rubytl.evaluate

    source, target = packages(rubytl)

    aes = source.all_objects_of(source::A)
    ces = target.all_objects_of(target::C)
    des = target.all_objects_of(target::D)

    assert_equal 0, ces.size
    assert_equal aes.size, des.size

  end


  # TODO: Esto falla porque OnlyFirst ya existe y al reescribir la transformaci�n
  # no se asignan bien los puntos de extensi�n... @extension
  def test_fail_top_rules_because_of_the_transformation_name
    rubytl = RubyTL::Launcher.new(:source_metamodel => plugin_file('AB.xmi'), 
                                  :target_metamodel => plugin_file('CD.xmi'), 
                                  :source_model     => plugin_file('ABModel.xmi'), 
                                  :module => 'OnlyFirst', :serialize => false,
                                  :transformation   => only_tops.gsub('TestOnlyTops', 'OnlyFirst'))
    rubytl.selected_plugins = [:default, :top_rules]
    rubytl.evaluate

    source, target = packages(rubytl)

    aes = source.all_objects_of(source::A)
    ces = target.all_objects_of(target::C)
    des = target.all_objects_of(target::D)

    assert_equal 0, ces.size
    assert_equal aes.size, des.size

  end

end

def only_tops
<<-END_OF
#  module TestOnlyTops
    rule 'A2C' do
      from    AB::A
      to      CD::C          
      mapping do |a, c|
        c.name = a.name
      end
    end
      
    top_rule 'A2D' do            
      from    AB::A
      to      CD::D
      mapping do |a,d|
        d.name = a.name
      end
    end
#  end
END_OF
end