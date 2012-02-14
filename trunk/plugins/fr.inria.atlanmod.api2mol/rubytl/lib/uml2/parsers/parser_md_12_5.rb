module RubyTL::UML2
  module Parsers
    class ParserMD_12_5 < RMOF::EMofParser
      include RubyTL::UML2::Parsers::Helper

      def initialize(file, adapter, options = {})
        super(file, adapter, options)
        $stdout << "UML2: " + @file_path + $/
        $stdout.flush
        adapter.add_uri_mapping('http://schema.omg.org/spec/UML/2.0/uml.xml', 'http://schema.omg.org/spec/UML/2.0')
      # TODO: Parametrize
        adapter.add_mapping('UML_Standard_Profile.xml', File.join(UML2_PROFILES, 'UML_Standard_Profile.xml'))
      end

      def parse_element(element, parent_object = nil)
        return nil if skip?(element)
        return super
      end


      # Parameters: ignoredTags
      def skip?(element)
        return true if element.prefix == 'xmi' && element.name == 'Extension' 
        return true if element.prefix == 'xmi' && element.name == 'Documentation' 
        return true if element.prefix == 'MagicDraw_Profile' && element.name =~ /^.+$/ 
      end      

      def href_get(element)
        element.attributes['href'] || element.attributes['xmi:idref']
      end

      def resolve_href(reference, object, href)
        proc = super.last
        #create_reference_resolver(reference, object, href)
        if reference.name == 'importedProfile'
        	proc.call
        	# TODO: Delete from pending tasks
            importProfile(object.importedProfile, href)
       
        	
        end
      end
    end
  end
end
