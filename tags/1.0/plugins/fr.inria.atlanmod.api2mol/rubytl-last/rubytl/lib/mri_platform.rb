
class MRIPlatform  
  
  def require_model_libraries
    thirdparty = File.join(RUBYTL_ROOT, '..', 'thirdparty')
    if File.exist?(File.join(thirdparty, 'rmof2', 'setup.rb'))
      $LOAD_PATH << File.join(RUBYTL_ROOT, '..', 'thirdparty', 'rmof2', 'lib')
      require 'rmof'
    else
      $LOAD_PATH << File.join(RUBYTL_ROOT, '..', 'thirdparty')
      require 'rmof2/lib/rmof'
    end    
    
    setup_rmof_repository
  end
  
  def require_rake
    # Load Rake
    begin
      require 'rubygems'
      require 'rake'
    rescue LoadError => e
      $LOAD_PATH << File.join(RUBYTL_ROOT, '..', 'thirdparty', 'rake')
      require 'rake'
    end    
  end
  
  def require_components
    require 'dsldef/dsldef'
    require 'rubytl/rubytl'
    require 'rgen/rgen'
    require 'checker/checker'
    require 'bnf/bnf'
    #require 'model_testing/model_testing'
    require 'uml2/uml2'
    require 'xsd/xsd'
    require 'walker/walker'
    require 'scripting/script_task' # TODO: Create an "scripting" component
    RubyTL::Base::Configuration.handler_klasses << RubyTL::SimpleRMOFHandler    
  end
  
  def load_rubytl_models
    Kernel.const_set 'RUBYTL_MODELS', File.join(RUBYTL_ROOT, 'rubytl', 'models')
    RUBYTL_REPOSITORY.merge RMOF::CacheRepository.new(File.join(RUBYTL_MODELS, 'cache'))
    Kernel.const_set 'RUBYTL_TRACE_MODEL_NAME', 'http://gts.inf.um.es/rubytl/trace'
    RUBYTL_REPOSITORY.load_metamodel(RUBYTL_TRACE_MODEL_NAME)    
  end
  
protected
  def setup_rmof_repository

#require 'base/repository/stream_serializer' # TODO: Remove when stream serializer migrated to rmof

    Kernel.const_set 'RUBYTL_REPOSITORY', RMOF::CacheMerger.new(RMOF::CacheRepository.new(RMOF::Config::RMOF_CACHE_DIR))
    Kernel::RUBYTL_REPOSITORY.load_metamodel('http://www.eclipse.org/emf/2002/Ecore')    
    eval RMOF_PATCH
  end
end

RMOF_PATCH = %{
# ONLY IN WINDOWS, CHECK IT
if RUBY_PLATFORM =~ /win/ 
class RMOF::ECore::FileModelAdapter
    def compute_relative_file_path(file_uri, base_file)
      uri = convert_to_uri(file_uri)
      raise "Not a file path" unless uri.scheme == 'file'

      path = Pathname.new(uri.path)
      path.relative_path_from(Pathname.new(File.dirname(base_file))).to_s     
    end

    def resolve_file_uri(uri_string)
      uri = convert_to_uri(uri_string)
      return URIMapping.new(uri_string, uri.path, nil) if uri.scheme == 'file'
    rescue URI::InvalidURIError => e
      raise "Invalid uri \#{uri_string}"
    end

    FakeURI = Struct.new(:path, :scheme)
    def convert_to_uri(uri_string)
      uri_string =~ /^((\\w+):\\/\\/)?(.+)/
      FakeURI.new($3, $2)         
    end
end
end
}
