# This is the interface with the underlying building system.
# Currently, only Rake is supported.
#

module RubyTL
  module Base
  
    # This class is the interface with the Rake building system.
    # It allows task to be launched, preparing the information
    # they may need for their proper execution.
    #
    class RakeBuildSystem
      
      # Creates a new instance of this interface to the Rake build system.
      # The configuration object (+config+) will be used as the global configuration
      # all tasks (i.e. no concurrency is allowed).
      def initialize(config)
        @config = config
        RubyTL::Base::BaseTaskLib.config = @config
      end
      
      def launch(rakefile, raketask)      
        workspace = @config.workspace 
        rakefile  = workspace.create_resource(rakefile)    
        
        check_resources(workspace.root_path, rakefile)
        set_constants(workspace.root_path, rakefile, raketask)

        if load_rakefile(rakefile)
          measure_global_time(rakefile, raketask) do
            launch_task(rakefile, raketask)
          end
        end
      end

    private    
    
      def set_constants(basedir, rakefile, raketask)
        Kernel.const_set('PROJECT_DIR', basedir)
        Kernel.const_set('EXECUTING_RAKEFILE', rakefile)
        Kernel.const_set('EXECUTING_TASK', raketask)
      end  
      
      def check_resources(basedir, rakefile)
        raise "Invalid base dir '#{basedir}'"          unless File.exist?(basedir)
        raise "File not found '#{rakefile.file_path}'" unless rakefile.file_exist?      
      end

      def load_rakefile(rakefile)
        eval(rakefile.read, nil, rakefile.file_path)
        true
      rescue RubyTL::BaseError => e
        $stderr << "Error (rakefile: #{rakefile.file_path})" + $/
        e.print_error($stderr, rakefile.file_path)
        false
      end

      def launch_task(rakefile, raketask)
        raise "Task '#{raketask}' does not exist in #{rakefile.file_path}" unless Rake::Task.task_defined?(raketask.intern)
      
        Rake::Task[raketask.intern].invoke
        true
      rescue RubyTL::RubySyntaxError, RubyTL::EvaluationError => e
        e.print_error($stderr, e.filenames)
        false
      rescue RubyTL::BaseError => e
        $stderr << "Error (rakefile: #{rakefile.file_path})" + $/
        e.print_error($stderr, rakefile.file_path)
        false
      end      

      def measure_global_time(rakefile, raketask)
        start = Time.now
        is_ok = yield
        finish = Time.now
        if is_ok == true
          $stdout << "Finished task '#{raketask}' in '#{rakefile.basename}'" + $/
          $stdout << "Time: #{finish - start} seconds" + $/
        end
        is_ok
      end

    end
  
  end
end
    
    
