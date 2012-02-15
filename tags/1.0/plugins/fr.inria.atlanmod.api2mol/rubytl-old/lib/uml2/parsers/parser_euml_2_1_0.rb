


module RubyTL
  module UML2
    module Parsers

      class EUml2_1_0 < RMOF::EMofParser
        
        def initialize(file, adapter, options = {})
          super(file, adapter, options)
          adapter.add_uri_mapping('pathmap://UML_METAMODELS/UML.metamodel.uml', 'http://www.eclipse.org/uml2/2.1.0/UML')                    
          

          adapter.add_mapping('pathmap://UML_LIBRARIES/UMLPrimitiveTypes.library.uml', 
                              File.join(UML2_MODELS, 'UML2_1_0.PrimitiveTypes.library.uml'))
        end

# TODO: XXXXXXXXXXXXX !!!!!!!!!!! BORRAR
    def instantiate_metaclass(metaclass_name, uri)
      model = @adapter.resolve_uri(uri)  
      @model.add_to_referenced_models(model) if model != @model
      
      if model.respond_to? :instantiate_metaclass
        model.instantiate_metaclass(metaclass_name)
      else
        metaclass = model.lookup_object('//' + metaclass_name)
        puts metaclass.name
        metaclass.new_instance
      end         
    end



      end
    end
  end
end