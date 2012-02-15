
module REXML
  module Encoding
    def encoding=(enc)
      self.overriden_encoding = enc
    end
  
    def overriden_encoding=( enc )
      old_verbosity = $VERBOSE
      begin
        $VERBOSE = false
        return if defined? @encoding and enc == @encoding
        if enc and enc != UTF_8
          @encoding = enc.upcase
          begin
            require 'rexml/encodings/ICONV.rb'
            Encoding.apply(self, "ICONV")
          rescue LoadError, Exception => err    
            raise ArgumentError, "Bad encoding name #@encoding" unless @encoding =~ /^[\w-]+$/
            @encoding.untaint 
            enc_file = File.join( "rexml", "encodings", "#@encoding.rb" )
            begin              
              $stderr << "Warning: Install ICONV to handle ASCII encoding properly" + $/ if @encoding == 'ASCII' 
              require enc_file if @encoding != 'ASCII'
              Encoding.apply(self, @encoding)
            rescue LoadError
              puts $!.message
              raise ArgumentError, "No decoder found for encoding #@encoding.  Please install iconv."
            end
          end
        else
          @encoding = UTF_8
          require 'rexml/encodings/UTF-8.rb'
          Encoding.apply(self, @encoding)
        end
      ensure
        $VERBOSE = old_verbosity
      end
    end
  end
end

module REXML
  class XMLDecl < Child
    def encoding=( enc )
      if enc.nil?
        self.overriden_encoding = "UTF-8"
        @writeencoding = false
      else
        self.overriden_encoding = enc
        @writeencoding = true
      end
      self.dowrite
    end
  end
end

module REXML
  module Encoding
    # Convert from UTF-8
    def encode_ascii content
      array_utf8 = content.unpack('U*')
      array_enc = []
      array_utf8.each do |num|
        if num <= 0x7F
          array_enc << num
        else
          # Numeric entity (&#nnnn;); shard by  Stefan Scholl
          array_enc.concat "&\##{num};".unpack('C*')
        end
      end
      array_enc.pack('C*')
    end

    # Convert to UTF-8
    def decode_ascii(str)
      str.unpack('C*').pack('U*')
    end

    register("ASCII") do |obj|
      class << obj
        alias decode decode_ascii
        alias encode encode_ascii
      end
    end
  end
end
