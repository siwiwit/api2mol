module RubyTL
  module Mock   
    
    
    # Mock classes
    class TestHandler < RubyTL::Base::ModelHandler
    
      def initialize(file_extension)
        @file_extension = file_extension
      end
      
      def support?(model_information)
        return model_information.metamodel.file_extension == @file_extension
      end
    
      def load(model_information)
        return TestLoadedModel.new(model_information)
      end 
    
      def new_model(model_information)
        return TestLoadedModel.new(model_information)
      end
    end
    
    class TestLoadedModel < RubyTL::Base::LoadedModel
      def initialize(model_information)
        super(model_information, nil)
      end
    end

  end
end