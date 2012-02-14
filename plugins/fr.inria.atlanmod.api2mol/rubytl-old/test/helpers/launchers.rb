
module RubyTL
  module TestLaunchers
    
    def rubytl_launcher_class2table        
      RubyTL::Rtl::Launcher.new(:source_models => [RubyTL::TestFiles.class_source_model],
                                :target_models => [RubyTL::TestFiles.relational_target_model],
                                :dsl_file => RubyTL::TestFiles.klass2table_transformation)
    end
      
    def rubytl_launcher_class2table_phases
      RubyTL::Rtl::Launcher.new(:source_models => [RubyTL::TestFiles.class_source_model],
                                :target_models => [RubyTL::TestFiles.relational_target_model],
                                :dsl_file => RubyTL::TestFiles.klass2table_phases_transformation)
    end
      
    def checker_launcher_classes
      RubyTL::Checker::Launcher.new(:source_models => [RubyTL::TestFiles.class_source_model],
                                    :dsl_file => RubyTL::TestFiles.klass_validate_persons)
    end
    
    
  end    
  
end