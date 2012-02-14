module RubyTL
  # TODO: It should be RubyTL::Base

  # A module to support loading helpers within a transformation. Loading helpers
  # is different to requiring a file because, when a file, is required this is done
  # in the global context, while a helper must act in the context of a single 
  # transformation (a transformation context).
  module HelperLoading
  
    # Initialize loading helper facilities.
    #
    # == Arguments
    # * <tt>mod</tt>. The context where helpers will be loaded.
    # * <tt>method_name</tt>. The name of the loading helper method, by default, 'load_helper'
    #
    def load_helper_set(workspace, mod, method_name = 'load_helper')
      (class << self; self; end).send(:define_method, method_name) do |*files|          
          files.each { |f| 
            $stderr << method_name + " is deprecated. Instead try: use_library \"helper://#{f}\"'" + $/
            try_to_load(f, workspace, mod) 
          }
      end
      
      (class << self; self; end).send(:define_method, 'use_library') do |uri|
           try_to_load(uri, workspace, mod)
      end
      
      class << self  
      
        def loaded_helpers
          @loaded_helpers ||= []
        end

      private
        def try_to_load(name, workspace, mod)
          resource = workspace.create_resource(name)
          if resource.is_local_resource? && resource.file_exist?
            mod.module_eval(File.open(resource.file_path, 'r') { |f| f.read }, resource.file_path)
            loaded_helpers << resource.file_path
            return
          end
          raise RubyTL::InvalidHelper.new("Helper '#{name}' not found") 
        end
      end
    end
       
  end
end
