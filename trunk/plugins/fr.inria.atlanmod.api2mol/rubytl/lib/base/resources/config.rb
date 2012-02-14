

module RubyTL
  module Base
    
    #
    # Class containing configuration information the user can set.
    #
    # * <tt>available_handlers</tt>
    # * <tt>uri mappings</tt>. A list of UriModelMapping objects
    #
    class Configuration
      #attr_reader :available_handlers
      attr_reader :workspace
      #attr_reader :uri_mappings
      
      def initialize(workspace = nil)
        @uri_mappings = []
        @workspace = workspace || Workspace.new(Dir.pwd)        
      end
      
      def self.handler_klasses
        @handler_klasses ||= [] 
      end
      
      def available_handlers
        @available_handlers ||= self.class.handler_klasses.map { |k| k.new(self) }
      end
      
      def self.read_config_file(config_file)
        raise "TODO: Configure externally..."
      end     
      
      def self.basic(basedir)
        Configuration.new(Workspace.new(basedir))
      end 
      
      def add_uri_mapping(mapping)
        self.available_handlers.select { |h| h.respond_to? :add_mapping }.
                                each { |h| h.add_mapping(mapping)}
      end
    end
    
    class UriModelMapping
      attr_reader :uri
      attr_reader :resource_name
      attr_reader :fragment
      
      def initialize(uri, resource_name, fragment)
        @uri = uri
        @resource_name = resource_name
        @fragment = fragment
      end
      
      def is_uri_to_uri?
        return Resource.new(@resource_name).is_uri?
      end
    end

  end
end