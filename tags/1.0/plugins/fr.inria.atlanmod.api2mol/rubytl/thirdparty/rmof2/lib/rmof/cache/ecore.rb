# TODO: This should be in some CacheRepository
# automate the loading from here... 

module ECore
  extend ::ECore::EPackageLookup
  cattr_accessor :owning_model # TODO: Strange, is it really necessary?

  def self.eClassifiers
  	[EAttribute,EAnnotation,EClass,EClassifier,EDataType,EEnum,EEnumLiteral,EFactory,EModelElement,ENamedElement,EObject,EOperation,EPackage,EParameter,EReference,EStructuralFeature,ETypedElement,EStringToStringMapEntry,EBigDecimal,EBigInteger,EBoolean,EBooleanObject,EByte,EByteArray,EByteObject,EChar,ECharacterObject,EDate,EDiagnosticChain,EDouble,EDoubleObject,EEList,EEnumerator,EFeatureMap,EFeatureMapEntry,EFloat,EFloatObject,EInt,EIntegerObject,EJavaClass,EJavaObject,ELong,ELongObject,EMap,EResource,EResourceSet,EShort,EShortObject,EString,ETreeIterator]
  end

  def self.eSubpackages
    []
  end

  def self.eSuperPackage
    
  end

  def self.nsURI
	'http://www.eclipse.org/emf/2002/Ecore'
  end
	
  def self.nsPrefix
  	'ecore'
  end		
 
  def self.root_package
	return self unless self.eSuperPackage
	return self.eSuperPackage.root_package
  end  	
    
  module ClassAutoImplementation
  	def ePackage
  		ECore
  	end
  	
  	def nsURI
      self.ePackage.nsURI
  	end
  	
  	def nsPrefix
  	  self.ePackage.nsPrefix
  	end  
  end

  # TODO: Generate nested EPackages	

module MetaEAttribute
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'EAttribute'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(EStructuralFeature)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'iD', EBoolean
    
      define_reference 'eAttributeType', EDataType, :derived => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module EAttributeCommon
end

module EAttributeImpl
end


module EAttributeStruct
  __meta_attribute__ 'iD'
    
  __meta_reference__ 'eAttributeType'

#TODO: QUITAR ESTO
include EAttributeCommon
include EAttributeImpl
end

class EAttribute
  include EAttributeStruct
  class << self; include MetaEAttribute; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaEAnnotation
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'EAnnotation'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(EModelElement)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'source', EString
    
      define_reference 'details', EStringToStringMapEntry, :upperBound => -1, :containment => true
      define_reference 'eModelElement', EModelElement
      define_reference 'contents', EObject, :upperBound => -1, :containment => true
      define_reference 'references', EObject, :upperBound => -1
      reference_opposite 'eModelElement', 'eAnnotations'

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module EAnnotationCommon
end

module EAnnotationImpl
end


module EAnnotationStruct
  __meta_attribute__ 'source'
    
  __meta_reference__ 'details'
  __meta_reference__ 'eModelElement'
  __meta_reference__ 'contents'
  __meta_reference__ 'references'

#TODO: QUITAR ESTO
include EAnnotationCommon
include EAnnotationImpl
end

class EAnnotation
  include EAnnotationStruct
  class << self; include MetaEAnnotation; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaEClass
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'EClass'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(EClassifier)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'abstract', EBoolean
      define_attribute 'interface', EBoolean
    
      define_reference 'eSuperTypes', EClass, :upperBound => -1
      define_reference 'eOperations', EOperation, :upperBound => -1, :containment => true
      define_reference 'eAllAttributes', EAttribute, :derived => true, :upperBound => -1
      define_reference 'eAllReferences', EReference, :derived => true, :upperBound => -1
      define_reference 'eReferences', EReference, :derived => true, :upperBound => -1
      define_reference 'eAttributes', EAttribute, :derived => true, :upperBound => -1
      define_reference 'eAllContainments', EReference, :derived => true, :upperBound => -1
      define_reference 'eAllOperations', EOperation, :derived => true, :upperBound => -1
      define_reference 'eAllStructuralFeatures', EStructuralFeature, :derived => true, :upperBound => -1
      define_reference 'eAllSuperTypes', EClass, :derived => true, :upperBound => -1
      define_reference 'eIDAttribute', EAttribute, :derived => true
      define_reference 'eStructuralFeatures', EStructuralFeature, :upperBound => -1, :containment => true
      reference_opposite 'eOperations', 'eContainingClass'
      reference_opposite 'eStructuralFeatures', 'eContainingClass'

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module EClassCommon
end

module EClassImpl
end


module EClassStruct
  __meta_attribute__ 'abstract'
  __meta_attribute__ 'interface'
    
  __meta_reference__ 'eSuperTypes'
  __meta_reference__ 'eOperations'
  __meta_reference__ 'eAllAttributes'
  __meta_reference__ 'eAllReferences'
  __meta_reference__ 'eReferences'
  __meta_reference__ 'eAttributes'
  __meta_reference__ 'eAllContainments'
  __meta_reference__ 'eAllOperations'
  __meta_reference__ 'eAllStructuralFeatures'
  __meta_reference__ 'eAllSuperTypes'
  __meta_reference__ 'eIDAttribute'
  __meta_reference__ 'eStructuralFeatures'

#TODO: QUITAR ESTO
include EClassCommon
include EClassImpl
end

class EClass
  include EClassStruct
  class << self; include MetaEClass; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaEClassifier
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'EClassifier'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(ENamedElement)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'instanceClassName', EString
      define_attribute 'instanceClass', EJavaClass, :derived => true
      define_attribute 'defaultValue', EJavaObject, :derived => true
    
      define_reference 'ePackage', EPackage
      reference_opposite 'ePackage', 'eClassifiers'

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module EClassifierCommon
end

module EClassifierImpl
end


module EClassifierStruct
  __meta_attribute__ 'instanceClassName'
  __meta_attribute__ 'instanceClass'
  __meta_attribute__ 'defaultValue'
    
  __meta_reference__ 'ePackage'

#TODO: QUITAR ESTO
include EClassifierCommon
include EClassifierImpl
end

class EClassifier
  include EClassifierStruct
  class << self; include MetaEClassifier; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaEDataType
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'EDataType'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(EClassifier)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'serializable', EBoolean
    

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module EDataTypeCommon
end

module EDataTypeImpl
end


module EDataTypeStruct
  __meta_attribute__ 'serializable'
    

#TODO: QUITAR ESTO
include EDataTypeCommon
include EDataTypeImpl
end

class EDataType
  include EDataTypeStruct
  class << self; include MetaEDataType; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaEEnum
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'EEnum'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(EDataType)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'eLiterals', EEnumLiteral, :upperBound => -1, :containment => true
      reference_opposite 'eLiterals', 'eEnum'

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module EEnumCommon
end

module EEnumImpl
end


module EEnumStruct
    
  __meta_reference__ 'eLiterals'

#TODO: QUITAR ESTO
include EEnumCommon
include EEnumImpl
end

class EEnum
  include EEnumStruct
  class << self; include MetaEEnum; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaEEnumLiteral
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'EEnumLiteral'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ENamedElement)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'value', EInt
      define_attribute 'instance', EEnumerator
      define_attribute 'literal', EString
    
      define_reference 'eEnum', EEnum
      reference_opposite 'eEnum', 'eLiterals'

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module EEnumLiteralCommon
end

module EEnumLiteralImpl
end


module EEnumLiteralStruct
  __meta_attribute__ 'value'
  __meta_attribute__ 'instance'
  __meta_attribute__ 'literal'
    
  __meta_reference__ 'eEnum'

#TODO: QUITAR ESTO
include EEnumLiteralCommon
include EEnumLiteralImpl
end

class EEnumLiteral
  include EEnumLiteralStruct
  class << self; include MetaEEnumLiteral; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaEFactory
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'EFactory'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(EModelElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'ePackage', EPackage
      reference_opposite 'ePackage', 'eFactoryInstance'

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module EFactoryCommon
end

module EFactoryImpl
end


module EFactoryStruct
    
  __meta_reference__ 'ePackage'

#TODO: QUITAR ESTO
include EFactoryCommon
include EFactoryImpl
end

class EFactory
  include EFactoryStruct
  class << self; include MetaEFactory; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaEModelElement
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'EModelElement'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(EObject)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'eAnnotations', EAnnotation, :upperBound => -1, :containment => true
      reference_opposite 'eAnnotations', 'eModelElement'

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module EModelElementCommon
end

module EModelElementImpl
end


module EModelElementStruct
    
  __meta_reference__ 'eAnnotations'

#TODO: QUITAR ESTO
include EModelElementCommon
include EModelElementImpl
end

class EModelElement
  include EModelElementStruct
  class << self; include MetaEModelElement; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaENamedElement
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ENamedElement'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(EModelElement)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'name', EString
    

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ENamedElementCommon
end

module ENamedElementImpl
end


module ENamedElementStruct
  __meta_attribute__ 'name'
    

#TODO: QUITAR ESTO
include ENamedElementCommon
include ENamedElementImpl
end

class ENamedElement
  include ENamedElementStruct
  class << self; include MetaENamedElement; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaEObject
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'EObject'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types()
  end

  def eStructuralFeatures
    define_structural_features do
    

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module EObjectCommon
end

module EObjectImpl
end


module EObjectStruct
    

#TODO: QUITAR ESTO
include EObjectCommon
include EObjectImpl
end

class EObject
  include EObjectStruct
  class << self; include MetaEObject; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaEOperation
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'EOperation'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ETypedElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'eContainingClass', EClass
      define_reference 'eParameters', EParameter, :upperBound => -1, :containment => true
      define_reference 'eExceptions', EClassifier, :upperBound => -1
      reference_opposite 'eContainingClass', 'eOperations'
      reference_opposite 'eParameters', 'eOperation'

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module EOperationCommon
end

module EOperationImpl
end


module EOperationStruct
    
  __meta_reference__ 'eContainingClass'
  __meta_reference__ 'eParameters'
  __meta_reference__ 'eExceptions'

#TODO: QUITAR ESTO
include EOperationCommon
include EOperationImpl
end

class EOperation
  include EOperationStruct
  class << self; include MetaEOperation; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaEPackage
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'EPackage'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ENamedElement)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'nsURI', EString
      define_attribute 'nsPrefix', EString
    
      define_reference 'eFactoryInstance', EFactory
      define_reference 'eClassifiers', EClassifier, :upperBound => -1, :containment => true
      define_reference 'eSubpackages', EPackage, :upperBound => -1, :containment => true
      define_reference 'eSuperPackage', EPackage
      reference_opposite 'eFactoryInstance', 'ePackage'
      reference_opposite 'eClassifiers', 'ePackage'
      reference_opposite 'eSubpackages', 'eSuperPackage'
      reference_opposite 'eSuperPackage', 'eSubpackages'

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module EPackageCommon
end

module EPackageImpl
end


module EPackageStruct
  __meta_attribute__ 'nsURI'
  __meta_attribute__ 'nsPrefix'
    
  __meta_reference__ 'eFactoryInstance'
  __meta_reference__ 'eClassifiers'
  __meta_reference__ 'eSubpackages'
  __meta_reference__ 'eSuperPackage'

#TODO: QUITAR ESTO
include EPackageCommon
include EPackageImpl
end

class EPackage
  include EPackageStruct
  class << self; include MetaEPackage; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaEParameter
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'EParameter'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ETypedElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'eOperation', EOperation
      reference_opposite 'eOperation', 'eParameters'

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module EParameterCommon
end

module EParameterImpl
end


module EParameterStruct
    
  __meta_reference__ 'eOperation'

#TODO: QUITAR ESTO
include EParameterCommon
include EParameterImpl
end

class EParameter
  include EParameterStruct
  class << self; include MetaEParameter; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaEReference
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'EReference'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(EStructuralFeature)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'containment', EBoolean
      define_attribute 'container', EBoolean, :derived => true
      define_attribute 'resolveProxies', EBoolean
    
      define_reference 'eOpposite', EReference
      define_reference 'eReferenceType', EClass, :derived => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module EReferenceCommon
end

module EReferenceImpl
end


module EReferenceStruct
  __meta_attribute__ 'containment'
  __meta_attribute__ 'container'
  __meta_attribute__ 'resolveProxies'
    
  __meta_reference__ 'eOpposite'
  __meta_reference__ 'eReferenceType'

#TODO: QUITAR ESTO
include EReferenceCommon
include EReferenceImpl
end

class EReference
  include EReferenceStruct
  class << self; include MetaEReference; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaEStructuralFeature
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'EStructuralFeature'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(ETypedElement)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'changeable', EBoolean
      define_attribute 'volatile', EBoolean
      define_attribute 'transient', EBoolean
      define_attribute 'defaultValueLiteral', EString
      define_attribute 'defaultValue', EJavaObject, :derived => true
      define_attribute 'unsettable', EBoolean
      define_attribute 'derived', EBoolean
    
      define_reference 'eContainingClass', EClass
      reference_opposite 'eContainingClass', 'eStructuralFeatures'

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module EStructuralFeatureCommon
end

module EStructuralFeatureImpl
end


module EStructuralFeatureStruct
  __meta_attribute__ 'changeable'
  __meta_attribute__ 'volatile'
  __meta_attribute__ 'transient'
  __meta_attribute__ 'defaultValueLiteral'
  __meta_attribute__ 'defaultValue'
  __meta_attribute__ 'unsettable'
  __meta_attribute__ 'derived'
    
  __meta_reference__ 'eContainingClass'

#TODO: QUITAR ESTO
include EStructuralFeatureCommon
include EStructuralFeatureImpl
end

class EStructuralFeature
  include EStructuralFeatureStruct
  class << self; include MetaEStructuralFeature; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaETypedElement
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ETypedElement'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(ENamedElement)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'ordered', EBoolean
      define_attribute 'unique', EBoolean
      define_attribute 'lowerBound', EInt
      define_attribute 'upperBound', EInt
      define_attribute 'many', EBoolean, :derived => true
      define_attribute 'required', EBoolean, :derived => true
    
      define_reference 'eType', EClassifier

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ETypedElementCommon
end

module ETypedElementImpl
end


module ETypedElementStruct
  __meta_attribute__ 'ordered'
  __meta_attribute__ 'unique'
  __meta_attribute__ 'lowerBound'
  __meta_attribute__ 'upperBound'
  __meta_attribute__ 'many'
  __meta_attribute__ 'required'
    
  __meta_reference__ 'eType'

#TODO: QUITAR ESTO
include ETypedElementCommon
include ETypedElementImpl
end

class ETypedElement
  include ETypedElementStruct
  class << self; include MetaETypedElement; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaEStringToStringMapEntry
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'EStringToStringMapEntry'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(EObject)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'key', EString
      define_attribute 'value', EString
    

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module EStringToStringMapEntryCommon
end

module EStringToStringMapEntryImpl
end


module EStringToStringMapEntryStruct
  __meta_attribute__ 'key'
  __meta_attribute__ 'value'
    

#TODO: QUITAR ESTO
include EStringToStringMapEntryCommon
include EStringToStringMapEntryImpl
end

class EStringToStringMapEntry
  include EStringToStringMapEntryStruct
  class << self; include MetaEStringToStringMapEntry; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module EBigDecimal
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EBigDecimal'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'java.math.BigDecimal'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EBigInteger
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EBigInteger'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'java.math.BigInteger'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EBoolean
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EBoolean'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'boolean'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EBooleanObject
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EBooleanObject'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'java.lang.Boolean'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EByte
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EByte'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'byte'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EByteArray
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EByteArray'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'byte[]'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EByteObject
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EByteObject'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'java.lang.Byte'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EChar
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EChar'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'char'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module ECharacterObject
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'ECharacterObject'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'java.lang.Character'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EDate
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EDate'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'java.util.Date'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EDiagnosticChain
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EDiagnosticChain'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'org.eclipse.emf.common.util.DiagnosticChain'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EDouble
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EDouble'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'double'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EDoubleObject
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EDoubleObject'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'java.lang.Double'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EEList
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EEList'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'org.eclipse.emf.common.util.EList'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EEnumerator
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EEnumerator'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'org.eclipse.emf.common.util.Enumerator'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EFeatureMap
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EFeatureMap'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'org.eclipse.emf.ecore.util.FeatureMap'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EFeatureMapEntry
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EFeatureMapEntry'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'org.eclipse.emf.ecore.util.FeatureMap$Entry'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EFloat
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EFloat'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'float'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EFloatObject
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EFloatObject'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'java.lang.Float'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EInt
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EInt'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'int'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EIntegerObject
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EIntegerObject'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'java.lang.Integer'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EJavaClass
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EJavaClass'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'java.lang.Class'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EJavaObject
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EJavaObject'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'java.lang.Object'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module ELong
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'ELong'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'long'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module ELongObject
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'ELongObject'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'java.lang.Long'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EMap
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EMap'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'java.util.Map'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EResource
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EResource'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'org.eclipse.emf.ecore.resource.Resource'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EResourceSet
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EResourceSet'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'org.eclipse.emf.ecore.resource.ResourceSet'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EShort
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EShort'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'short'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EShortObject
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EShortObject'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'java.lang.Short'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module EString
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'EString'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'java.lang.String'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  
module ETreeIterator
  extend ::ECore::TypeCasting
  extend ClassAutoImplementation

  # TODO: Duplicated with RMOF::ObjectHelper...
  def self.owning_model
    self.ePackage.owning_model
  end

  def self.non_qualified_name
  	'ETreeIterator'
  end
  
  def self.from_xmi_str(value)
    cast_primitive(value, self.instanceClassName)
  end
  
  def self.to_xmi_str(value)
  	value.to_s
  end
  
  def self.instanceClassName
  	'org.eclipse.emf.common.util.TreeIterator'
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   true;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	#"ecore:EDataType " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  	"#//" + self.non_qualified_name
  end

end

  



class EAttribute
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaEAttribute;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include EStructuralFeatureStruct
  include ENamedElementStruct
  include EObjectStruct
  include EModelElementStruct
  include ETypedElementStruct
  include EAttributeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class EAnnotation
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaEAnnotation;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include EModelElementStruct
  include EObjectStruct
  include EAnnotationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class EClass
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaEClass;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include EClassifierStruct
  include EModelElementStruct
  include EObjectStruct
  include ENamedElementStruct
  include EClassStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class EClassifier
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaEClassifier;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ENamedElementStruct
  include EObjectStruct
  include EModelElementStruct
  include EClassifierStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class EDataType
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaEDataType;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include EClassifierStruct
  include EModelElementStruct
  include EObjectStruct
  include ENamedElementStruct
  include EDataTypeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class EEnum
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaEEnum;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include EDataTypeStruct
  include ENamedElementStruct
  include EObjectStruct
  include EModelElementStruct
  include EClassifierStruct
  include EEnumStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class EEnumLiteral
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaEEnumLiteral;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ENamedElementStruct
  include EObjectStruct
  include EModelElementStruct
  include EEnumLiteralStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class EFactory
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaEFactory;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include EModelElementStruct
  include EObjectStruct
  include EFactoryStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class EModelElement
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaEModelElement;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include EObjectStruct
  include EModelElementStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ENamedElement
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaENamedElement;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include EModelElementStruct
  include EObjectStruct
  include ENamedElementStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class EObject
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaEObject;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include EObjectStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class EOperation
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaEOperation;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ETypedElementStruct
  include EModelElementStruct
  include EObjectStruct
  include ENamedElementStruct
  include EOperationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class EPackage
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaEPackage;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ENamedElementStruct
  include EObjectStruct
  include EModelElementStruct
  include EPackageStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class EParameter
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaEParameter;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ETypedElementStruct
  include EModelElementStruct
  include EObjectStruct
  include ENamedElementStruct
  include EParameterStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class EReference
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaEReference;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include EStructuralFeatureStruct
  include ENamedElementStruct
  include EObjectStruct
  include EModelElementStruct
  include ETypedElementStruct
  include EReferenceStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class EStructuralFeature
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaEStructuralFeature;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ETypedElementStruct
  include EModelElementStruct
  include EObjectStruct
  include ENamedElementStruct
  include EStructuralFeatureStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ETypedElement
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaETypedElement;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ENamedElementStruct
  include EObjectStruct
  include EModelElementStruct
  include ETypedElementStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class EStringToStringMapEntry
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaEStringToStringMapEntry;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include EObjectStruct
  include EStringToStringMapEntryStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

end
