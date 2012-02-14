require 'pathname'

module RubyTL
  module Base
    
    # Necesito:
    # 
    # * Acceso a los URI mappings de RMOF para los modelos
    # * Mappings de URI a files
    # * tener search_paths para los paths incompletos (s�lo lectura...) || root_path
    # 
    class Workspace
      attr_reader :root_path
      attr_reader :load_path
      
      # Creates a new workspace.
      # 
      # == Arguments
      # 
      # * <tt>root_path</tt>. The root directory to find relative paths.
      #
      def initialize(root_path)
        @root_path = root_path
        @load_path = []
      end
      
      def create_resource(path)
        resource = Resource.new(path, self)
        return resource
      end
    end
    
    class Resource
      REJECT             = 3
      CONDITIONAL_ACCEPT = 2
      ACCEPT             = 1    
      
      # Optional. If the resource is part of a workspace
      attr_reader :workspace
      
      # Resource is a factory. Each inherited class is automatically
      # registered. When Resource.new is called the property subclass
      # is selected.
      class << self
        def inherited(resource_klass)
          return self.superclass.inherited(resource_klass) if self.superclass != Object
          @resource_klasses ||= []
          @resource_klasses << resource_klass        
        end
        
        alias_method :old_new, :new
        def new(path, workspace = nil)
          if self.name == 'RubyTL::Base::Resource'
            return @resource_klasses.sort_by { |klass| klass.can_handle_path?(path) }.first.new(path, workspace)
          end 
          old_new(path, workspace)
        end
      end
      
      def initialize(path, workspace = nil)
        @path = path
        @workspace = workspace
      end
      
      def is_local_resource?; false; end
      def is_uri?; false; end
      
#      def file_extension
#        extract_file_extension(@path)
#      end
      
    end
    
    # Module providing the duck-typed interface for local resources
    # stored in the filesystem.
    # The mix-in must be initialized calling, initialize_file_resource
    module LocalFileResource
      
      def initialize_file_resource(path, workspace)
        @pathname = Pathname.new(detect_w32(path))
        if workspace && @pathname.relative? 
          @pathname = Pathname.new(workspace.root_path).join(@pathname)
        end
      end
      
      def is_local_resource?; true; end
      
      def basename
        @pathname.basename
      end
      
      def file_extension
        @pathname.extname.sub('.', '')
      end
      
      # Returns the path of the resource in the filesystem.
      # The path is cleaned, so that innecessary path fragments
      # are removed.
      def file_path
        File.expand_path Pathname.new(inverse_w32(@pathname.to_s)).cleanpath.to_s
      end
      
      def file_path_as_uri
        'file:/' + self.file_path
      end
      
      # Check whether the resource exists in the file system or not.
      # Returns true if the resource already exists
      def file_exist?
        File.exist?(inverse_w32(@pathname.to_s))
      end
      
      def read
        Pathname.new(inverse_w32(@pathname.to_s)).read
      end
      
      # Copy the resource to a given file.
      # 
      # == Arguments
      # * <tt>path</tt>. The path where the resource will be copied.
      #
      def copy_to(path)
        FileUtils.cp(self.file_path, path)
      end
      
      # Return true, since the resource can be written in a file.
      def is_persistible?; true; end
      
      private
      def detect_w32(path)
        return '/' + path if path =~ /^[A-Z]:(\\|\/)/
        return path
      end
      
      def inverse_w32(path)
        return path[1..-1] if path =~ /^\/[A-Z]:(\\|\/)/
        return path
      end    
    end
    
    class FileResource < Resource
      include LocalFileResource
      
      def initialize(path, workspace = nil)
        super(path, workspace)
        initialize_file_resource(path, workspace)
      end 
      
      def self.can_handle_path?(path)
        return Resource::ACCEPT if ! (path =~ /:\/(\/)?/)
        return Resource::REJECT
      end    
      
    end
    
    class UriResource < Resource
      def self.can_handle_path?(path)
        return Resource::CONDITIONAL_ACCEPT if (path =~ /:\/(\/)?/)
        return Resource::REJECT
      end    
      
      def is_uri?; true; end
      
      def uri_string      
        @path
      end
      
      def is_persistible?
        false
      end
      
      private
      def extract_uri(regexp, path)
        path.sub(regexp, '')
      end  
    end
    
    class MemoryResource < UriResource
      def self.can_handle_path?(path)
        return Resource::ACCEPT if path =~ /^memory:/
        return Resource::REJECT        
      end
    end
    
    module DirBasedUriResource 
      include LocalFileResource
      def self.included(mod)
        def mod.can_handle_path?(path)
          return Resource::ACCEPT if path =~ matched_uri
          return Resource::REJECT        
        end    			
      end
      
      def initialize(path, workspace = nil)
        super(path, workspace)
        abs_path = lookup_file(workspace, extract_uri(self.class.matched_uri, path))
        initialize_file_resource(abs_path, workspace)
      end
      
      protected
      
      def lookup_file(workspace, path)
        try = []
        ([workspace.root_path] + workspace.load_path).each do |prefix_path|
          self.class.directories.each do |dir|
            try << File.join(prefix_path, dir, path)
            try << File.join(prefix_path, dir, path + '.rb')
          end
        end
        
        try.each do |f|
          return f if File.exist?(f)
        end       
        return try.last
      end			
    end
    
    class HelperResource < UriResource         
      include DirBasedUriResource
      def self.matched_uri; /^helper:\/\//; end      
      def self.directories; ['helpers']; end
    end  
    
    class TemplateResource < UriResource         
      include DirBasedUriResource
      def self.matched_uri; /^(tpl|template):\/\//; end      
      def self.directories; ['templates', File.join('transformations', 'templates')]; end
    end  
    
    class LibraryResource < UriResource         
      include DirBasedUriResource
      def self.matched_uri; /^library:\/\//; end      
      def lookup_file(workspace, path)
        path = path + '.rb' unless path =~ /\.rb$/
        return File.join(RUBYTL_ROOT, 'library', path) 
      end						
    end  
    
    class M2MResource < UriResource
      include DirBasedUriResource
      def self.matched_uri; /^m2m:\/\//; end      
      def self.directories; ['transformations', File.join('transformations', 'm2m')]; end			
    end
    
    class ModelResource < UriResource
      include DirBasedUriResource
      def self.matched_uri; /^mo:\/\//; end      
      def self.directories; ['models']; end			
    end
    
    class DSLDefResource < UriResource
      include DirBasedUriResource
      def self.matched_uri; /^dsl:\/\//; end      
      def self.directories; ['dsls']; end			
    end
    
  end
end