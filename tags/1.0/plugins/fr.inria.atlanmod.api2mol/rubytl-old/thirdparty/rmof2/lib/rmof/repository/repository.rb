require 'yaml'

module RMOF

  # This class maintains a repository of generated metamodels in a given
  # directory. The metamodels are indexed by their URI, and their description 
  # is stored in a file, usually caled 'metamodels.yaml'
  #
  class CacheRepository
    Metamodel = Struct.new(:package, :filename, :module_name, :implementation)
    CACHE_FILENAME = 'metamodels.yaml'
    
    def initialize(directory = nil)
      @directory = directory || RMOF::Config::RMOF_CACHE_DIR
      @metamodels = {}
      @loaded = {}
      load_description_file
    end
    
    # Add a new metamodel to the repository. The metamodel definition is generated
    # as a ruby file using APIGenerator, and the metamodel can be accessed through
    # the uri of package.nsURI.
    #
    # == Arguments
    # * <tt>package</tt>. The root package of the metamodel.
    # * <tt>filename</tt>. The filename of the generated metamodel, relative to the
    #                      directory where the metamodel has been cached.
    # * <tt>options</tt>. 
    # <ul>
    #  <li><tt>:implementation</tt> A relative path where the optional implementation file of the metamodel
    #    can be found. The file will be loaded using 'require', so the path
    #    should be relative any of the directories of $LOAD_PATH. </li>
    #  <li><tt>:top_module</tt></li>. The name of the module to enclose the metamodel.
    # </ul>
    #
    def add_metamodel(package, filename, options = {})
      impl = options[:implementation]
      top_module = options[:top_module]
      ruby_package_name = [top_module, package.name.to_metamodel_name].compact.join('::')
      generate_metamodel(package, filename, options)
      @metamodels[package.nsURI] = Metamodel.new(package.nsURI, filename, 
                                                 ruby_package_name, impl)
      dump_to
    end
  
    # Loads a metamodel with a given +uri+. The generated ruby code is 
    # loaded using 'require'
    # Returns the generated metamodel package (a module)
    def load_metamodel(uri)
      raise RMOF::CachedMetamodelNotExist.new("No metamodel #{uri} exists") unless @metamodels.key?(uri)
      return @loaded[uri] if @loaded.key?(uri)
      
      metamodel = @metamodels[uri]
      require File.join(@directory, metamodel.filename)
      require metamodel.implementation if metamodel.implementation
      
      @loaded[uri] = RMOF::Metamodel.new(eval("::#{metamodel.module_name}"))
    end  

    # Return true if a metamodel corresponding to the given +uri+ is
    # available. 
    def is_registered?(uri)
      return @metamodels.key?(uri)
    end

    # Returns a hash where the keys are the names of the available metamodels,
    # and the values are their URI
    def metamodels
      @metamodels.keys.inject({}) do |acc,key|
        acc.merge(@metamodels[key]['module_name'] => key)
      end
    end
    
  private
    def load_description_file
      if RUBY_VERSION =~ /1\.9/
	File.open(description_file) do |f|
		t = f.read.gsub("package:", ":package:").
			gsub("filename:", ":filename:").
			gsub("module_name:", ":module_name:").
			gsub("implementation:", ":implementation:")
		@metamodels.merge!(YAML::load(StringIO.new(t)))		
	end
      else
      	@metamodels.merge!(YAML::load_file(description_file)) if File.exist?(description_file)
      end    
    end
  
    def generate_metamodel(package, filename, options = {})
      configuration = ::ECore::APIConfiguration.new
      configuration.filename = filename
      configuration.top_module = options[:top_module]
    
      generator = ::ECore::APIGenerator.new(@directory, configuration)
      generator.generate_metamodel(package)
    end
  
    def dump_to
      File.open(description_file, "w") do |out|
        YAML::dump(@metamodels, out)
      end
    end 
    
    def description_file
      File.join(@directory, CACHE_FILENAME)
    end
  end

  # This class agreggates several CacheRepository objects so that
  # several caches can be queried at once. The requisite is that
  # they must store metamodels with independent uris each other.
  #
  # It provides the is_registered?, load_metamodel, and metamodels,
  # so that it can be used as if it were a read-only CacheRepository
  class CacheMerger
    
    def initialize(*repositories)
      @repositories = repositories.dup
      @loaded = {}
    end

    def merge(*repositories)
      @repositories.push(*repositories)
    end

    def load_metamodel(uri)
      return @loaded[uri] if @loaded.key?(uri)
      repository = @repositories.find { |r| r.is_registered?(uri) }
      raise RMOF::CachedMetamodelNotExist.new("No metamodel #{uri} exists") unless repository
      
      @loaded[uri] = repository.load_metamodel(uri)
    end  

    # Return true if a metamodel corresponding to the given +uri+ is
    # available. 
    def is_registered?(uri)
      return @loaded.key?(uri) || @repositories.any? { |r| r.is_registered?(uri) }
    end

    # Returns a hash where the keys are the names of the available metamodels,
    # and the values are their URI
    def metamodels
      @repositories.inject({}) { |acc, r| acc.merge(r.metamodels) }
    end
    
  end

end
