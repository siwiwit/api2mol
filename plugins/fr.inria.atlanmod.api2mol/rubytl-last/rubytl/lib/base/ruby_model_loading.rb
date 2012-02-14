
module RubyTL
  module Base
  
    # It needs to be included in a class providing the @config variable
    # 
    module RubyModelLoading
      def load_ruby_source_model(filename, proxy, name_for_ruby_model)
        mod = Module.new do
          extend RubyTL::HelperLoading
        end
        mod.load_helper_set(@config.workspace, mod)
        mod.const_set(name_for_ruby_model, proxy)
        File.open(filename, 'r') do |f|
          mod.class_eval f.read, filename
        end
      end    
    end
  
  end
end