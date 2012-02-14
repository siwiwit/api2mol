require 'rexml/document'
require 'ostruct'
require 'logger'

module ECore
  class EOpenStruct < OpenStruct
    include ECore::Helper
    undef_method :eReferences, :eAttributes
  end

  # This class parse the XMI Ecore definition (usually an ECore.ecore file)
  # and generates an in-memory data structure that can be used to generate
  # Ruby code.
  #
  class SpecificParser
    MATCH_TYPE           = /#\/\/(\w+)$/
    MATCH_REFERENCE_TYPE = /#\/\/(\w+)\/(\w+)$/    
    MATCH_DATA_TYPE      = /#\/\/(\w+)$/ 
                    # /^ecore:EDataType.+#\/\/(\w+)$/
  
    def initialize(io_or_string)
      @document = REXML::Document.new(io_or_string)
      @logger   = Logger.new(STDOUT)
      
      # parser support variables
      @eclasses = {}
      @datatypes = {}
      @pending_tasks = []
    end

    def parse 
      package_element = @document.root
      assert package_element.name == 'EPackage'
      
      package = fill_attributes(package_element, create_package)
      
      # Ecore doesn't have subpackages
      package.eSubpackages = []
      
      # Parse EClasses, DataTypes      
      parse_eclasses(package_element, package)
      parse_datatypes(package_element, package)
      parse_enumerations(package_element, package)
      
      # Finally, handle pending tasks (i.e. typically unresolved eclass references)
      handle_pending_tasks

      package
    end    
  
    def parse_eclasses(package_element, package)
      package_element.each_element_with_attribute('xsi:type', 'ecore:EClass', 0, 'eClassifiers') do |e|
        eclass = parse_eclass(e)
        eclass.ePackage = package

        package.eClassifiers << eclass
        package.eClasses << eclass;
      end    
    end

    def parse_datatypes(package_element, package)
      package_element.each_element_with_attribute('xsi:type', 'ecore:EDataType', 0, 'eClassifiers') do |e|
        edatatype = parse_datatype(e)
        edatatype.ePackage = package

        package.eClassifiers << edatatype
        package.eDataTypes << edatatype;
      end    
    end
  
    def parse_enumerations(package_element, package)
      # Nothing
    end
  
    def parse_eclass(eclass_element)
      eclass = fill_attributes(eclass_element, create_eclass)
      assert eclass.name != nil      
      
      # handle supertypes
      if eclass_element.attributes['eSuperTypes'] =~ MATCH_TYPE
        handle_supertype(eclass, $1)
      elsif eclass.name != 'EObject'
        handle_supertype(eclass, 'EObject')
      end
      
      # parser inner elements: EStructuralFeatures -> Attributes + References + Operations
      parse_estructural_features(eclass_element, eclass)
      
      @eclasses[eclass.name] = eclass
    end
  
    def parse_datatype(datatype_element)
      datatype = fill_attributes(datatype_element, EOpenStruct.new)
      assert datatype.name != nil      
      
      @datatypes[datatype.name] = datatype
    end
  
    def parse_estructural_features(eclass_element, eclass)     
      eclass_element.each_element_with_attribute('xsi:type', 'ecore:EAttribute', 0, 'eStructuralFeatures') do |e|
        eattribute = parse_eattribute(e)
        assert eattribute != nil
        
        eclass.eStructuralFeatures << eattribute
        eclass.eAttributes << eattribute
        eattribute.eContainingClass = eclass
      end    

      eclass_element.each_element_with_attribute('xsi:type', 'ecore:EReference', 0, 'eStructuralFeatures') do |e|
        ereference = parse_ereference(e)  
        assert ereference != nil
        
        eclass.eStructuralFeatures << ereference
        eclass.eReferences << ereference
        ereference.eContainingClass = eclass
      end    
    end    
    
    def parse_eattribute(eattribute_element)
      eattribute = fill_attributes(eattribute_element, EOpenStruct.new)
      assert eattribute_element.attributes['eType'] =~ MATCH_DATA_TYPE
      
      handle_datatype(eattribute, $1)      
      eattribute
    end
  
    def parse_ereference(ereference_element)
      ereference = fill_attributes(ereference_element, EOpenStruct.new)      
      if ereference_element.attributes['eType'] =~ MATCH_TYPE
        handle_type(ereference, $1)  
      end
      if ereference_element.attributes['eOpposite'] =~ MATCH_REFERENCE_TYPE
        handle_opposite(ereference, $1, $2)
      end
      ereference
    end
    
  private
    def handle_supertype(eclass, supertype_name)
      @pending_tasks << Proc.new do
        supertype = @eclasses[supertype_name] 
        assert supertype != nil

        eclass.eSuperTypes << supertype        
      end
    end

    def handle_type(reference, eclass_name)
      reference.eType = nil
      @pending_tasks << Proc.new do
        referenced_eclass = @eclasses[eclass_name] 
        assert referenced_eclass != nil

        reference.eType = referenced_eclass
      end    
    end

    def handle_opposite(reference, eclass_name, ereference_name)
      reference.eOpposite = nil
      @pending_tasks << Proc.new do
        referenced_eclass = @eclasses[eclass_name] 
        assert referenced_eclass != nil
        opposite_reference = referenced_eclass.eReferences.select { |r| r.name == ereference_name }.first
        assert opposite_reference != nil        

        reference.eOpposite = opposite_reference
      end    
    end
    
    def handle_datatype(eattribute, edatatype_name)
      @pending_tasks << Proc.new do
        datatype = @datatypes[edatatype_name] 
        assert datatype != nil

        eattribute.eType = datatype
      end    
    end
    
    def handle_pending_tasks
      @pending_tasks.each do |task|
        task.call
      end
    end
  
    def create_package
      package = EOpenStruct.new
      package.eClassifiers = []      
      package.eClasses = []
      package.eDataTypes = []
      package.eEnumerations = []
      package    
    end
  
    def create_eclass
      eclass = EOpenStruct.new
      eclass.eSuperTypes = []
      eclass.eStructuralFeatures = []      
      eclass.eAttributes = []
      eclass.eReferences = []

      eclass
    end
  
    def fill_attributes(element, object)
      element.attributes.each_attribute do |attr|
        if (attr.prefix == 'ecore' || attr.prefix == '') && (! (attr.value =~ /(^ecore:)|(^#\/\/)/))
          set_attribute(object, attr.name, attr.value)
        end
      end
      object
    end
    
    def set_attribute(object, name, value)
      object.send("#{name}=", value)
    end
  
    def assert(condition)
      raise "Condition not held" unless condition
    end  
  end
  
end