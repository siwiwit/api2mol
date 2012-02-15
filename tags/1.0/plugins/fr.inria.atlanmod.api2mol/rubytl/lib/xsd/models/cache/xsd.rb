module RubyTL 
# TODO: This should be in some CacheRepository
# automate the loading from here... 

module Xsd
  extend ::ECore::EPackageLookup
  cattr_accessor :owning_model # TODO: Strange, is it really necessary?

  def self.eClassifiers
  	[SchemaDefinition,AnnotatedElement,ElementDefinition,TypeDefinition,ComplexTypeDefinition,Extension,SimpleTypeDefinition,ModelGroup,XSDCompositor,AttributeDeclaration,Facet,PatternFacet,Annotation,XSDExtensionKind]
  end

  def self.eSubpackages
    []
  end

  def self.eSuperPackage
    
  end

  def self.nsURI
	'http://gts.inf.um.es/rubytl/xsd'
  end
	
  def self.nsPrefix
  	'xsd_mm'
  end		
 
  def self.root_package
	return self unless self.eSuperPackage
	return self.eSuperPackage.root_package
  end  	
    
  module ClassAutoImplementation
  	def ePackage
  		Xsd
  	end
  	
  	def nsURI
      self.ePackage.nsURI
  	end
  	
  	def nsPrefix
  	  self.ePackage.nsPrefix
  	end  
  end

  # TODO: Generate nested EPackages	

module MetaSchemaDefinition
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'SchemaDefinition'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types()
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'elements', ElementDefinition, :upperBound => -1, :containment => true
      define_reference 'typeDefinitions', TypeDefinition, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module SchemaDefinitionCommon
end

module SchemaDefinitionImpl
end


module SchemaDefinitionStruct
    
  __meta_reference__ 'elements'
  __meta_reference__ 'typeDefinitions'

#TODO: QUITAR ESTO
include SchemaDefinitionCommon
include SchemaDefinitionImpl
end

class SchemaDefinition
  include SchemaDefinitionStruct
  class << self; include MetaSchemaDefinition; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaAnnotatedElement
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'AnnotatedElement'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types()
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'annotation', Annotation, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module AnnotatedElementCommon
end

module AnnotatedElementImpl
end


module AnnotatedElementStruct
    
  __meta_reference__ 'annotation'

#TODO: QUITAR ESTO
include AnnotatedElementCommon
include AnnotatedElementImpl
end

class AnnotatedElement
  include AnnotatedElementStruct
  class << self; include MetaAnnotatedElement; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaElementDefinition
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ElementDefinition'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(AnnotatedElement)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'name', ECore::EString
      define_attribute 'minOccurs', ECore::EInt
      define_attribute 'maxOccurs', ECore::EInt
    
      define_reference 'anonymousTypeDefinition', TypeDefinition, :containment => true
      define_reference 'typeDefinition', TypeDefinition

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ElementDefinitionCommon
end

module ElementDefinitionImpl
end


module ElementDefinitionStruct
  __meta_attribute__ 'name'
  __meta_attribute__ 'minOccurs'
  __meta_attribute__ 'maxOccurs'
    
  __meta_reference__ 'anonymousTypeDefinition'
  __meta_reference__ 'typeDefinition'

#TODO: QUITAR ESTO
include ElementDefinitionCommon
include ElementDefinitionImpl
end

class ElementDefinition
  include ElementDefinitionStruct
  class << self; include MetaElementDefinition; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaTypeDefinition
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'TypeDefinition'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(AnnotatedElement)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'name', ECore::EString
    

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module TypeDefinitionCommon
end

module TypeDefinitionImpl
end


module TypeDefinitionStruct
  __meta_attribute__ 'name'
    

#TODO: QUITAR ESTO
include TypeDefinitionCommon
include TypeDefinitionImpl
end

class TypeDefinition
  include TypeDefinitionStruct
  class << self; include MetaTypeDefinition; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaComplexTypeDefinition
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ComplexTypeDefinition'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(TypeDefinition)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'extensionKind', XSDExtensionKind
    
      define_reference 'content', ModelGroup, :containment => true
      define_reference 'attributes', AttributeDeclaration, :upperBound => -1, :containment => true
      define_reference 'extension', Extension, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ComplexTypeDefinitionCommon
end

module ComplexTypeDefinitionImpl
end


module ComplexTypeDefinitionStruct
  __meta_attribute__ 'extensionKind'
    
  __meta_reference__ 'content'
  __meta_reference__ 'attributes'
  __meta_reference__ 'extension'

#TODO: QUITAR ESTO
include ComplexTypeDefinitionCommon
include ComplexTypeDefinitionImpl
end

class ComplexTypeDefinition
  include ComplexTypeDefinitionStruct
  class << self; include MetaComplexTypeDefinition; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaExtension
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Extension'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types()
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'baseTypeDefinition', TypeDefinition

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ExtensionCommon
end

module ExtensionImpl
end


module ExtensionStruct
    
  __meta_reference__ 'baseTypeDefinition'

#TODO: QUITAR ESTO
include ExtensionCommon
include ExtensionImpl
end

class Extension
  include ExtensionStruct
  class << self; include MetaExtension; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaSimpleTypeDefinition
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'SimpleTypeDefinition'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(TypeDefinition)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'baseTypeDefinition', TypeDefinition
      define_reference 'facets', Facet, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module SimpleTypeDefinitionCommon
end

module SimpleTypeDefinitionImpl
end


module SimpleTypeDefinitionStruct
    
  __meta_reference__ 'baseTypeDefinition'
  __meta_reference__ 'facets'

#TODO: QUITAR ESTO
include SimpleTypeDefinitionCommon
include SimpleTypeDefinitionImpl
end

class SimpleTypeDefinition
  include SimpleTypeDefinitionStruct
  class << self; include MetaSimpleTypeDefinition; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaModelGroup
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ModelGroup'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types()
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'compositor', XSDCompositor
    
      define_reference 'elements', ElementDefinition, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ModelGroupCommon
end

module ModelGroupImpl
end


module ModelGroupStruct
  __meta_attribute__ 'compositor'
    
  __meta_reference__ 'elements'

#TODO: QUITAR ESTO
include ModelGroupCommon
include ModelGroupImpl
end

class ModelGroup
  include ModelGroupStruct
  class << self; include MetaModelGroup; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaAttributeDeclaration
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'AttributeDeclaration'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(AnnotatedElement)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'name', ECore::EString
      define_attribute 'required', ECore::EBoolean
    
      define_reference 'typeDefinition', SimpleTypeDefinition

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module AttributeDeclarationCommon
end

module AttributeDeclarationImpl
end


module AttributeDeclarationStruct
  __meta_attribute__ 'name'
  __meta_attribute__ 'required'
    
  __meta_reference__ 'typeDefinition'

#TODO: QUITAR ESTO
include AttributeDeclarationCommon
include AttributeDeclarationImpl
end

class AttributeDeclaration
  include AttributeDeclarationStruct
  class << self; include MetaAttributeDeclaration; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaFacet
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Facet'
  end

  def abstract
    true
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

module FacetCommon
end

module FacetImpl
end


module FacetStruct
    

#TODO: QUITAR ESTO
include FacetCommon
include FacetImpl
end

class Facet
  include FacetStruct
  class << self; include MetaFacet; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaPatternFacet
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'PatternFacet'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Facet)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'value', ECore::EString
    

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module PatternFacetCommon
end

module PatternFacetImpl
end


module PatternFacetStruct
  __meta_attribute__ 'value'
    

#TODO: QUITAR ESTO
include PatternFacetCommon
include PatternFacetImpl
end

class PatternFacet
  include PatternFacetStruct
  class << self; include MetaPatternFacet; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaAnnotation
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Annotation'
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

module AnnotationCommon
end

module AnnotationImpl
end


module AnnotationStruct
    

#TODO: QUITAR ESTO
include AnnotationCommon
include AnnotationImpl
end

class Annotation
  include AnnotationStruct
  class << self; include MetaAnnotation; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  


module XSDCompositor
  extend ClassAutoImplementation

  def self.eLiterals
  	unless @eLiterals
      @eLiterals = []
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 0
      literal.name    = 'all'
      literal.literal = 'all'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 1
      literal.name    = 'choice'
      literal.literal = 'choice'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 2
      literal.name    = 'sequence'
      literal.literal = 'sequence'
      @eLiterals << literal  
      
  	end
  	@eLiterals
  end
 
  def self.getEEnumLiteral(string_value)
  	value = self.eLiterals.find { |literal| literal.literal == string_value }
  	raise "Invalid literal #{string_value}" unless value
  	value
  end
 
  def self.non_qualified_name
  	'XSDCompositor'
  end
  
  def self.from_xmi_str(value)
    # cast_primitive(value, self.instanceClassName)
	self.getEEnumLiteral(value)
  end
  
  def self.to_xmi_str(value)
  #	value.to_s
  	value.name
  end
  
  def self.instanceClassName
  	''
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; true; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	"ecore:EEnum " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  end

end
  
module XSDExtensionKind
  extend ClassAutoImplementation

  def self.eLiterals
  	unless @eLiterals
      @eLiterals = []
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 0
      literal.name    = 'None'
      literal.literal = 'None'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 0
      literal.name    = 'Simple'
      literal.literal = 'Simple'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 0
      literal.name    = 'Complex'
      literal.literal = 'Complex'
      @eLiterals << literal  
      
  	end
  	@eLiterals
  end
 
  def self.getEEnumLiteral(string_value)
  	value = self.eLiterals.find { |literal| literal.literal == string_value }
  	raise "Invalid literal #{string_value}" unless value
  	value
  end
 
  def self.non_qualified_name
  	'XSDExtensionKind'
  end
  
  def self.from_xmi_str(value)
    # cast_primitive(value, self.instanceClassName)
	self.getEEnumLiteral(value)
  end
  
  def self.to_xmi_str(value)
  #	value.to_s
  	value.name
  end
  
  def self.instanceClassName
  	''
  end
  
  def self.metaclass
  	ECore::EDataType
  end
    
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; true; end
  def self.is_metaclass?; 	false; end


  # Autogenerate this method?
  def self.compute_uri_fragment
  	"ecore:EEnum " +  self.ePackage.nsURI + "#//" + self.non_qualified_name
  end

end
  


class SchemaDefinition
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaSchemaDefinition;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include SchemaDefinitionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class AnnotatedElement
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaAnnotatedElement;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include AnnotatedElementStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ElementDefinition
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaElementDefinition;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include AnnotatedElementStruct
  include ElementDefinitionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class TypeDefinition
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaTypeDefinition;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include AnnotatedElementStruct
  include TypeDefinitionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ComplexTypeDefinition
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaComplexTypeDefinition;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include TypeDefinitionStruct
  include AnnotatedElementStruct
  include ComplexTypeDefinitionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Extension
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaExtension;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ExtensionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class SimpleTypeDefinition
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaSimpleTypeDefinition;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include TypeDefinitionStruct
  include AnnotatedElementStruct
  include SimpleTypeDefinitionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ModelGroup
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaModelGroup;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ModelGroupStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class AttributeDeclaration
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaAttributeDeclaration;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include AnnotatedElementStruct
  include AttributeDeclarationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Facet
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaFacet;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include FacetStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class PatternFacet
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaPatternFacet;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include FacetStruct
  include PatternFacetStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Annotation
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaAnnotation;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include AnnotationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

end
end
