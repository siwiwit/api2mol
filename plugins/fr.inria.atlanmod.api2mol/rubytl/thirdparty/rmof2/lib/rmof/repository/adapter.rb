require 'uri'
require 'pathname'

module RMOF
module ECore

  # This class is able to deal with ECore models stored in
  # files by mapping logical uris to files.
  #
  # TODO: This class doesn't load generated metamodels on-demand... this is a problem
  # when having many metamodels
  class FileModelAdapter
    class UnableToResolveUri < RuntimeError; end
    URIMapping = Struct.new(:uri, :filename, :model_fragment)
    
    ECORE_FILE   = File.join(RMOF::Config::MODELS_ROOT, 'Ecore.ecore')
    XMLTYPE_FILE = File.join(RMOF::Config::MODELS_ROOT, 'XMLType.ecore')
  
    def initialize(cache_repository = nil)
      @mappings = { 
#        'http://www.eclipse.org/emf/2002/Ecore'   => ECORE_FILE,
        'http://www.eclipse.org/emf/2003/XMLType' => 
              URIMapping.new('http://www.eclipse.org/emf/2003/XMLType', XMLTYPE_FILE, nil)
      }
      
      @loaded = { }
      @cache = cache_repository || CacheRepository.new(RMOF::Config::CACHE_DIR)
    end
       
    # Add a new uri-to-file mapping.
    #
    # == Arguments
    # 
    # * <tt>uri</tt>. The original uri (a string).
    # * <tt>file</tt>. To which file it will be mapped.
    # * <tt>model_part</tt>. An id or a path to a certain element of the model
    #
    def add_mapping(uri, file, model_part = nil)
      @mappings[uri] = URIMapping.new(uri, File.expand_path(file), model_part)
    end

    def add_uri_mapping(uri, uri2)
      @mappings[uri] = uri2    
    end
    
    # Returns true if it can handle a given path (either a uri or a file path).
    # Handling a path means loading model or metamodel associated to the given
    # path, but without parsing.
    def can_handle?(path)
      resolve_metamodel(path) || @loaded[path]
    end
    
    def mappings
      @mappings
    end   
    
    # Resolve a given uri returning the corresponding model.
    # The uri is resolved looking up the mappings table recursively,
    # for instance, given this mappings:
    #
    #    'http://www.eclipse.org/emf/2002/Ecore' => '/tmp/Ecore.ecore'
    #    'test://www.example.com/ecore' => 'http://www.eclipse.org/emf/2002/Ecore'
    #
    # the result for <tt>delegate.resolve_uri('test://www.example.com/ecore')</tt> 
    # is <tt>'/tmp/Ecore.ecore'</tt>
    #
    def resolve_uri(uri, base_file = nil)
      # TODO: Just for testing
      if uri == '../../../plugin/org.eclipse.emf.ecore/model/Ecore.ecore'
        uri = 'http://www.eclipse.org/emf/2002/Ecore'
      end
      if metamodel = resolve_metamodel(uri)
        return metamodel 
      end

      uri_mapping = resolve_uri_recursively(uri) || resolve_file_uri(uri)     
      filename = uri_mapping ? uri_mapping.filename : nil

      # Try to resolve a local file
      if filename.nil? && base_file
        path = File.join(File.dirname(base_file), uri)
        filename = path if File.exist?(path)
      end

      filename = File.expand_path(filename) unless filename.nil?

      raise UnableToResolveUri.new("URI not registered #{uri}")  unless filename
      raise UnableToResolveUri.new("File not found #{filename} for uri #{uri}") unless File.exist?(filename)
      if not @loaded[filename]
        file = File.new(filename)
        # document = REXML::Document.new(file)
        # parser = FormatGuesser.guess(document, ECoreParser)
        # parser.new(document, self, :file_path => file.path).parse()
        xml_adapter = RMOF::XMLReaderAdapter.load(file)
        parser      = FormatGuesser.guess(xml_adapter, ECoreParser)
        parser.new(xml_adapter, self, :file_path => file.path).parse()
      end
      model = @loaded[filename]
      
      # The a model containing the element referenced by the model_fragment 
      # is returned
      if uri_mapping && uri_mapping.model_fragment
        return model.fragment_as_model(uri_mapping.model_fragment)
      end

#      if package  
        # TODO: This only works for metamodels...
#        return model.package_as_model(package)
#      end
      return model   
    end
       
    def add_loaded(filename, model)
      @loaded[File.expand_path(filename)] = model
    end
    
    def loaded_get(filename)
      @loaded[File.expand_path(filename)]
    end
        
    # Given the uri of a model, and the path of the file model
    # that reference such a model, a relative path is computed.
    # The uri must be registered in the delegate in some manner (add_mapping or add_loaded).
    #
    # * <tt>uri</tt>. The uri to be resolved as a string
    # * <tt>base_file</tt>.
    def compute_relative_path(uri, base_file)
      uri_mapping = resolve_uri_recursively(uri)
      filepath    = uri_mapping ? uri_mapping.filename : nil
      unless filepath 
        @loaded.each_pair do |path, model| 
          if model.uri == uri
            filepath = path
            break
          end
        end
      end

      if filepath        
        path = Pathname.new(filepath)
        path.relative_path_from(Pathname.new(File.dirname(base_file))).to_s
      end
    end
    
    def compute_relative_file_path(file_uri, base_file)
      uri = URI.parse(file_uri)
      raise "Not an file path" unless uri.scheme == 'file'

      path = Pathname.new(uri.path)
      path.relative_path_from(Pathname.new(File.dirname(base_file))).to_s      
    end
    
  private
    def resolve_metamodel(original_uri)
      resolve_uri_recursively(original_uri) do |uri|
        if @cache.is_registered?(uri)
          return @cache.load_metamodel(uri)
        end     
      end
      return nil
    end

    def resolve_uri_recursively(uri, &block)
      if block_given?
        result = yield(uri) 
        return result if result
      end

      if @mappings.key?(uri)
        mapped_uri = @mappings[uri]
        uri_string = mapped_uri.kind_of?(URIMapping) ? mapped_uri.filename : mapped_uri
        return resolve_uri_recursively(uri_string, &block) || mapped_uri       
      end
      return nil
    end  
    
    def resolve_file_uri(uri_string)
      uri = URI.parse(uri_string)
      return URIMapping.new(uri_string, uri.path, nil) if uri.scheme == 'file'
    rescue URI::InvalidURIError => e
      raise "Invalid uri #{uri_string}"
    end
        
  end

end
end
