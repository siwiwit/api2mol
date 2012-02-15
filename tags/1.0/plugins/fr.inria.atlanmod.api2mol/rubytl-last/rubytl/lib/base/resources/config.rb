

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

        @serializer_options = SerializerConfig.new 
        @parser_config = ParserConfig.new
      end
       
      def initialize_copy(others)
        @workspace          = others.workspace.dup
        @serializer_options = others.serializer_options.dup
        @parser_config      = others.parsing.dup
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

      def serializer_options
        @serializer_options
      end

      def parsing
        @parser_config
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

    class SerializerConfig
      attr_accessor :serializer_class
       
      def initialize
        @serializer_class = RMOF::ECore::Serializer
      end
    end

    class ParserConfig
      attr_accessor :model_parser_impl

      SAX_VERSION = lambda { |path, adapter| 
        require 'rmof/parsing/sax_ecore'
        RMOF::SAXEcoreParser.new(File.new(path), adapter, :file_path => path).parse
      } 
      DOM_VERSION = lambda { |path, adapter| 
        file = File.new(path)
        xml_reader = RMOF::XMLReaderAdapter.load(file)   
        parser = RMOF::FormatGuesser.guess(xml_reader, RMOF::ECoreParser)
        parser.new(xml_reader, adapter, :file_path => file.path).parse() 
      }
     
      def initialize
        @model_parser_impl = DOM_VERSION                
      end      

      def rmof_model_parse(path, adapter)
        @model_parser_impl.call(path, adapter)
      end

    end

  end
end
