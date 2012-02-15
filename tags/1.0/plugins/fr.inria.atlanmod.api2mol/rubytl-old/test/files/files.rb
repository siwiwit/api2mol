

module RubyTL
  module TestFiles
    FILES_ROOT      = File.join(File.dirname(__FILE__))
    TRANSFORMATIONS_ROOT = File.join(FILES_ROOT, "transformations")
    VALIDATIONS_ROOT = File.join(FILES_ROOT, "validations")
    METAMODELS_ROOT = File.join(FILES_ROOT, "metamodels")
    MODELS_ROOT     = File.join(FILES_ROOT, "models")
    XML_ROOT        = File.join(FILES_ROOT, "xsd")
    
    include RubyTL::Base
    
    def self.library_source_model
      ModelInformation.new('Library', 
                           metamodel_get('Library.ecore'),
                           model_get('library.ecore.xmi'))
    end 
    
    def self.class_source_model
      ModelInformation.new('ClassM', metamodel_get('ClassM.ecore'),
                           model_get('class_model.ecore.xmi'))    
    end

    def self.package_model
      ModelInformation.new('Pkg', metamodel_get('Packages.ecore'),
                           model_get('Packages.xmi'))    
    end

    def self.relational_target_model
      ModelInformation.new('TableM', metamodel_get('TableM.ecore'),
                           memory_model('relational'))        
    end

    def self.ship_order_xml_model
      ModelInformation.new('SO', ship_order_xsd_named_types, ship_order_xml)
    end
    
    def self.test_xml_model
      ModelInformation.new('Test', xml_file('test.xsd'), xml_file('test.xml'))
    end

    def self.cst_model
      ModelInformation.new('CST', metamodel_get('CST.ecore'),
                           model_get('cst.xmi'))    
    end
    
    def self.klass2table_transformation
      transformation_get('class2table.rb')
    end
    
    def self.klass2table_phases_transformation
      transformation_get('class2table.phasing.rb')
    end    

    def self.klass_validate_persons
      validation_get('validate_persons.rb')
    end    
  
    def self.ship_order_xsd
      xml_file 'shiporder.simple.xsd'
    end

    def self.ship_order_xsd_named_types
      xml_file 'shiporder.namedtypes.xsd'
    end

  
    def self.ship_order_xml
      xml_file 'shiporder.xml'
    end
  
    def self.test_xfm
      xml_file File.join('variants', 'test.xfm')
    end

    def self.test_vdm_model
      ModelInformation.new('TVDM', test_xfm,
                           xml_file(File.join('variants', 'test.vdm')))            
    end
          
  private
    def self.validation_get(name)
      Resource.new( File.join(VALIDATIONS_ROOT, name) )     
    end
  
    def self.transformation_get(name)
      Resource.new( File.join(TRANSFORMATIONS_ROOT, name) )    
    end
  
    def self.metamodel_get(name)
      Resource.new( File.join(METAMODELS_ROOT, name) )
    end    

    def self.model_get(name)
      Resource.new( File.join(MODELS_ROOT, name) )
    end    
    
    def self.memory_model(name)
      Resource.new("memory://#{name}")
    end
    
    def self.xml_file(name)
      Resource.new( File.join(XML_ROOT, name) )
    end
  end
end