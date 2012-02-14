
module RubyTL
  module UML2  
    module Parsers
      module Helper
    
        def importProfile(profile, href)
          prefix = to_magic_draw_prefix(profile.name)
          uri = @root.attributes["xmlns:#{prefix}"]
          file, id = parse_file_location(href)
          # TODO: I don't like this solution. A better way is to improve RMOF search path...
          if mapping = @adapter.mappings[file]
            if mapping.respond_to? :filename
              @adapter.add_mapping(uri, mapping.filename, id)
            end
          else
            file = File.join(File.dirname(@file_path), file) if @file_path
            @adapter.add_mapping(uri, file, id)          
          end
        end
    
    
      private
        def to_magic_draw_prefix(profile_name)
          profile_name.gsub(/\W/, '_')
        end 
      end
    end  
  end
end