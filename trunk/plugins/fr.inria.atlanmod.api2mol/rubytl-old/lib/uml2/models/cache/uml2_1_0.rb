module RubyTL::UML2_1_0 
# TODO: This should be in some CacheRepository
# automate the loading from here... 

module Uml
  extend ::ECore::EPackageLookup
  cattr_accessor :owning_model # TODO: Strange, is it really necessary?

  def self.eClassifiers
  	[Comment,DirectedRelationship,LiteralSpecification,LiteralInteger,LiteralString,LiteralBoolean,LiteralNull,Constraint,ElementImport,TypedElement,Feature,RedefinableElement,StructuralFeature,Slot,PackageImport,DataType,Enumeration,EnumerationLiteral,PrimitiveType,Association,Relationship,PackageMerge,InstanceValue,LiteralUnlimitedNatural,Type,Expression,AggregationKind,ParameterDirectionKind,VisibilityKind,OpaqueExpression,OpaqueBehavior,FunctionBehavior,OpaqueAction,CallAction,SendSignalAction,CallOperationAction,CallBehaviorAction,MultiplicityElement,SequenceNode,InputPin,OutputPin,Usage,Abstraction,Dependency,Realization,Substitution,Namespace,InterfaceRealization,StructuredClassifier,Variable,CollaborationUse,Collaboration,ControlNode,ControlFlow,InitialNode,ActivityParameterNode,ValuePin,Message,GeneralOrdering,ExecutionSpecification,OccurrenceSpecification,MessageEnd,StateInvariant,ActionExecutionSpecification,BehaviorExecutionSpecification,ExecutionEvent,CreationEvent,DestructionEvent,SendOperationEvent,SendSignalEvent,MessageOccurrenceSpecification,ExecutionOccurrenceSpecification,ReceiveOperationEvent,ReceiveSignalEvent,MessageKind,MessageSort,Actor,Extend,Include,UseCase,ExtensionPoint,CallEvent,ChangeEvent,Reception,Signal,SignalEvent,MessageEvent,AnyReceiveEvent,BehavioredClassifier,Event,CallConcurrencyKind,ForkNode,FlowFinalNode,CentralBufferNode,ActivityPartition,MergeNode,DecisionNode,FinalNode,ActivityFinalNode,EncapsulatedClassifier,ComponentRealization,Connector,ConnectorKind,Manifestation,Node,Device,ExecutionEnvironment,DeploymentTarget,DeployedArtifact,CommunicationPath,InstanceSpecification,Artifact,InteractionUse,PartDecomposition,InteractionOperand,InteractionConstraint,Gate,CombinedFragment,Interaction,Lifeline,Continuation,InteractionFragment,ConsiderIgnoreFragment,InteractionOperatorKind,CreateObjectAction,DestroyObjectAction,TestIdentityAction,ReadSelfAction,StructuralFeatureAction,ReadStructuralFeatureAction,WriteStructuralFeatureAction,ClearStructuralFeatureAction,RemoveStructuralFeatureValueAction,AddStructuralFeatureValueAction,LinkAction,ReadLinkAction,LinkEndCreationData,CreateLinkAction,DestroyLinkAction,WriteLinkAction,ClearAssociationAction,BroadcastSignalAction,SendObjectAction,LinkEndDestructionData,ValueSpecificationAction,TimeExpression,Duration,DurationInterval,TimeConstraint,TimeInterval,DurationConstraint,IntervalConstraint,Interval,Observation,TimeObservation,DurationObservation,InvocationAction,Trigger,StateMachine,Pseudostate,FinalState,ConnectionPointReference,TimeEvent,PseudostateKind,TransitionKind,Stereotype,Profile,Class,ProfileApplication,Extension,Image,Element,ExtensionEnd,VariableAction,ReadVariableAction,WriteVariableAction,ClearVariableAction,AddVariableValueAction,RemoveVariableValueAction,RaiseExceptionAction,ActionInputPin,GeneralizationSet,Generalization,InformationItem,InformationFlow,Model,ReadExtentAction,ReclassifyObjectAction,ReadIsClassifiedObjectAction,StartClassifierBehaviorAction,QualifierValue,LinkEndData,ReadLinkObjectEndAction,ReadLinkObjectEndQualifierAction,CreateLinkObjectAction,AcceptEventAction,AcceptCallAction,ReplyAction,UnmarshallAction,ReduceAction,JoinNode,DataStoreNode,ObjectFlow,ObjectNode,ParameterSet,Activity,Parameter,Action,InterruptibleActivityRegion,ActivityNode,BehavioralFeature,Behavior,Pin,ObjectNodeOrderingKind,ParameterEffectKind,ConditionalNode,StructuredActivityNode,LoopNode,Clause,ActivityEdge,ActivityGroup,ExpansionNode,ExpansionRegion,ExecutableNode,ExceptionHandler,ExpansionKind,Component,Deployment,DeploymentSpecification,ProtocolConformance,Interface,Port,ProtocolTransition,ProtocolStateMachine,State,Region,AssociationClass,TemplateSignature,NamedElement,TemplateParameter,StringExpression,TemplateBinding,TemplateParameterSubstitution,TemplateableElement,ParameterableElement,Property,ValueSpecification,Operation,OperationTemplateParameter,PackageableElement,Classifier,ClassifierTemplateParameter,RedefinableTemplateSignature,ConnectableElementTemplateParameter,Package,ConnectableElement,ConnectorEnd,Vertex,Transition]
  end

  def self.eSubpackages
    []
  end

  def self.eSuperPackage
    
  end

  def self.nsURI
	'http://www.eclipse.org/uml2/2.1.0/UML'
  end
	
  def self.nsPrefix
  	'uml'
  end		
 
  def self.root_package
	return self unless self.eSuperPackage
	return self.eSuperPackage.root_package
  end  	
    
  module ClassAutoImplementation
  	def ePackage
  		Uml
  	end
  	
  	def nsURI
      self.ePackage.nsURI
  	end
  	
  	def nsPrefix
  	  self.ePackage.nsPrefix
  	end  
  end

  # TODO: Generate nested EPackages	

module MetaComment
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Comment'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Element)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'body', ECore::EString
    
      define_reference 'annotatedElement', Element, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module CommentCommon
end

module CommentImpl
end


module CommentStruct
  __meta_attribute__ 'body'
    
  __meta_reference__ 'annotatedElement'

#TODO: QUITAR ESTO
include CommentCommon
include CommentImpl
end

class Comment
  include CommentStruct
  class << self; include MetaComment; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaDirectedRelationship
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'DirectedRelationship'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(Relationship)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'source', Element, :upperBound => -1
      define_reference 'target', Element, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module DirectedRelationshipCommon
end

module DirectedRelationshipImpl
end


module DirectedRelationshipStruct
    
  __meta_reference__ 'source'
  __meta_reference__ 'target'

#TODO: QUITAR ESTO
include DirectedRelationshipCommon
include DirectedRelationshipImpl
end

class DirectedRelationship
  include DirectedRelationshipStruct
  class << self; include MetaDirectedRelationship; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaLiteralSpecification
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'LiteralSpecification'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(ValueSpecification)
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

module LiteralSpecificationCommon
end

module LiteralSpecificationImpl
end


module LiteralSpecificationStruct
    

#TODO: QUITAR ESTO
include LiteralSpecificationCommon
include LiteralSpecificationImpl
end

class LiteralSpecification
  include LiteralSpecificationStruct
  class << self; include MetaLiteralSpecification; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaLiteralInteger
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'LiteralInteger'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(LiteralSpecification)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'value', ECore::EInt
    

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module LiteralIntegerCommon
end

module LiteralIntegerImpl
end


module LiteralIntegerStruct
  __meta_attribute__ 'value'
    

#TODO: QUITAR ESTO
include LiteralIntegerCommon
include LiteralIntegerImpl
end

class LiteralInteger
  include LiteralIntegerStruct
  class << self; include MetaLiteralInteger; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaLiteralString
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'LiteralString'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(LiteralSpecification)
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

module LiteralStringCommon
end

module LiteralStringImpl
end


module LiteralStringStruct
  __meta_attribute__ 'value'
    

#TODO: QUITAR ESTO
include LiteralStringCommon
include LiteralStringImpl
end

class LiteralString
  include LiteralStringStruct
  class << self; include MetaLiteralString; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaLiteralBoolean
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'LiteralBoolean'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(LiteralSpecification)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'value', ECore::EBoolean
    

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module LiteralBooleanCommon
end

module LiteralBooleanImpl
end


module LiteralBooleanStruct
  __meta_attribute__ 'value'
    

#TODO: QUITAR ESTO
include LiteralBooleanCommon
include LiteralBooleanImpl
end

class LiteralBoolean
  include LiteralBooleanStruct
  class << self; include MetaLiteralBoolean; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaLiteralNull
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'LiteralNull'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(LiteralSpecification)
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

module LiteralNullCommon
end

module LiteralNullImpl
end


module LiteralNullStruct
    

#TODO: QUITAR ESTO
include LiteralNullCommon
include LiteralNullImpl
end

class LiteralNull
  include LiteralNullStruct
  class << self; include MetaLiteralNull; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaConstraint
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Constraint'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(PackageableElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'constrainedElement', Element, :upperBound => -1
      define_reference 'specification', ValueSpecification, :containment => true
      define_reference 'context', Namespace

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ConstraintCommon
end

module ConstraintImpl
end


module ConstraintStruct
    
  __meta_reference__ 'constrainedElement'
  __meta_reference__ 'specification'
  __meta_reference__ 'context'

#TODO: QUITAR ESTO
include ConstraintCommon
include ConstraintImpl
end

class Constraint
  include ConstraintStruct
  class << self; include MetaConstraint; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaElementImport
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ElementImport'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(DirectedRelationship)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'visibility', VisibilityKind
      define_attribute 'alias', ECore::EString
    
      define_reference 'importedElement', PackageableElement
      define_reference 'importingNamespace', Namespace

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ElementImportCommon
end

module ElementImportImpl
end


module ElementImportStruct
  __meta_attribute__ 'visibility'
  __meta_attribute__ 'alias'
    
  __meta_reference__ 'importedElement'
  __meta_reference__ 'importingNamespace'

#TODO: QUITAR ESTO
include ElementImportCommon
include ElementImportImpl
end

class ElementImport
  include ElementImportStruct
  class << self; include MetaElementImport; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaTypedElement
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'TypedElement'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(NamedElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'type', Type

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module TypedElementCommon
end

module TypedElementImpl
end


module TypedElementStruct
    
  __meta_reference__ 'type'

#TODO: QUITAR ESTO
include TypedElementCommon
include TypedElementImpl
end

class TypedElement
  include TypedElementStruct
  class << self; include MetaTypedElement; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaFeature
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Feature'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(RedefinableElement)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isStatic', ECore::EBoolean
    
      define_reference 'featuringClassifier', Classifier, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module FeatureCommon
end

module FeatureImpl
end


module FeatureStruct
  __meta_attribute__ 'isStatic'
    
  __meta_reference__ 'featuringClassifier'

#TODO: QUITAR ESTO
include FeatureCommon
include FeatureImpl
end

class Feature
  include FeatureStruct
  class << self; include MetaFeature; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaRedefinableElement
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'RedefinableElement'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(NamedElement)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isLeaf', ECore::EBoolean
    
      define_reference 'redefinedElement', RedefinableElement, :upperBound => -1
      define_reference 'redefinitionContext', Classifier, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module RedefinableElementCommon
end

module RedefinableElementImpl
end


module RedefinableElementStruct
  __meta_attribute__ 'isLeaf'
    
  __meta_reference__ 'redefinedElement'
  __meta_reference__ 'redefinitionContext'

#TODO: QUITAR ESTO
include RedefinableElementCommon
include RedefinableElementImpl
end

class RedefinableElement
  include RedefinableElementStruct
  class << self; include MetaRedefinableElement; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaStructuralFeature
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'StructuralFeature'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(Feature, TypedElement, MultiplicityElement)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isReadOnly', ECore::EBoolean
    

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module StructuralFeatureCommon
end

module StructuralFeatureImpl
end


module StructuralFeatureStruct
  __meta_attribute__ 'isReadOnly'
    

#TODO: QUITAR ESTO
include StructuralFeatureCommon
include StructuralFeatureImpl
end

class StructuralFeature
  include StructuralFeatureStruct
  class << self; include MetaStructuralFeature; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaSlot
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Slot'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Element)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'owningInstance', InstanceSpecification
      define_reference 'definingFeature', StructuralFeature
      define_reference 'value', ValueSpecification, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module SlotCommon
end

module SlotImpl
end


module SlotStruct
    
  __meta_reference__ 'owningInstance'
  __meta_reference__ 'definingFeature'
  __meta_reference__ 'value'

#TODO: QUITAR ESTO
include SlotCommon
include SlotImpl
end

class Slot
  include SlotStruct
  class << self; include MetaSlot; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaPackageImport
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'PackageImport'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(DirectedRelationship)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'visibility', VisibilityKind
    
      define_reference 'importingNamespace', Namespace
      define_reference 'importedPackage', Package

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module PackageImportCommon
end

module PackageImportImpl
end


module PackageImportStruct
  __meta_attribute__ 'visibility'
    
  __meta_reference__ 'importingNamespace'
  __meta_reference__ 'importedPackage'

#TODO: QUITAR ESTO
include PackageImportCommon
include PackageImportImpl
end

class PackageImport
  include PackageImportStruct
  class << self; include MetaPackageImport; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaDataType
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'DataType'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Classifier)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'ownedAttribute', Property, :upperBound => -1, :containment => true
      define_reference 'ownedOperation', Operation, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module DataTypeCommon
end

module DataTypeImpl
end


module DataTypeStruct
    
  __meta_reference__ 'ownedAttribute'
  __meta_reference__ 'ownedOperation'

#TODO: QUITAR ESTO
include DataTypeCommon
include DataTypeImpl
end

class DataType
  include DataTypeStruct
  class << self; include MetaDataType; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaEnumeration
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Enumeration'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(DataType)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'ownedLiteral', EnumerationLiteral, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module EnumerationCommon
end

module EnumerationImpl
end


module EnumerationStruct
    
  __meta_reference__ 'ownedLiteral'

#TODO: QUITAR ESTO
include EnumerationCommon
include EnumerationImpl
end

class Enumeration
  include EnumerationStruct
  class << self; include MetaEnumeration; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaEnumerationLiteral
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'EnumerationLiteral'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(InstanceSpecification)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'enumeration', Enumeration

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module EnumerationLiteralCommon
end

module EnumerationLiteralImpl
end


module EnumerationLiteralStruct
    
  __meta_reference__ 'enumeration'

#TODO: QUITAR ESTO
include EnumerationLiteralCommon
include EnumerationLiteralImpl
end

class EnumerationLiteral
  include EnumerationLiteralStruct
  class << self; include MetaEnumerationLiteral; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaPrimitiveType
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'PrimitiveType'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(DataType)
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

module PrimitiveTypeCommon
end

module PrimitiveTypeImpl
end


module PrimitiveTypeStruct
    

#TODO: QUITAR ESTO
include PrimitiveTypeCommon
include PrimitiveTypeImpl
end

class PrimitiveType
  include PrimitiveTypeStruct
  class << self; include MetaPrimitiveType; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaAssociation
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Association'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Relationship, Classifier)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isDerived', ECore::EBoolean
    
      define_reference 'ownedEnd', Property, :upperBound => -1, :containment => true
      define_reference 'endType', Type, :upperBound => -1
      define_reference 'memberEnd', Property, :upperBound => -1
      define_reference 'navigableOwnedEnd', Property, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module AssociationCommon
end

module AssociationImpl
end


module AssociationStruct
  __meta_attribute__ 'isDerived'
    
  __meta_reference__ 'ownedEnd'
  __meta_reference__ 'endType'
  __meta_reference__ 'memberEnd'
  __meta_reference__ 'navigableOwnedEnd'

#TODO: QUITAR ESTO
include AssociationCommon
include AssociationImpl
end

class Association
  include AssociationStruct
  class << self; include MetaAssociation; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaRelationship
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Relationship'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(Element)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'relatedElement', Element, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module RelationshipCommon
end

module RelationshipImpl
end


module RelationshipStruct
    
  __meta_reference__ 'relatedElement'

#TODO: QUITAR ESTO
include RelationshipCommon
include RelationshipImpl
end

class Relationship
  include RelationshipStruct
  class << self; include MetaRelationship; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaPackageMerge
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'PackageMerge'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(DirectedRelationship)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'receivingPackage', Package
      define_reference 'mergedPackage', Package

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module PackageMergeCommon
end

module PackageMergeImpl
end


module PackageMergeStruct
    
  __meta_reference__ 'receivingPackage'
  __meta_reference__ 'mergedPackage'

#TODO: QUITAR ESTO
include PackageMergeCommon
include PackageMergeImpl
end

class PackageMerge
  include PackageMergeStruct
  class << self; include MetaPackageMerge; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaInstanceValue
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'InstanceValue'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ValueSpecification)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'instance', InstanceSpecification

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module InstanceValueCommon
end

module InstanceValueImpl
end


module InstanceValueStruct
    
  __meta_reference__ 'instance'

#TODO: QUITAR ESTO
include InstanceValueCommon
include InstanceValueImpl
end

class InstanceValue
  include InstanceValueStruct
  class << self; include MetaInstanceValue; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaLiteralUnlimitedNatural
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'LiteralUnlimitedNatural'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(LiteralSpecification)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'value', ECore::EInt
    

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module LiteralUnlimitedNaturalCommon
end

module LiteralUnlimitedNaturalImpl
end


module LiteralUnlimitedNaturalStruct
  __meta_attribute__ 'value'
    

#TODO: QUITAR ESTO
include LiteralUnlimitedNaturalCommon
include LiteralUnlimitedNaturalImpl
end

class LiteralUnlimitedNatural
  include LiteralUnlimitedNaturalStruct
  class << self; include MetaLiteralUnlimitedNatural; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaType
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Type'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(PackageableElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'package', Package

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module TypeCommon
end

module TypeImpl
end


module TypeStruct
    
  __meta_reference__ 'package'

#TODO: QUITAR ESTO
include TypeCommon
include TypeImpl
end

class Type
  include TypeStruct
  class << self; include MetaType; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaExpression
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Expression'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ValueSpecification)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'symbol', ECore::EString
    
      define_reference 'operand', ValueSpecification, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ExpressionCommon
end

module ExpressionImpl
end


module ExpressionStruct
  __meta_attribute__ 'symbol'
    
  __meta_reference__ 'operand'

#TODO: QUITAR ESTO
include ExpressionCommon
include ExpressionImpl
end

class Expression
  include ExpressionStruct
  class << self; include MetaExpression; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaOpaqueExpression
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'OpaqueExpression'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ValueSpecification)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'body', ECore::EString
      define_attribute 'language', ECore::EString
    
      define_reference 'result', Parameter
      define_reference 'behavior', Behavior

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module OpaqueExpressionCommon
end

module OpaqueExpressionImpl
end


module OpaqueExpressionStruct
  __meta_attribute__ 'body'
  __meta_attribute__ 'language'
    
  __meta_reference__ 'result'
  __meta_reference__ 'behavior'

#TODO: QUITAR ESTO
include OpaqueExpressionCommon
include OpaqueExpressionImpl
end

class OpaqueExpression
  include OpaqueExpressionStruct
  class << self; include MetaOpaqueExpression; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaOpaqueBehavior
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'OpaqueBehavior'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Behavior)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'body', ECore::EString
      define_attribute 'language', ECore::EString
    

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module OpaqueBehaviorCommon
end

module OpaqueBehaviorImpl
end


module OpaqueBehaviorStruct
  __meta_attribute__ 'body'
  __meta_attribute__ 'language'
    

#TODO: QUITAR ESTO
include OpaqueBehaviorCommon
include OpaqueBehaviorImpl
end

class OpaqueBehavior
  include OpaqueBehaviorStruct
  class << self; include MetaOpaqueBehavior; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaFunctionBehavior
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'FunctionBehavior'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(OpaqueBehavior)
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

module FunctionBehaviorCommon
end

module FunctionBehaviorImpl
end


module FunctionBehaviorStruct
    

#TODO: QUITAR ESTO
include FunctionBehaviorCommon
include FunctionBehaviorImpl
end

class FunctionBehavior
  include FunctionBehaviorStruct
  class << self; include MetaFunctionBehavior; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaOpaqueAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'OpaqueAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'body', ECore::EString
      define_attribute 'language', ECore::EString
    
      define_reference 'inputValue', InputPin, :upperBound => -1, :containment => true
      define_reference 'outputValue', OutputPin, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module OpaqueActionCommon
end

module OpaqueActionImpl
end


module OpaqueActionStruct
  __meta_attribute__ 'body'
  __meta_attribute__ 'language'
    
  __meta_reference__ 'inputValue'
  __meta_reference__ 'outputValue'

#TODO: QUITAR ESTO
include OpaqueActionCommon
include OpaqueActionImpl
end

class OpaqueAction
  include OpaqueActionStruct
  class << self; include MetaOpaqueAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaCallAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'CallAction'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(InvocationAction)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isSynchronous', ECore::EBoolean
    
      define_reference 'result', OutputPin, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module CallActionCommon
end

module CallActionImpl
end


module CallActionStruct
  __meta_attribute__ 'isSynchronous'
    
  __meta_reference__ 'result'

#TODO: QUITAR ESTO
include CallActionCommon
include CallActionImpl
end

class CallAction
  include CallActionStruct
  class << self; include MetaCallAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaSendSignalAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'SendSignalAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(InvocationAction)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'target', InputPin, :containment => true
      define_reference 'signal', Signal

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module SendSignalActionCommon
end

module SendSignalActionImpl
end


module SendSignalActionStruct
    
  __meta_reference__ 'target'
  __meta_reference__ 'signal'

#TODO: QUITAR ESTO
include SendSignalActionCommon
include SendSignalActionImpl
end

class SendSignalAction
  include SendSignalActionStruct
  class << self; include MetaSendSignalAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaCallOperationAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'CallOperationAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(CallAction)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'operation', Operation
      define_reference 'target', InputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module CallOperationActionCommon
end

module CallOperationActionImpl
end


module CallOperationActionStruct
    
  __meta_reference__ 'operation'
  __meta_reference__ 'target'

#TODO: QUITAR ESTO
include CallOperationActionCommon
include CallOperationActionImpl
end

class CallOperationAction
  include CallOperationActionStruct
  class << self; include MetaCallOperationAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaCallBehaviorAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'CallBehaviorAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(CallAction)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'behavior', Behavior

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module CallBehaviorActionCommon
end

module CallBehaviorActionImpl
end


module CallBehaviorActionStruct
    
  __meta_reference__ 'behavior'

#TODO: QUITAR ESTO
include CallBehaviorActionCommon
include CallBehaviorActionImpl
end

class CallBehaviorAction
  include CallBehaviorActionStruct
  class << self; include MetaCallBehaviorAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaMultiplicityElement
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'MultiplicityElement'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(Element)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isOrdered', ECore::EBoolean
      define_attribute 'isUnique', ECore::EBoolean
      define_attribute 'upper', ECore::EInt
      define_attribute 'lower', ECore::EInt
    
      define_reference 'upperValue', ValueSpecification, :containment => true
      define_reference 'lowerValue', ValueSpecification, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module MultiplicityElementCommon
end

module MultiplicityElementImpl
end


module MultiplicityElementStruct
  __meta_attribute__ 'isOrdered'
  __meta_attribute__ 'isUnique'
  __meta_attribute__ 'upper'
  __meta_attribute__ 'lower'
    
  __meta_reference__ 'upperValue'
  __meta_reference__ 'lowerValue'

#TODO: QUITAR ESTO
include MultiplicityElementCommon
include MultiplicityElementImpl
end

class MultiplicityElement
  include MultiplicityElementStruct
  class << self; include MetaMultiplicityElement; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaSequenceNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'SequenceNode'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(StructuredActivityNode)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'executableNode', ExecutableNode, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module SequenceNodeCommon
end

module SequenceNodeImpl
end


module SequenceNodeStruct
    
  __meta_reference__ 'executableNode'

#TODO: QUITAR ESTO
include SequenceNodeCommon
include SequenceNodeImpl
end

class SequenceNode
  include SequenceNodeStruct
  class << self; include MetaSequenceNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaInputPin
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'InputPin'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Pin)
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

module InputPinCommon
end

module InputPinImpl
end


module InputPinStruct
    

#TODO: QUITAR ESTO
include InputPinCommon
include InputPinImpl
end

class InputPin
  include InputPinStruct
  class << self; include MetaInputPin; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaOutputPin
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'OutputPin'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Pin)
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

module OutputPinCommon
end

module OutputPinImpl
end


module OutputPinStruct
    

#TODO: QUITAR ESTO
include OutputPinCommon
include OutputPinImpl
end

class OutputPin
  include OutputPinStruct
  class << self; include MetaOutputPin; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaUsage
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Usage'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Dependency)
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

module UsageCommon
end

module UsageImpl
end


module UsageStruct
    

#TODO: QUITAR ESTO
include UsageCommon
include UsageImpl
end

class Usage
  include UsageStruct
  class << self; include MetaUsage; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaAbstraction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Abstraction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Dependency)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'mapping', OpaqueExpression, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module AbstractionCommon
end

module AbstractionImpl
end


module AbstractionStruct
    
  __meta_reference__ 'mapping'

#TODO: QUITAR ESTO
include AbstractionCommon
include AbstractionImpl
end

class Abstraction
  include AbstractionStruct
  class << self; include MetaAbstraction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaDependency
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Dependency'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(DirectedRelationship, PackageableElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'supplier', NamedElement, :upperBound => -1
      define_reference 'client', NamedElement, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module DependencyCommon
end

module DependencyImpl
end


module DependencyStruct
    
  __meta_reference__ 'supplier'
  __meta_reference__ 'client'

#TODO: QUITAR ESTO
include DependencyCommon
include DependencyImpl
end

class Dependency
  include DependencyStruct
  class << self; include MetaDependency; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaRealization
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Realization'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Abstraction)
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

module RealizationCommon
end

module RealizationImpl
end


module RealizationStruct
    

#TODO: QUITAR ESTO
include RealizationCommon
include RealizationImpl
end

class Realization
  include RealizationStruct
  class << self; include MetaRealization; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaSubstitution
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Substitution'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Realization)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'contract', Classifier
      define_reference 'substitutingClassifier', Classifier

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module SubstitutionCommon
end

module SubstitutionImpl
end


module SubstitutionStruct
    
  __meta_reference__ 'contract'
  __meta_reference__ 'substitutingClassifier'

#TODO: QUITAR ESTO
include SubstitutionCommon
include SubstitutionImpl
end

class Substitution
  include SubstitutionStruct
  class << self; include MetaSubstitution; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaNamespace
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Namespace'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(NamedElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'elementImport', ElementImport, :upperBound => -1, :containment => true
      define_reference 'packageImport', PackageImport, :upperBound => -1, :containment => true
      define_reference 'ownedRule', Constraint, :upperBound => -1, :containment => true
      define_reference 'member', NamedElement, :upperBound => -1
      define_reference 'importedMember', PackageableElement, :upperBound => -1
      define_reference 'ownedMember', NamedElement, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module NamespaceCommon
end

module NamespaceImpl
end


module NamespaceStruct
    
  __meta_reference__ 'elementImport'
  __meta_reference__ 'packageImport'
  __meta_reference__ 'ownedRule'
  __meta_reference__ 'member'
  __meta_reference__ 'importedMember'
  __meta_reference__ 'ownedMember'

#TODO: QUITAR ESTO
include NamespaceCommon
include NamespaceImpl
end

class Namespace
  include NamespaceStruct
  class << self; include MetaNamespace; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaInterfaceRealization
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'InterfaceRealization'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Realization)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'contract', Interface
      define_reference 'implementingClassifier', BehavioredClassifier

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module InterfaceRealizationCommon
end

module InterfaceRealizationImpl
end


module InterfaceRealizationStruct
    
  __meta_reference__ 'contract'
  __meta_reference__ 'implementingClassifier'

#TODO: QUITAR ESTO
include InterfaceRealizationCommon
include InterfaceRealizationImpl
end

class InterfaceRealization
  include InterfaceRealizationStruct
  class << self; include MetaInterfaceRealization; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaStructuredClassifier
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'StructuredClassifier'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(Classifier)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'ownedAttribute', Property, :upperBound => -1, :containment => true
      define_reference 'part', Property, :upperBound => -1
      define_reference 'role', ConnectableElement, :upperBound => -1
      define_reference 'ownedConnector', Connector, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module StructuredClassifierCommon
end

module StructuredClassifierImpl
end


module StructuredClassifierStruct
    
  __meta_reference__ 'ownedAttribute'
  __meta_reference__ 'part'
  __meta_reference__ 'role'
  __meta_reference__ 'ownedConnector'

#TODO: QUITAR ESTO
include StructuredClassifierCommon
include StructuredClassifierImpl
end

class StructuredClassifier
  include StructuredClassifierStruct
  class << self; include MetaStructuredClassifier; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaVariable
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Variable'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(MultiplicityElement, ConnectableElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'scope', StructuredActivityNode
      define_reference 'activityScope', Activity

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module VariableCommon
end

module VariableImpl
end


module VariableStruct
    
  __meta_reference__ 'scope'
  __meta_reference__ 'activityScope'

#TODO: QUITAR ESTO
include VariableCommon
include VariableImpl
end

class Variable
  include VariableStruct
  class << self; include MetaVariable; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaCollaborationUse
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'CollaborationUse'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(NamedElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'type', Collaboration
      define_reference 'roleBinding', Dependency, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module CollaborationUseCommon
end

module CollaborationUseImpl
end


module CollaborationUseStruct
    
  __meta_reference__ 'type'
  __meta_reference__ 'roleBinding'

#TODO: QUITAR ESTO
include CollaborationUseCommon
include CollaborationUseImpl
end

class CollaborationUse
  include CollaborationUseStruct
  class << self; include MetaCollaborationUse; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaCollaboration
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Collaboration'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(StructuredClassifier, BehavioredClassifier)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'collaborationRole', ConnectableElement, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module CollaborationCommon
end

module CollaborationImpl
end


module CollaborationStruct
    
  __meta_reference__ 'collaborationRole'

#TODO: QUITAR ESTO
include CollaborationCommon
include CollaborationImpl
end

class Collaboration
  include CollaborationStruct
  class << self; include MetaCollaboration; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaControlNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ControlNode'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(ActivityNode)
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

module ControlNodeCommon
end

module ControlNodeImpl
end


module ControlNodeStruct
    

#TODO: QUITAR ESTO
include ControlNodeCommon
include ControlNodeImpl
end

class ControlNode
  include ControlNodeStruct
  class << self; include MetaControlNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaControlFlow
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ControlFlow'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ActivityEdge)
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

module ControlFlowCommon
end

module ControlFlowImpl
end


module ControlFlowStruct
    

#TODO: QUITAR ESTO
include ControlFlowCommon
include ControlFlowImpl
end

class ControlFlow
  include ControlFlowStruct
  class << self; include MetaControlFlow; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaInitialNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'InitialNode'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ControlNode)
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

module InitialNodeCommon
end

module InitialNodeImpl
end


module InitialNodeStruct
    

#TODO: QUITAR ESTO
include InitialNodeCommon
include InitialNodeImpl
end

class InitialNode
  include InitialNodeStruct
  class << self; include MetaInitialNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaActivityParameterNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ActivityParameterNode'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ObjectNode)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'parameter', Parameter

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ActivityParameterNodeCommon
end

module ActivityParameterNodeImpl
end


module ActivityParameterNodeStruct
    
  __meta_reference__ 'parameter'

#TODO: QUITAR ESTO
include ActivityParameterNodeCommon
include ActivityParameterNodeImpl
end

class ActivityParameterNode
  include ActivityParameterNodeStruct
  class << self; include MetaActivityParameterNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaValuePin
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ValuePin'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(InputPin)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'value', ValueSpecification, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ValuePinCommon
end

module ValuePinImpl
end


module ValuePinStruct
    
  __meta_reference__ 'value'

#TODO: QUITAR ESTO
include ValuePinCommon
include ValuePinImpl
end

class ValuePin
  include ValuePinStruct
  class << self; include MetaValuePin; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaMessage
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Message'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(NamedElement)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'messageKind', MessageKind
      define_attribute 'messageSort', MessageSort
    
      define_reference 'receiveEvent', MessageEnd
      define_reference 'sendEvent', MessageEnd
      define_reference 'connector', Connector
      define_reference 'interaction', Interaction
      define_reference 'argument', ValueSpecification, :upperBound => -1, :containment => true
      define_reference 'signature', NamedElement

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module MessageCommon
end

module MessageImpl
end


module MessageStruct
  __meta_attribute__ 'messageKind'
  __meta_attribute__ 'messageSort'
    
  __meta_reference__ 'receiveEvent'
  __meta_reference__ 'sendEvent'
  __meta_reference__ 'connector'
  __meta_reference__ 'interaction'
  __meta_reference__ 'argument'
  __meta_reference__ 'signature'

#TODO: QUITAR ESTO
include MessageCommon
include MessageImpl
end

class Message
  include MessageStruct
  class << self; include MetaMessage; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaGeneralOrdering
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'GeneralOrdering'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(NamedElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'before', OccurrenceSpecification
      define_reference 'after', OccurrenceSpecification

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module GeneralOrderingCommon
end

module GeneralOrderingImpl
end


module GeneralOrderingStruct
    
  __meta_reference__ 'before'
  __meta_reference__ 'after'

#TODO: QUITAR ESTO
include GeneralOrderingCommon
include GeneralOrderingImpl
end

class GeneralOrdering
  include GeneralOrderingStruct
  class << self; include MetaGeneralOrdering; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaExecutionSpecification
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ExecutionSpecification'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(InteractionFragment)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'start', OccurrenceSpecification
      define_reference 'finish', OccurrenceSpecification

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ExecutionSpecificationCommon
end

module ExecutionSpecificationImpl
end


module ExecutionSpecificationStruct
    
  __meta_reference__ 'start'
  __meta_reference__ 'finish'

#TODO: QUITAR ESTO
include ExecutionSpecificationCommon
include ExecutionSpecificationImpl
end

class ExecutionSpecification
  include ExecutionSpecificationStruct
  class << self; include MetaExecutionSpecification; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaOccurrenceSpecification
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'OccurrenceSpecification'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(InteractionFragment)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'covered', Lifeline
      define_reference 'toAfter', GeneralOrdering, :upperBound => -1
      define_reference 'toBefore', GeneralOrdering, :upperBound => -1
      define_reference 'event', Event

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module OccurrenceSpecificationCommon
end

module OccurrenceSpecificationImpl
end


module OccurrenceSpecificationStruct
    
  __meta_reference__ 'covered'
  __meta_reference__ 'toAfter'
  __meta_reference__ 'toBefore'
  __meta_reference__ 'event'

#TODO: QUITAR ESTO
include OccurrenceSpecificationCommon
include OccurrenceSpecificationImpl
end

class OccurrenceSpecification
  include OccurrenceSpecificationStruct
  class << self; include MetaOccurrenceSpecification; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaMessageEnd
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'MessageEnd'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(NamedElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'message', Message

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module MessageEndCommon
end

module MessageEndImpl
end


module MessageEndStruct
    
  __meta_reference__ 'message'

#TODO: QUITAR ESTO
include MessageEndCommon
include MessageEndImpl
end

class MessageEnd
  include MessageEndStruct
  class << self; include MetaMessageEnd; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaStateInvariant
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'StateInvariant'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(InteractionFragment)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'invariant', Constraint, :containment => true
      define_reference 'covered', Lifeline

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module StateInvariantCommon
end

module StateInvariantImpl
end


module StateInvariantStruct
    
  __meta_reference__ 'invariant'
  __meta_reference__ 'covered'

#TODO: QUITAR ESTO
include StateInvariantCommon
include StateInvariantImpl
end

class StateInvariant
  include StateInvariantStruct
  class << self; include MetaStateInvariant; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaActionExecutionSpecification
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ActionExecutionSpecification'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ExecutionSpecification)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'action', Action

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ActionExecutionSpecificationCommon
end

module ActionExecutionSpecificationImpl
end


module ActionExecutionSpecificationStruct
    
  __meta_reference__ 'action'

#TODO: QUITAR ESTO
include ActionExecutionSpecificationCommon
include ActionExecutionSpecificationImpl
end

class ActionExecutionSpecification
  include ActionExecutionSpecificationStruct
  class << self; include MetaActionExecutionSpecification; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaBehaviorExecutionSpecification
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'BehaviorExecutionSpecification'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ExecutionSpecification)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'behavior', Behavior

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module BehaviorExecutionSpecificationCommon
end

module BehaviorExecutionSpecificationImpl
end


module BehaviorExecutionSpecificationStruct
    
  __meta_reference__ 'behavior'

#TODO: QUITAR ESTO
include BehaviorExecutionSpecificationCommon
include BehaviorExecutionSpecificationImpl
end

class BehaviorExecutionSpecification
  include BehaviorExecutionSpecificationStruct
  class << self; include MetaBehaviorExecutionSpecification; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaExecutionEvent
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ExecutionEvent'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Event)
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

module ExecutionEventCommon
end

module ExecutionEventImpl
end


module ExecutionEventStruct
    

#TODO: QUITAR ESTO
include ExecutionEventCommon
include ExecutionEventImpl
end

class ExecutionEvent
  include ExecutionEventStruct
  class << self; include MetaExecutionEvent; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaCreationEvent
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'CreationEvent'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Event)
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

module CreationEventCommon
end

module CreationEventImpl
end


module CreationEventStruct
    

#TODO: QUITAR ESTO
include CreationEventCommon
include CreationEventImpl
end

class CreationEvent
  include CreationEventStruct
  class << self; include MetaCreationEvent; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaDestructionEvent
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'DestructionEvent'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Event)
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

module DestructionEventCommon
end

module DestructionEventImpl
end


module DestructionEventStruct
    

#TODO: QUITAR ESTO
include DestructionEventCommon
include DestructionEventImpl
end

class DestructionEvent
  include DestructionEventStruct
  class << self; include MetaDestructionEvent; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaSendOperationEvent
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'SendOperationEvent'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(MessageEvent)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'operation', Operation

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module SendOperationEventCommon
end

module SendOperationEventImpl
end


module SendOperationEventStruct
    
  __meta_reference__ 'operation'

#TODO: QUITAR ESTO
include SendOperationEventCommon
include SendOperationEventImpl
end

class SendOperationEvent
  include SendOperationEventStruct
  class << self; include MetaSendOperationEvent; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaSendSignalEvent
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'SendSignalEvent'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(MessageEvent)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'signal', Signal

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module SendSignalEventCommon
end

module SendSignalEventImpl
end


module SendSignalEventStruct
    
  __meta_reference__ 'signal'

#TODO: QUITAR ESTO
include SendSignalEventCommon
include SendSignalEventImpl
end

class SendSignalEvent
  include SendSignalEventStruct
  class << self; include MetaSendSignalEvent; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaMessageOccurrenceSpecification
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'MessageOccurrenceSpecification'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(MessageEnd, OccurrenceSpecification)
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

module MessageOccurrenceSpecificationCommon
end

module MessageOccurrenceSpecificationImpl
end


module MessageOccurrenceSpecificationStruct
    

#TODO: QUITAR ESTO
include MessageOccurrenceSpecificationCommon
include MessageOccurrenceSpecificationImpl
end

class MessageOccurrenceSpecification
  include MessageOccurrenceSpecificationStruct
  class << self; include MetaMessageOccurrenceSpecification; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaExecutionOccurrenceSpecification
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ExecutionOccurrenceSpecification'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(OccurrenceSpecification)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'execution', ExecutionSpecification
      define_reference 'event', ExecutionEvent

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ExecutionOccurrenceSpecificationCommon
end

module ExecutionOccurrenceSpecificationImpl
end


module ExecutionOccurrenceSpecificationStruct
    
  __meta_reference__ 'execution'
  __meta_reference__ 'event'

#TODO: QUITAR ESTO
include ExecutionOccurrenceSpecificationCommon
include ExecutionOccurrenceSpecificationImpl
end

class ExecutionOccurrenceSpecification
  include ExecutionOccurrenceSpecificationStruct
  class << self; include MetaExecutionOccurrenceSpecification; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaReceiveOperationEvent
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ReceiveOperationEvent'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(MessageEvent)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'operation', Operation

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ReceiveOperationEventCommon
end

module ReceiveOperationEventImpl
end


module ReceiveOperationEventStruct
    
  __meta_reference__ 'operation'

#TODO: QUITAR ESTO
include ReceiveOperationEventCommon
include ReceiveOperationEventImpl
end

class ReceiveOperationEvent
  include ReceiveOperationEventStruct
  class << self; include MetaReceiveOperationEvent; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaReceiveSignalEvent
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ReceiveSignalEvent'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(MessageEvent)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'signal', Signal

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ReceiveSignalEventCommon
end

module ReceiveSignalEventImpl
end


module ReceiveSignalEventStruct
    
  __meta_reference__ 'signal'

#TODO: QUITAR ESTO
include ReceiveSignalEventCommon
include ReceiveSignalEventImpl
end

class ReceiveSignalEvent
  include ReceiveSignalEventStruct
  class << self; include MetaReceiveSignalEvent; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaActor
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Actor'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(BehavioredClassifier)
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

module ActorCommon
end

module ActorImpl
end


module ActorStruct
    

#TODO: QUITAR ESTO
include ActorCommon
include ActorImpl
end

class Actor
  include ActorStruct
  class << self; include MetaActor; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaExtend
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Extend'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(DirectedRelationship, NamedElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'extendedCase', UseCase
      define_reference 'extension', UseCase
      define_reference 'condition', Constraint, :containment => true
      define_reference 'extensionLocation', ExtensionPoint, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ExtendCommon
end

module ExtendImpl
end


module ExtendStruct
    
  __meta_reference__ 'extendedCase'
  __meta_reference__ 'extension'
  __meta_reference__ 'condition'
  __meta_reference__ 'extensionLocation'

#TODO: QUITAR ESTO
include ExtendCommon
include ExtendImpl
end

class Extend
  include ExtendStruct
  class << self; include MetaExtend; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaInclude
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Include'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(DirectedRelationship, NamedElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'includingCase', UseCase
      define_reference 'addition', UseCase

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module IncludeCommon
end

module IncludeImpl
end


module IncludeStruct
    
  __meta_reference__ 'includingCase'
  __meta_reference__ 'addition'

#TODO: QUITAR ESTO
include IncludeCommon
include IncludeImpl
end

class Include
  include IncludeStruct
  class << self; include MetaInclude; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaUseCase
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'UseCase'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(BehavioredClassifier)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'include', Include, :upperBound => -1, :containment => true
      define_reference 'extend', Extend, :upperBound => -1, :containment => true
      define_reference 'extensionPoint', ExtensionPoint, :upperBound => -1, :containment => true
      define_reference 'subject', Classifier, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module UseCaseCommon
end

module UseCaseImpl
end


module UseCaseStruct
    
  __meta_reference__ 'include'
  __meta_reference__ 'extend'
  __meta_reference__ 'extensionPoint'
  __meta_reference__ 'subject'

#TODO: QUITAR ESTO
include UseCaseCommon
include UseCaseImpl
end

class UseCase
  include UseCaseStruct
  class << self; include MetaUseCase; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaExtensionPoint
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ExtensionPoint'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(RedefinableElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'useCase', UseCase

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ExtensionPointCommon
end

module ExtensionPointImpl
end


module ExtensionPointStruct
    
  __meta_reference__ 'useCase'

#TODO: QUITAR ESTO
include ExtensionPointCommon
include ExtensionPointImpl
end

class ExtensionPoint
  include ExtensionPointStruct
  class << self; include MetaExtensionPoint; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaCallEvent
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'CallEvent'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(MessageEvent)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'operation', Operation

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module CallEventCommon
end

module CallEventImpl
end


module CallEventStruct
    
  __meta_reference__ 'operation'

#TODO: QUITAR ESTO
include CallEventCommon
include CallEventImpl
end

class CallEvent
  include CallEventStruct
  class << self; include MetaCallEvent; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaChangeEvent
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ChangeEvent'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Event)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'changeExpression', ValueSpecification, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ChangeEventCommon
end

module ChangeEventImpl
end


module ChangeEventStruct
    
  __meta_reference__ 'changeExpression'

#TODO: QUITAR ESTO
include ChangeEventCommon
include ChangeEventImpl
end

class ChangeEvent
  include ChangeEventStruct
  class << self; include MetaChangeEvent; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaReception
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Reception'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(BehavioralFeature)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'signal', Signal

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ReceptionCommon
end

module ReceptionImpl
end


module ReceptionStruct
    
  __meta_reference__ 'signal'

#TODO: QUITAR ESTO
include ReceptionCommon
include ReceptionImpl
end

class Reception
  include ReceptionStruct
  class << self; include MetaReception; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaSignal
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Signal'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Classifier)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'ownedAttribute', Property, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module SignalCommon
end

module SignalImpl
end


module SignalStruct
    
  __meta_reference__ 'ownedAttribute'

#TODO: QUITAR ESTO
include SignalCommon
include SignalImpl
end

class Signal
  include SignalStruct
  class << self; include MetaSignal; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaSignalEvent
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'SignalEvent'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(MessageEvent)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'signal', Signal

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module SignalEventCommon
end

module SignalEventImpl
end


module SignalEventStruct
    
  __meta_reference__ 'signal'

#TODO: QUITAR ESTO
include SignalEventCommon
include SignalEventImpl
end

class SignalEvent
  include SignalEventStruct
  class << self; include MetaSignalEvent; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaMessageEvent
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'MessageEvent'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(Event)
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

module MessageEventCommon
end

module MessageEventImpl
end


module MessageEventStruct
    

#TODO: QUITAR ESTO
include MessageEventCommon
include MessageEventImpl
end

class MessageEvent
  include MessageEventStruct
  class << self; include MetaMessageEvent; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaAnyReceiveEvent
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'AnyReceiveEvent'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(MessageEvent)
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

module AnyReceiveEventCommon
end

module AnyReceiveEventImpl
end


module AnyReceiveEventStruct
    

#TODO: QUITAR ESTO
include AnyReceiveEventCommon
include AnyReceiveEventImpl
end

class AnyReceiveEvent
  include AnyReceiveEventStruct
  class << self; include MetaAnyReceiveEvent; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaBehavioredClassifier
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'BehavioredClassifier'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(Classifier)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'ownedBehavior', Behavior, :upperBound => -1, :containment => true
      define_reference 'classifierBehavior', Behavior
      define_reference 'interfaceRealization', InterfaceRealization, :upperBound => -1, :containment => true
      define_reference 'ownedTrigger', Trigger, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module BehavioredClassifierCommon
end

module BehavioredClassifierImpl
end


module BehavioredClassifierStruct
    
  __meta_reference__ 'ownedBehavior'
  __meta_reference__ 'classifierBehavior'
  __meta_reference__ 'interfaceRealization'
  __meta_reference__ 'ownedTrigger'

#TODO: QUITAR ESTO
include BehavioredClassifierCommon
include BehavioredClassifierImpl
end

class BehavioredClassifier
  include BehavioredClassifierStruct
  class << self; include MetaBehavioredClassifier; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaEvent
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Event'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(PackageableElement)
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

module EventCommon
end

module EventImpl
end


module EventStruct
    

#TODO: QUITAR ESTO
include EventCommon
include EventImpl
end

class Event
  include EventStruct
  class << self; include MetaEvent; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaForkNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ForkNode'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ControlNode)
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

module ForkNodeCommon
end

module ForkNodeImpl
end


module ForkNodeStruct
    

#TODO: QUITAR ESTO
include ForkNodeCommon
include ForkNodeImpl
end

class ForkNode
  include ForkNodeStruct
  class << self; include MetaForkNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaFlowFinalNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'FlowFinalNode'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(FinalNode)
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

module FlowFinalNodeCommon
end

module FlowFinalNodeImpl
end


module FlowFinalNodeStruct
    

#TODO: QUITAR ESTO
include FlowFinalNodeCommon
include FlowFinalNodeImpl
end

class FlowFinalNode
  include FlowFinalNodeStruct
  class << self; include MetaFlowFinalNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaCentralBufferNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'CentralBufferNode'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ObjectNode)
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

module CentralBufferNodeCommon
end

module CentralBufferNodeImpl
end


module CentralBufferNodeStruct
    

#TODO: QUITAR ESTO
include CentralBufferNodeCommon
include CentralBufferNodeImpl
end

class CentralBufferNode
  include CentralBufferNodeStruct
  class << self; include MetaCentralBufferNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaActivityPartition
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ActivityPartition'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(NamedElement, ActivityGroup)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isDimension', ECore::EBoolean
      define_attribute 'isExternal', ECore::EBoolean
    
      define_reference 'edge', ActivityEdge, :upperBound => -1
      define_reference 'node', ActivityNode, :upperBound => -1
      define_reference 'subpartition', ActivityPartition, :upperBound => -1, :containment => true
      define_reference 'superPartition', ActivityPartition
      define_reference 'represents', Element

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ActivityPartitionCommon
end

module ActivityPartitionImpl
end


module ActivityPartitionStruct
  __meta_attribute__ 'isDimension'
  __meta_attribute__ 'isExternal'
    
  __meta_reference__ 'edge'
  __meta_reference__ 'node'
  __meta_reference__ 'subpartition'
  __meta_reference__ 'superPartition'
  __meta_reference__ 'represents'

#TODO: QUITAR ESTO
include ActivityPartitionCommon
include ActivityPartitionImpl
end

class ActivityPartition
  include ActivityPartitionStruct
  class << self; include MetaActivityPartition; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaMergeNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'MergeNode'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ControlNode)
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

module MergeNodeCommon
end

module MergeNodeImpl
end


module MergeNodeStruct
    

#TODO: QUITAR ESTO
include MergeNodeCommon
include MergeNodeImpl
end

class MergeNode
  include MergeNodeStruct
  class << self; include MetaMergeNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaDecisionNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'DecisionNode'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ControlNode)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'decisionInput', Behavior

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module DecisionNodeCommon
end

module DecisionNodeImpl
end


module DecisionNodeStruct
    
  __meta_reference__ 'decisionInput'

#TODO: QUITAR ESTO
include DecisionNodeCommon
include DecisionNodeImpl
end

class DecisionNode
  include DecisionNodeStruct
  class << self; include MetaDecisionNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaFinalNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'FinalNode'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(ControlNode)
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

module FinalNodeCommon
end

module FinalNodeImpl
end


module FinalNodeStruct
    

#TODO: QUITAR ESTO
include FinalNodeCommon
include FinalNodeImpl
end

class FinalNode
  include FinalNodeStruct
  class << self; include MetaFinalNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaActivityFinalNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ActivityFinalNode'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(FinalNode)
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

module ActivityFinalNodeCommon
end

module ActivityFinalNodeImpl
end


module ActivityFinalNodeStruct
    

#TODO: QUITAR ESTO
include ActivityFinalNodeCommon
include ActivityFinalNodeImpl
end

class ActivityFinalNode
  include ActivityFinalNodeStruct
  class << self; include MetaActivityFinalNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaEncapsulatedClassifier
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'EncapsulatedClassifier'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(StructuredClassifier)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'ownedPort', Port, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module EncapsulatedClassifierCommon
end

module EncapsulatedClassifierImpl
end


module EncapsulatedClassifierStruct
    
  __meta_reference__ 'ownedPort'

#TODO: QUITAR ESTO
include EncapsulatedClassifierCommon
include EncapsulatedClassifierImpl
end

class EncapsulatedClassifier
  include EncapsulatedClassifierStruct
  class << self; include MetaEncapsulatedClassifier; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaComponentRealization
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ComponentRealization'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Realization)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'abstraction', Component
      define_reference 'realizingClassifier', Classifier

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ComponentRealizationCommon
end

module ComponentRealizationImpl
end


module ComponentRealizationStruct
    
  __meta_reference__ 'abstraction'
  __meta_reference__ 'realizingClassifier'

#TODO: QUITAR ESTO
include ComponentRealizationCommon
include ComponentRealizationImpl
end

class ComponentRealization
  include ComponentRealizationStruct
  class << self; include MetaComponentRealization; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaConnector
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Connector'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Feature)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'kind', ConnectorKind
    
      define_reference 'type', Association
      define_reference 'redefinedConnector', Connector, :upperBound => -1
      define_reference 'end', ConnectorEnd, :upperBound => -1, :containment => true
      define_reference 'contract', Behavior, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ConnectorCommon
end

module ConnectorImpl
end


module ConnectorStruct
  __meta_attribute__ 'kind'
    
  __meta_reference__ 'type'
  __meta_reference__ 'redefinedConnector'
  __meta_reference__ 'end'
  __meta_reference__ 'contract'

#TODO: QUITAR ESTO
include ConnectorCommon
include ConnectorImpl
end

class Connector
  include ConnectorStruct
  class << self; include MetaConnector; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaManifestation
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Manifestation'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Abstraction)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'utilizedElement', PackageableElement

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ManifestationCommon
end

module ManifestationImpl
end


module ManifestationStruct
    
  __meta_reference__ 'utilizedElement'

#TODO: QUITAR ESTO
include ManifestationCommon
include ManifestationImpl
end

class Manifestation
  include ManifestationStruct
  class << self; include MetaManifestation; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Node'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Class, DeploymentTarget)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'nestedNode', Node, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module NodeCommon
end

module NodeImpl
end


module NodeStruct
    
  __meta_reference__ 'nestedNode'

#TODO: QUITAR ESTO
include NodeCommon
include NodeImpl
end

class Node
  include NodeStruct
  class << self; include MetaNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaDevice
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Device'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Node)
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

module DeviceCommon
end

module DeviceImpl
end


module DeviceStruct
    

#TODO: QUITAR ESTO
include DeviceCommon
include DeviceImpl
end

class Device
  include DeviceStruct
  class << self; include MetaDevice; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaExecutionEnvironment
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ExecutionEnvironment'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Node)
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

module ExecutionEnvironmentCommon
end

module ExecutionEnvironmentImpl
end


module ExecutionEnvironmentStruct
    

#TODO: QUITAR ESTO
include ExecutionEnvironmentCommon
include ExecutionEnvironmentImpl
end

class ExecutionEnvironment
  include ExecutionEnvironmentStruct
  class << self; include MetaExecutionEnvironment; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaDeploymentTarget
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'DeploymentTarget'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(NamedElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'deployment', Deployment, :upperBound => -1, :containment => true
      define_reference 'deployedElement', PackageableElement, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module DeploymentTargetCommon
end

module DeploymentTargetImpl
end


module DeploymentTargetStruct
    
  __meta_reference__ 'deployment'
  __meta_reference__ 'deployedElement'

#TODO: QUITAR ESTO
include DeploymentTargetCommon
include DeploymentTargetImpl
end

class DeploymentTarget
  include DeploymentTargetStruct
  class << self; include MetaDeploymentTarget; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaDeployedArtifact
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'DeployedArtifact'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(NamedElement)
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

module DeployedArtifactCommon
end

module DeployedArtifactImpl
end


module DeployedArtifactStruct
    

#TODO: QUITAR ESTO
include DeployedArtifactCommon
include DeployedArtifactImpl
end

class DeployedArtifact
  include DeployedArtifactStruct
  class << self; include MetaDeployedArtifact; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaCommunicationPath
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'CommunicationPath'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Association)
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

module CommunicationPathCommon
end

module CommunicationPathImpl
end


module CommunicationPathStruct
    

#TODO: QUITAR ESTO
include CommunicationPathCommon
include CommunicationPathImpl
end

class CommunicationPath
  include CommunicationPathStruct
  class << self; include MetaCommunicationPath; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaInstanceSpecification
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'InstanceSpecification'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(PackageableElement, DeploymentTarget, DeployedArtifact)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'classifier', Classifier, :upperBound => -1
      define_reference 'slot', Slot, :upperBound => -1, :containment => true
      define_reference 'specification', ValueSpecification, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module InstanceSpecificationCommon
end

module InstanceSpecificationImpl
end


module InstanceSpecificationStruct
    
  __meta_reference__ 'classifier'
  __meta_reference__ 'slot'
  __meta_reference__ 'specification'

#TODO: QUITAR ESTO
include InstanceSpecificationCommon
include InstanceSpecificationImpl
end

class InstanceSpecification
  include InstanceSpecificationStruct
  class << self; include MetaInstanceSpecification; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaArtifact
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Artifact'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Classifier, DeployedArtifact)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'fileName', ECore::EString
    
      define_reference 'nestedArtifact', Artifact, :upperBound => -1, :containment => true
      define_reference 'manifestation', Manifestation, :upperBound => -1, :containment => true
      define_reference 'ownedOperation', Operation, :upperBound => -1, :containment => true
      define_reference 'ownedAttribute', Property, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ArtifactCommon
end

module ArtifactImpl
end


module ArtifactStruct
  __meta_attribute__ 'fileName'
    
  __meta_reference__ 'nestedArtifact'
  __meta_reference__ 'manifestation'
  __meta_reference__ 'ownedOperation'
  __meta_reference__ 'ownedAttribute'

#TODO: QUITAR ESTO
include ArtifactCommon
include ArtifactImpl
end

class Artifact
  include ArtifactStruct
  class << self; include MetaArtifact; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaInteractionUse
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'InteractionUse'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(InteractionFragment)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'refersTo', Interaction
      define_reference 'actualGate', Gate, :upperBound => -1, :containment => true
      define_reference 'argument', Action, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module InteractionUseCommon
end

module InteractionUseImpl
end


module InteractionUseStruct
    
  __meta_reference__ 'refersTo'
  __meta_reference__ 'actualGate'
  __meta_reference__ 'argument'

#TODO: QUITAR ESTO
include InteractionUseCommon
include InteractionUseImpl
end

class InteractionUse
  include InteractionUseStruct
  class << self; include MetaInteractionUse; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaPartDecomposition
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'PartDecomposition'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(InteractionUse)
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

module PartDecompositionCommon
end

module PartDecompositionImpl
end


module PartDecompositionStruct
    

#TODO: QUITAR ESTO
include PartDecompositionCommon
include PartDecompositionImpl
end

class PartDecomposition
  include PartDecompositionStruct
  class << self; include MetaPartDecomposition; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaInteractionOperand
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'InteractionOperand'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(InteractionFragment, Namespace)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'guard', InteractionConstraint, :containment => true
      define_reference 'fragment', InteractionFragment, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module InteractionOperandCommon
end

module InteractionOperandImpl
end


module InteractionOperandStruct
    
  __meta_reference__ 'guard'
  __meta_reference__ 'fragment'

#TODO: QUITAR ESTO
include InteractionOperandCommon
include InteractionOperandImpl
end

class InteractionOperand
  include InteractionOperandStruct
  class << self; include MetaInteractionOperand; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaInteractionConstraint
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'InteractionConstraint'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Constraint)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'minint', ValueSpecification, :containment => true
      define_reference 'maxint', ValueSpecification, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module InteractionConstraintCommon
end

module InteractionConstraintImpl
end


module InteractionConstraintStruct
    
  __meta_reference__ 'minint'
  __meta_reference__ 'maxint'

#TODO: QUITAR ESTO
include InteractionConstraintCommon
include InteractionConstraintImpl
end

class InteractionConstraint
  include InteractionConstraintStruct
  class << self; include MetaInteractionConstraint; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaGate
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Gate'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(MessageEnd)
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

module GateCommon
end

module GateImpl
end


module GateStruct
    

#TODO: QUITAR ESTO
include GateCommon
include GateImpl
end

class Gate
  include GateStruct
  class << self; include MetaGate; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaCombinedFragment
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'CombinedFragment'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(InteractionFragment)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'interactionOperator', InteractionOperatorKind
    
      define_reference 'operand', InteractionOperand, :upperBound => -1, :containment => true
      define_reference 'cfragmentGate', Gate, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module CombinedFragmentCommon
end

module CombinedFragmentImpl
end


module CombinedFragmentStruct
  __meta_attribute__ 'interactionOperator'
    
  __meta_reference__ 'operand'
  __meta_reference__ 'cfragmentGate'

#TODO: QUITAR ESTO
include CombinedFragmentCommon
include CombinedFragmentImpl
end

class CombinedFragment
  include CombinedFragmentStruct
  class << self; include MetaCombinedFragment; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaInteraction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Interaction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(InteractionFragment, Behavior)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'lifeline', Lifeline, :upperBound => -1, :containment => true
      define_reference 'message', Message, :upperBound => -1, :containment => true
      define_reference 'fragment', InteractionFragment, :upperBound => -1, :containment => true
      define_reference 'action', Action, :upperBound => -1, :containment => true
      define_reference 'formalGate', Gate, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module InteractionCommon
end

module InteractionImpl
end


module InteractionStruct
    
  __meta_reference__ 'lifeline'
  __meta_reference__ 'message'
  __meta_reference__ 'fragment'
  __meta_reference__ 'action'
  __meta_reference__ 'formalGate'

#TODO: QUITAR ESTO
include InteractionCommon
include InteractionImpl
end

class Interaction
  include InteractionStruct
  class << self; include MetaInteraction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaLifeline
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Lifeline'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(NamedElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'coveredBy', InteractionFragment, :upperBound => -1
      define_reference 'represents', ConnectableElement
      define_reference 'interaction', Interaction
      define_reference 'selector', ValueSpecification, :containment => true
      define_reference 'decomposedAs', PartDecomposition

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module LifelineCommon
end

module LifelineImpl
end


module LifelineStruct
    
  __meta_reference__ 'coveredBy'
  __meta_reference__ 'represents'
  __meta_reference__ 'interaction'
  __meta_reference__ 'selector'
  __meta_reference__ 'decomposedAs'

#TODO: QUITAR ESTO
include LifelineCommon
include LifelineImpl
end

class Lifeline
  include LifelineStruct
  class << self; include MetaLifeline; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaContinuation
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Continuation'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(InteractionFragment)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'setting', ECore::EBoolean
    

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ContinuationCommon
end

module ContinuationImpl
end


module ContinuationStruct
  __meta_attribute__ 'setting'
    

#TODO: QUITAR ESTO
include ContinuationCommon
include ContinuationImpl
end

class Continuation
  include ContinuationStruct
  class << self; include MetaContinuation; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaInteractionFragment
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'InteractionFragment'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(NamedElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'covered', Lifeline, :upperBound => -1
      define_reference 'generalOrdering', GeneralOrdering, :upperBound => -1, :containment => true
      define_reference 'enclosingInteraction', Interaction
      define_reference 'enclosingOperand', InteractionOperand

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module InteractionFragmentCommon
end

module InteractionFragmentImpl
end


module InteractionFragmentStruct
    
  __meta_reference__ 'covered'
  __meta_reference__ 'generalOrdering'
  __meta_reference__ 'enclosingInteraction'
  __meta_reference__ 'enclosingOperand'

#TODO: QUITAR ESTO
include InteractionFragmentCommon
include InteractionFragmentImpl
end

class InteractionFragment
  include InteractionFragmentStruct
  class << self; include MetaInteractionFragment; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaConsiderIgnoreFragment
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ConsiderIgnoreFragment'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(CombinedFragment)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'message', NamedElement, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ConsiderIgnoreFragmentCommon
end

module ConsiderIgnoreFragmentImpl
end


module ConsiderIgnoreFragmentStruct
    
  __meta_reference__ 'message'

#TODO: QUITAR ESTO
include ConsiderIgnoreFragmentCommon
include ConsiderIgnoreFragmentImpl
end

class ConsiderIgnoreFragment
  include ConsiderIgnoreFragmentStruct
  class << self; include MetaConsiderIgnoreFragment; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaCreateObjectAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'CreateObjectAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'classifier', Classifier
      define_reference 'result', OutputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module CreateObjectActionCommon
end

module CreateObjectActionImpl
end


module CreateObjectActionStruct
    
  __meta_reference__ 'classifier'
  __meta_reference__ 'result'

#TODO: QUITAR ESTO
include CreateObjectActionCommon
include CreateObjectActionImpl
end

class CreateObjectAction
  include CreateObjectActionStruct
  class << self; include MetaCreateObjectAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaDestroyObjectAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'DestroyObjectAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isDestroyLinks', ECore::EBoolean
      define_attribute 'isDestroyOwnedObjects', ECore::EBoolean
    
      define_reference 'target', InputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module DestroyObjectActionCommon
end

module DestroyObjectActionImpl
end


module DestroyObjectActionStruct
  __meta_attribute__ 'isDestroyLinks'
  __meta_attribute__ 'isDestroyOwnedObjects'
    
  __meta_reference__ 'target'

#TODO: QUITAR ESTO
include DestroyObjectActionCommon
include DestroyObjectActionImpl
end

class DestroyObjectAction
  include DestroyObjectActionStruct
  class << self; include MetaDestroyObjectAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaTestIdentityAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'TestIdentityAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'first', InputPin, :containment => true
      define_reference 'second', InputPin, :containment => true
      define_reference 'result', OutputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module TestIdentityActionCommon
end

module TestIdentityActionImpl
end


module TestIdentityActionStruct
    
  __meta_reference__ 'first'
  __meta_reference__ 'second'
  __meta_reference__ 'result'

#TODO: QUITAR ESTO
include TestIdentityActionCommon
include TestIdentityActionImpl
end

class TestIdentityAction
  include TestIdentityActionStruct
  class << self; include MetaTestIdentityAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaReadSelfAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ReadSelfAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'result', OutputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ReadSelfActionCommon
end

module ReadSelfActionImpl
end


module ReadSelfActionStruct
    
  __meta_reference__ 'result'

#TODO: QUITAR ESTO
include ReadSelfActionCommon
include ReadSelfActionImpl
end

class ReadSelfAction
  include ReadSelfActionStruct
  class << self; include MetaReadSelfAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaStructuralFeatureAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'StructuralFeatureAction'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'structuralFeature', StructuralFeature
      define_reference 'object', InputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module StructuralFeatureActionCommon
end

module StructuralFeatureActionImpl
end


module StructuralFeatureActionStruct
    
  __meta_reference__ 'structuralFeature'
  __meta_reference__ 'object'

#TODO: QUITAR ESTO
include StructuralFeatureActionCommon
include StructuralFeatureActionImpl
end

class StructuralFeatureAction
  include StructuralFeatureActionStruct
  class << self; include MetaStructuralFeatureAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaReadStructuralFeatureAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ReadStructuralFeatureAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(StructuralFeatureAction)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'result', OutputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ReadStructuralFeatureActionCommon
end

module ReadStructuralFeatureActionImpl
end


module ReadStructuralFeatureActionStruct
    
  __meta_reference__ 'result'

#TODO: QUITAR ESTO
include ReadStructuralFeatureActionCommon
include ReadStructuralFeatureActionImpl
end

class ReadStructuralFeatureAction
  include ReadStructuralFeatureActionStruct
  class << self; include MetaReadStructuralFeatureAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaWriteStructuralFeatureAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'WriteStructuralFeatureAction'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(StructuralFeatureAction)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'value', InputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module WriteStructuralFeatureActionCommon
end

module WriteStructuralFeatureActionImpl
end


module WriteStructuralFeatureActionStruct
    
  __meta_reference__ 'value'

#TODO: QUITAR ESTO
include WriteStructuralFeatureActionCommon
include WriteStructuralFeatureActionImpl
end

class WriteStructuralFeatureAction
  include WriteStructuralFeatureActionStruct
  class << self; include MetaWriteStructuralFeatureAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaClearStructuralFeatureAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ClearStructuralFeatureAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(StructuralFeatureAction)
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

module ClearStructuralFeatureActionCommon
end

module ClearStructuralFeatureActionImpl
end


module ClearStructuralFeatureActionStruct
    

#TODO: QUITAR ESTO
include ClearStructuralFeatureActionCommon
include ClearStructuralFeatureActionImpl
end

class ClearStructuralFeatureAction
  include ClearStructuralFeatureActionStruct
  class << self; include MetaClearStructuralFeatureAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaRemoveStructuralFeatureValueAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'RemoveStructuralFeatureValueAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(WriteStructuralFeatureAction)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isRemoveDuplicates', ECore::EBoolean
    
      define_reference 'removeAt', InputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module RemoveStructuralFeatureValueActionCommon
end

module RemoveStructuralFeatureValueActionImpl
end


module RemoveStructuralFeatureValueActionStruct
  __meta_attribute__ 'isRemoveDuplicates'
    
  __meta_reference__ 'removeAt'

#TODO: QUITAR ESTO
include RemoveStructuralFeatureValueActionCommon
include RemoveStructuralFeatureValueActionImpl
end

class RemoveStructuralFeatureValueAction
  include RemoveStructuralFeatureValueActionStruct
  class << self; include MetaRemoveStructuralFeatureValueAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaAddStructuralFeatureValueAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'AddStructuralFeatureValueAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(WriteStructuralFeatureAction)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isReplaceAll', ECore::EBoolean
    
      define_reference 'insertAt', InputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module AddStructuralFeatureValueActionCommon
end

module AddStructuralFeatureValueActionImpl
end


module AddStructuralFeatureValueActionStruct
  __meta_attribute__ 'isReplaceAll'
    
  __meta_reference__ 'insertAt'

#TODO: QUITAR ESTO
include AddStructuralFeatureValueActionCommon
include AddStructuralFeatureValueActionImpl
end

class AddStructuralFeatureValueAction
  include AddStructuralFeatureValueActionStruct
  class << self; include MetaAddStructuralFeatureValueAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaLinkAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'LinkAction'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'endData', LinkEndData, :upperBound => -1, :containment => true
      define_reference 'inputValue', InputPin, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module LinkActionCommon
end

module LinkActionImpl
end


module LinkActionStruct
    
  __meta_reference__ 'endData'
  __meta_reference__ 'inputValue'

#TODO: QUITAR ESTO
include LinkActionCommon
include LinkActionImpl
end

class LinkAction
  include LinkActionStruct
  class << self; include MetaLinkAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaReadLinkAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ReadLinkAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(LinkAction)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'result', OutputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ReadLinkActionCommon
end

module ReadLinkActionImpl
end


module ReadLinkActionStruct
    
  __meta_reference__ 'result'

#TODO: QUITAR ESTO
include ReadLinkActionCommon
include ReadLinkActionImpl
end

class ReadLinkAction
  include ReadLinkActionStruct
  class << self; include MetaReadLinkAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaLinkEndCreationData
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'LinkEndCreationData'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(LinkEndData)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isReplaceAll', ECore::EBoolean
    
      define_reference 'insertAt', InputPin

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module LinkEndCreationDataCommon
end

module LinkEndCreationDataImpl
end


module LinkEndCreationDataStruct
  __meta_attribute__ 'isReplaceAll'
    
  __meta_reference__ 'insertAt'

#TODO: QUITAR ESTO
include LinkEndCreationDataCommon
include LinkEndCreationDataImpl
end

class LinkEndCreationData
  include LinkEndCreationDataStruct
  class << self; include MetaLinkEndCreationData; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaCreateLinkAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'CreateLinkAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(WriteLinkAction)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'endData', LinkEndCreationData, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module CreateLinkActionCommon
end

module CreateLinkActionImpl
end


module CreateLinkActionStruct
    
  __meta_reference__ 'endData'

#TODO: QUITAR ESTO
include CreateLinkActionCommon
include CreateLinkActionImpl
end

class CreateLinkAction
  include CreateLinkActionStruct
  class << self; include MetaCreateLinkAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaDestroyLinkAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'DestroyLinkAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(WriteLinkAction)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'endData', LinkEndDestructionData, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module DestroyLinkActionCommon
end

module DestroyLinkActionImpl
end


module DestroyLinkActionStruct
    
  __meta_reference__ 'endData'

#TODO: QUITAR ESTO
include DestroyLinkActionCommon
include DestroyLinkActionImpl
end

class DestroyLinkAction
  include DestroyLinkActionStruct
  class << self; include MetaDestroyLinkAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaWriteLinkAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'WriteLinkAction'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(LinkAction)
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

module WriteLinkActionCommon
end

module WriteLinkActionImpl
end


module WriteLinkActionStruct
    

#TODO: QUITAR ESTO
include WriteLinkActionCommon
include WriteLinkActionImpl
end

class WriteLinkAction
  include WriteLinkActionStruct
  class << self; include MetaWriteLinkAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaClearAssociationAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ClearAssociationAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'object', InputPin, :containment => true
      define_reference 'association', Association

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ClearAssociationActionCommon
end

module ClearAssociationActionImpl
end


module ClearAssociationActionStruct
    
  __meta_reference__ 'object'
  __meta_reference__ 'association'

#TODO: QUITAR ESTO
include ClearAssociationActionCommon
include ClearAssociationActionImpl
end

class ClearAssociationAction
  include ClearAssociationActionStruct
  class << self; include MetaClearAssociationAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaBroadcastSignalAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'BroadcastSignalAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(InvocationAction)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'signal', Signal

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module BroadcastSignalActionCommon
end

module BroadcastSignalActionImpl
end


module BroadcastSignalActionStruct
    
  __meta_reference__ 'signal'

#TODO: QUITAR ESTO
include BroadcastSignalActionCommon
include BroadcastSignalActionImpl
end

class BroadcastSignalAction
  include BroadcastSignalActionStruct
  class << self; include MetaBroadcastSignalAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaSendObjectAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'SendObjectAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(InvocationAction)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'target', InputPin, :containment => true
      define_reference 'request', InputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module SendObjectActionCommon
end

module SendObjectActionImpl
end


module SendObjectActionStruct
    
  __meta_reference__ 'target'
  __meta_reference__ 'request'

#TODO: QUITAR ESTO
include SendObjectActionCommon
include SendObjectActionImpl
end

class SendObjectAction
  include SendObjectActionStruct
  class << self; include MetaSendObjectAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaLinkEndDestructionData
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'LinkEndDestructionData'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(LinkEndData)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isDestroyDuplicates', ECore::EBoolean
    
      define_reference 'destroyAt', InputPin

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module LinkEndDestructionDataCommon
end

module LinkEndDestructionDataImpl
end


module LinkEndDestructionDataStruct
  __meta_attribute__ 'isDestroyDuplicates'
    
  __meta_reference__ 'destroyAt'

#TODO: QUITAR ESTO
include LinkEndDestructionDataCommon
include LinkEndDestructionDataImpl
end

class LinkEndDestructionData
  include LinkEndDestructionDataStruct
  class << self; include MetaLinkEndDestructionData; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaValueSpecificationAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ValueSpecificationAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'value', ValueSpecification, :containment => true
      define_reference 'result', OutputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ValueSpecificationActionCommon
end

module ValueSpecificationActionImpl
end


module ValueSpecificationActionStruct
    
  __meta_reference__ 'value'
  __meta_reference__ 'result'

#TODO: QUITAR ESTO
include ValueSpecificationActionCommon
include ValueSpecificationActionImpl
end

class ValueSpecificationAction
  include ValueSpecificationActionStruct
  class << self; include MetaValueSpecificationAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaTimeExpression
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'TimeExpression'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ValueSpecification)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'expr', ValueSpecification
      define_reference 'observation', Observation, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module TimeExpressionCommon
end

module TimeExpressionImpl
end


module TimeExpressionStruct
    
  __meta_reference__ 'expr'
  __meta_reference__ 'observation'

#TODO: QUITAR ESTO
include TimeExpressionCommon
include TimeExpressionImpl
end

class TimeExpression
  include TimeExpressionStruct
  class << self; include MetaTimeExpression; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaDuration
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Duration'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ValueSpecification)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'expr', ValueSpecification
      define_reference 'observation', Observation, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module DurationCommon
end

module DurationImpl
end


module DurationStruct
    
  __meta_reference__ 'expr'
  __meta_reference__ 'observation'

#TODO: QUITAR ESTO
include DurationCommon
include DurationImpl
end

class Duration
  include DurationStruct
  class << self; include MetaDuration; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaDurationInterval
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'DurationInterval'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Interval)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'min', Duration
      define_reference 'max', Duration

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module DurationIntervalCommon
end

module DurationIntervalImpl
end


module DurationIntervalStruct
    
  __meta_reference__ 'min'
  __meta_reference__ 'max'

#TODO: QUITAR ESTO
include DurationIntervalCommon
include DurationIntervalImpl
end

class DurationInterval
  include DurationIntervalStruct
  class << self; include MetaDurationInterval; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaTimeConstraint
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'TimeConstraint'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(IntervalConstraint)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'firstEvent', ECore::EBoolean
    
      define_reference 'specification', TimeInterval, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module TimeConstraintCommon
end

module TimeConstraintImpl
end


module TimeConstraintStruct
  __meta_attribute__ 'firstEvent'
    
  __meta_reference__ 'specification'

#TODO: QUITAR ESTO
include TimeConstraintCommon
include TimeConstraintImpl
end

class TimeConstraint
  include TimeConstraintStruct
  class << self; include MetaTimeConstraint; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaTimeInterval
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'TimeInterval'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Interval)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'max', TimeExpression
      define_reference 'min', TimeExpression

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module TimeIntervalCommon
end

module TimeIntervalImpl
end


module TimeIntervalStruct
    
  __meta_reference__ 'max'
  __meta_reference__ 'min'

#TODO: QUITAR ESTO
include TimeIntervalCommon
include TimeIntervalImpl
end

class TimeInterval
  include TimeIntervalStruct
  class << self; include MetaTimeInterval; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaDurationConstraint
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'DurationConstraint'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(IntervalConstraint)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'firstEvent', ECore::EBoolean
    
      define_reference 'specification', DurationInterval, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module DurationConstraintCommon
end

module DurationConstraintImpl
end


module DurationConstraintStruct
  __meta_attribute__ 'firstEvent'
    
  __meta_reference__ 'specification'

#TODO: QUITAR ESTO
include DurationConstraintCommon
include DurationConstraintImpl
end

class DurationConstraint
  include DurationConstraintStruct
  class << self; include MetaDurationConstraint; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaIntervalConstraint
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'IntervalConstraint'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Constraint)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'specification', Interval, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module IntervalConstraintCommon
end

module IntervalConstraintImpl
end


module IntervalConstraintStruct
    
  __meta_reference__ 'specification'

#TODO: QUITAR ESTO
include IntervalConstraintCommon
include IntervalConstraintImpl
end

class IntervalConstraint
  include IntervalConstraintStruct
  class << self; include MetaIntervalConstraint; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaInterval
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Interval'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ValueSpecification)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'min', ValueSpecification
      define_reference 'max', ValueSpecification

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module IntervalCommon
end

module IntervalImpl
end


module IntervalStruct
    
  __meta_reference__ 'min'
  __meta_reference__ 'max'

#TODO: QUITAR ESTO
include IntervalCommon
include IntervalImpl
end

class Interval
  include IntervalStruct
  class << self; include MetaInterval; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaObservation
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Observation'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(PackageableElement)
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

module ObservationCommon
end

module ObservationImpl
end


module ObservationStruct
    

#TODO: QUITAR ESTO
include ObservationCommon
include ObservationImpl
end

class Observation
  include ObservationStruct
  class << self; include MetaObservation; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaTimeObservation
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'TimeObservation'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Observation)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'firstEvent', ECore::EBoolean
    
      define_reference 'event', NamedElement

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module TimeObservationCommon
end

module TimeObservationImpl
end


module TimeObservationStruct
  __meta_attribute__ 'firstEvent'
    
  __meta_reference__ 'event'

#TODO: QUITAR ESTO
include TimeObservationCommon
include TimeObservationImpl
end

class TimeObservation
  include TimeObservationStruct
  class << self; include MetaTimeObservation; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaDurationObservation
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'DurationObservation'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Observation)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'firstEvent', ECore::EBoolean
    
      define_reference 'event', NamedElement

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module DurationObservationCommon
end

module DurationObservationImpl
end


module DurationObservationStruct
  __meta_attribute__ 'firstEvent'
    
  __meta_reference__ 'event'

#TODO: QUITAR ESTO
include DurationObservationCommon
include DurationObservationImpl
end

class DurationObservation
  include DurationObservationStruct
  class << self; include MetaDurationObservation; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaInvocationAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'InvocationAction'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'argument', InputPin, :upperBound => -1, :containment => true
      define_reference 'onPort', Port

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module InvocationActionCommon
end

module InvocationActionImpl
end


module InvocationActionStruct
    
  __meta_reference__ 'argument'
  __meta_reference__ 'onPort'

#TODO: QUITAR ESTO
include InvocationActionCommon
include InvocationActionImpl
end

class InvocationAction
  include InvocationActionStruct
  class << self; include MetaInvocationAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaTrigger
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Trigger'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(NamedElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'event', Event
      define_reference 'port', Port, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module TriggerCommon
end

module TriggerImpl
end


module TriggerStruct
    
  __meta_reference__ 'event'
  __meta_reference__ 'port'

#TODO: QUITAR ESTO
include TriggerCommon
include TriggerImpl
end

class Trigger
  include TriggerStruct
  class << self; include MetaTrigger; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaStateMachine
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'StateMachine'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Behavior)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'region', Region, :upperBound => -1, :containment => true
      define_reference 'connectionPoint', Pseudostate, :upperBound => -1, :containment => true
      define_reference 'extendedStateMachine', StateMachine, :upperBound => -1
      define_reference 'submachineState', State, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module StateMachineCommon
end

module StateMachineImpl
end


module StateMachineStruct
    
  __meta_reference__ 'region'
  __meta_reference__ 'connectionPoint'
  __meta_reference__ 'extendedStateMachine'
  __meta_reference__ 'submachineState'

#TODO: QUITAR ESTO
include StateMachineCommon
include StateMachineImpl
end

class StateMachine
  include StateMachineStruct
  class << self; include MetaStateMachine; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaPseudostate
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Pseudostate'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Vertex)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'kind', PseudostateKind
    
      define_reference 'stateMachine', StateMachine
      define_reference 'state', State

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module PseudostateCommon
end

module PseudostateImpl
end


module PseudostateStruct
  __meta_attribute__ 'kind'
    
  __meta_reference__ 'stateMachine'
  __meta_reference__ 'state'

#TODO: QUITAR ESTO
include PseudostateCommon
include PseudostateImpl
end

class Pseudostate
  include PseudostateStruct
  class << self; include MetaPseudostate; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaFinalState
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'FinalState'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(State)
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

module FinalStateCommon
end

module FinalStateImpl
end


module FinalStateStruct
    

#TODO: QUITAR ESTO
include FinalStateCommon
include FinalStateImpl
end

class FinalState
  include FinalStateStruct
  class << self; include MetaFinalState; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaConnectionPointReference
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ConnectionPointReference'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Vertex)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'entry', Pseudostate, :upperBound => -1
      define_reference 'state', State
      define_reference 'exit', Pseudostate, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ConnectionPointReferenceCommon
end

module ConnectionPointReferenceImpl
end


module ConnectionPointReferenceStruct
    
  __meta_reference__ 'entry'
  __meta_reference__ 'state'
  __meta_reference__ 'exit'

#TODO: QUITAR ESTO
include ConnectionPointReferenceCommon
include ConnectionPointReferenceImpl
end

class ConnectionPointReference
  include ConnectionPointReferenceStruct
  class << self; include MetaConnectionPointReference; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaTimeEvent
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'TimeEvent'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Event)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isRelative', ECore::EBoolean
    
      define_reference 'when', ValueSpecification, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module TimeEventCommon
end

module TimeEventImpl
end


module TimeEventStruct
  __meta_attribute__ 'isRelative'
    
  __meta_reference__ 'when'

#TODO: QUITAR ESTO
include TimeEventCommon
include TimeEventImpl
end

class TimeEvent
  include TimeEventStruct
  class << self; include MetaTimeEvent; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaStereotype
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Stereotype'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Class)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'icon', Image, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module StereotypeCommon
end

module StereotypeImpl
end


module StereotypeStruct
    
  __meta_reference__ 'icon'

#TODO: QUITAR ESTO
include StereotypeCommon
include StereotypeImpl
end

class Stereotype
  include StereotypeStruct
  class << self; include MetaStereotype; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaProfile
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Profile'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Package)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'ownedStereotype', Stereotype, :upperBound => -1, :containment => true
      define_reference 'metaclassReference', ElementImport, :upperBound => -1, :containment => true
      define_reference 'metamodelReference', PackageImport, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ProfileCommon
end

module ProfileImpl
end


module ProfileStruct
    
  __meta_reference__ 'ownedStereotype'
  __meta_reference__ 'metaclassReference'
  __meta_reference__ 'metamodelReference'

#TODO: QUITAR ESTO
include ProfileCommon
include ProfileImpl
end

class Profile
  include ProfileStruct
  class << self; include MetaProfile; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaClass
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Class'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(BehavioredClassifier, EncapsulatedClassifier)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isAbstract', ECore::EBoolean
      define_attribute 'isActive', ECore::EBoolean
    
      define_reference 'nestedClassifier', Classifier, :upperBound => -1, :containment => true
      define_reference 'ownedAttribute', Property, :upperBound => -1, :containment => true
      define_reference 'ownedOperation', Operation, :upperBound => -1, :containment => true
      define_reference 'superClass', Class, :upperBound => -1
      define_reference 'ownedReception', Reception, :upperBound => -1, :containment => true
      define_reference 'extension', Extension, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ClassCommon
end

module ClassImpl
end


module ClassStruct
  __meta_attribute__ 'isAbstract'
  __meta_attribute__ 'isActive'
    
  __meta_reference__ 'nestedClassifier'
  __meta_reference__ 'ownedAttribute'
  __meta_reference__ 'ownedOperation'
  __meta_reference__ 'superClass'
  __meta_reference__ 'ownedReception'
  __meta_reference__ 'extension'

#TODO: QUITAR ESTO
include ClassCommon
include ClassImpl
end

class Class
  include ClassStruct
  class << self; include MetaClass; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaProfileApplication
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ProfileApplication'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(DirectedRelationship)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isStrict', ECore::EBoolean
    
      define_reference 'appliedProfile', Profile
      define_reference 'applyingPackage', Package

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ProfileApplicationCommon
end

module ProfileApplicationImpl
end


module ProfileApplicationStruct
  __meta_attribute__ 'isStrict'
    
  __meta_reference__ 'appliedProfile'
  __meta_reference__ 'applyingPackage'

#TODO: QUITAR ESTO
include ProfileApplicationCommon
include ProfileApplicationImpl
end

class ProfileApplication
  include ProfileApplicationStruct
  class << self; include MetaProfileApplication; end      
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
    define_super_types(Association)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isRequired', ECore::EBoolean
    
      define_reference 'metaclass', Class
      define_reference 'ownedEnd', ExtensionEnd, :containment => true

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
  __meta_attribute__ 'isRequired'
    
  __meta_reference__ 'metaclass'
  __meta_reference__ 'ownedEnd'

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
  

module MetaImage
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Image'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Element)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'content', ECore::EString
      define_attribute 'location', ECore::EString
      define_attribute 'format', ECore::EString
    

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ImageCommon
end

module ImageImpl
end


module ImageStruct
  __meta_attribute__ 'content'
  __meta_attribute__ 'location'
  __meta_attribute__ 'format'
    

#TODO: QUITAR ESTO
include ImageCommon
include ImageImpl
end

class Image
  include ImageStruct
  class << self; include MetaImage; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaElement
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Element'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(ECore::EModelElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'ownedElement', Element, :upperBound => -1, :containment => true
      define_reference 'owner', Element
      define_reference 'ownedComment', Comment, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ElementCommon
end

module ElementImpl
end


module ElementStruct
    
  __meta_reference__ 'ownedElement'
  __meta_reference__ 'owner'
  __meta_reference__ 'ownedComment'

#TODO: QUITAR ESTO
include ElementCommon
include ElementImpl
end

class Element
  include ElementStruct
  class << self; include MetaElement; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaExtensionEnd
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ExtensionEnd'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Property)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'lower', ECore::EInt
    
      define_reference 'type', Stereotype

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ExtensionEndCommon
end

module ExtensionEndImpl
end


module ExtensionEndStruct
  __meta_attribute__ 'lower'
    
  __meta_reference__ 'type'

#TODO: QUITAR ESTO
include ExtensionEndCommon
include ExtensionEndImpl
end

class ExtensionEnd
  include ExtensionEndStruct
  class << self; include MetaExtensionEnd; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaVariableAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'VariableAction'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'variable', Variable

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module VariableActionCommon
end

module VariableActionImpl
end


module VariableActionStruct
    
  __meta_reference__ 'variable'

#TODO: QUITAR ESTO
include VariableActionCommon
include VariableActionImpl
end

class VariableAction
  include VariableActionStruct
  class << self; include MetaVariableAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaReadVariableAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ReadVariableAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(VariableAction)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'result', OutputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ReadVariableActionCommon
end

module ReadVariableActionImpl
end


module ReadVariableActionStruct
    
  __meta_reference__ 'result'

#TODO: QUITAR ESTO
include ReadVariableActionCommon
include ReadVariableActionImpl
end

class ReadVariableAction
  include ReadVariableActionStruct
  class << self; include MetaReadVariableAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaWriteVariableAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'WriteVariableAction'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(VariableAction)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'value', InputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module WriteVariableActionCommon
end

module WriteVariableActionImpl
end


module WriteVariableActionStruct
    
  __meta_reference__ 'value'

#TODO: QUITAR ESTO
include WriteVariableActionCommon
include WriteVariableActionImpl
end

class WriteVariableAction
  include WriteVariableActionStruct
  class << self; include MetaWriteVariableAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaClearVariableAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ClearVariableAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(VariableAction)
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

module ClearVariableActionCommon
end

module ClearVariableActionImpl
end


module ClearVariableActionStruct
    

#TODO: QUITAR ESTO
include ClearVariableActionCommon
include ClearVariableActionImpl
end

class ClearVariableAction
  include ClearVariableActionStruct
  class << self; include MetaClearVariableAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaAddVariableValueAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'AddVariableValueAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(WriteVariableAction)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isReplaceAll', ECore::EBoolean
    
      define_reference 'insertAt', InputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module AddVariableValueActionCommon
end

module AddVariableValueActionImpl
end


module AddVariableValueActionStruct
  __meta_attribute__ 'isReplaceAll'
    
  __meta_reference__ 'insertAt'

#TODO: QUITAR ESTO
include AddVariableValueActionCommon
include AddVariableValueActionImpl
end

class AddVariableValueAction
  include AddVariableValueActionStruct
  class << self; include MetaAddVariableValueAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaRemoveVariableValueAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'RemoveVariableValueAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(WriteVariableAction)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isRemoveDuplicates', ECore::EBoolean
    
      define_reference 'removeAt', InputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module RemoveVariableValueActionCommon
end

module RemoveVariableValueActionImpl
end


module RemoveVariableValueActionStruct
  __meta_attribute__ 'isRemoveDuplicates'
    
  __meta_reference__ 'removeAt'

#TODO: QUITAR ESTO
include RemoveVariableValueActionCommon
include RemoveVariableValueActionImpl
end

class RemoveVariableValueAction
  include RemoveVariableValueActionStruct
  class << self; include MetaRemoveVariableValueAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaRaiseExceptionAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'RaiseExceptionAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'exception', InputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module RaiseExceptionActionCommon
end

module RaiseExceptionActionImpl
end


module RaiseExceptionActionStruct
    
  __meta_reference__ 'exception'

#TODO: QUITAR ESTO
include RaiseExceptionActionCommon
include RaiseExceptionActionImpl
end

class RaiseExceptionAction
  include RaiseExceptionActionStruct
  class << self; include MetaRaiseExceptionAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaActionInputPin
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ActionInputPin'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(InputPin)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'fromAction', Action, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ActionInputPinCommon
end

module ActionInputPinImpl
end


module ActionInputPinStruct
    
  __meta_reference__ 'fromAction'

#TODO: QUITAR ESTO
include ActionInputPinCommon
include ActionInputPinImpl
end

class ActionInputPin
  include ActionInputPinStruct
  class << self; include MetaActionInputPin; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaGeneralizationSet
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'GeneralizationSet'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(PackageableElement)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isCovering', ECore::EBoolean
      define_attribute 'isDisjoint', ECore::EBoolean
    
      define_reference 'powertype', Classifier
      define_reference 'generalization', Generalization, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module GeneralizationSetCommon
end

module GeneralizationSetImpl
end


module GeneralizationSetStruct
  __meta_attribute__ 'isCovering'
  __meta_attribute__ 'isDisjoint'
    
  __meta_reference__ 'powertype'
  __meta_reference__ 'generalization'

#TODO: QUITAR ESTO
include GeneralizationSetCommon
include GeneralizationSetImpl
end

class GeneralizationSet
  include GeneralizationSetStruct
  class << self; include MetaGeneralizationSet; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaGeneralization
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Generalization'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(DirectedRelationship)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isSubstitutable', ECore::EBoolean
    
      define_reference 'specific', Classifier
      define_reference 'general', Classifier
      define_reference 'generalizationSet', GeneralizationSet, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module GeneralizationCommon
end

module GeneralizationImpl
end


module GeneralizationStruct
  __meta_attribute__ 'isSubstitutable'
    
  __meta_reference__ 'specific'
  __meta_reference__ 'general'
  __meta_reference__ 'generalizationSet'

#TODO: QUITAR ESTO
include GeneralizationCommon
include GeneralizationImpl
end

class Generalization
  include GeneralizationStruct
  class << self; include MetaGeneralization; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaInformationItem
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'InformationItem'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Classifier)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'represented', Classifier, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module InformationItemCommon
end

module InformationItemImpl
end


module InformationItemStruct
    
  __meta_reference__ 'represented'

#TODO: QUITAR ESTO
include InformationItemCommon
include InformationItemImpl
end

class InformationItem
  include InformationItemStruct
  class << self; include MetaInformationItem; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaInformationFlow
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'InformationFlow'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(DirectedRelationship, PackageableElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'realization', Relationship, :upperBound => -1
      define_reference 'conveyed', Classifier, :upperBound => -1
      define_reference 'informationSource', NamedElement, :upperBound => -1
      define_reference 'informationTarget', NamedElement, :upperBound => -1
      define_reference 'realizingActivityEdge', ActivityEdge, :upperBound => -1
      define_reference 'realizingConnector', Connector, :upperBound => -1
      define_reference 'realizingMessage', Message, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module InformationFlowCommon
end

module InformationFlowImpl
end


module InformationFlowStruct
    
  __meta_reference__ 'realization'
  __meta_reference__ 'conveyed'
  __meta_reference__ 'informationSource'
  __meta_reference__ 'informationTarget'
  __meta_reference__ 'realizingActivityEdge'
  __meta_reference__ 'realizingConnector'
  __meta_reference__ 'realizingMessage'

#TODO: QUITAR ESTO
include InformationFlowCommon
include InformationFlowImpl
end

class InformationFlow
  include InformationFlowStruct
  class << self; include MetaInformationFlow; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaModel
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Model'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Package)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'viewpoint', ECore::EString
    

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ModelCommon
end

module ModelImpl
end


module ModelStruct
  __meta_attribute__ 'viewpoint'
    

#TODO: QUITAR ESTO
include ModelCommon
include ModelImpl
end

class Model
  include ModelStruct
  class << self; include MetaModel; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaReadExtentAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ReadExtentAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'result', OutputPin, :containment => true
      define_reference 'classifier', Classifier

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ReadExtentActionCommon
end

module ReadExtentActionImpl
end


module ReadExtentActionStruct
    
  __meta_reference__ 'result'
  __meta_reference__ 'classifier'

#TODO: QUITAR ESTO
include ReadExtentActionCommon
include ReadExtentActionImpl
end

class ReadExtentAction
  include ReadExtentActionStruct
  class << self; include MetaReadExtentAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaReclassifyObjectAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ReclassifyObjectAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isReplaceAll', ECore::EBoolean
    
      define_reference 'oldClassifier', Classifier, :upperBound => -1
      define_reference 'newClassifier', Classifier, :upperBound => -1
      define_reference 'object', InputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ReclassifyObjectActionCommon
end

module ReclassifyObjectActionImpl
end


module ReclassifyObjectActionStruct
  __meta_attribute__ 'isReplaceAll'
    
  __meta_reference__ 'oldClassifier'
  __meta_reference__ 'newClassifier'
  __meta_reference__ 'object'

#TODO: QUITAR ESTO
include ReclassifyObjectActionCommon
include ReclassifyObjectActionImpl
end

class ReclassifyObjectAction
  include ReclassifyObjectActionStruct
  class << self; include MetaReclassifyObjectAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaReadIsClassifiedObjectAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ReadIsClassifiedObjectAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isDirect', ECore::EBoolean
    
      define_reference 'classifier', Classifier
      define_reference 'result', OutputPin, :containment => true
      define_reference 'object', InputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ReadIsClassifiedObjectActionCommon
end

module ReadIsClassifiedObjectActionImpl
end


module ReadIsClassifiedObjectActionStruct
  __meta_attribute__ 'isDirect'
    
  __meta_reference__ 'classifier'
  __meta_reference__ 'result'
  __meta_reference__ 'object'

#TODO: QUITAR ESTO
include ReadIsClassifiedObjectActionCommon
include ReadIsClassifiedObjectActionImpl
end

class ReadIsClassifiedObjectAction
  include ReadIsClassifiedObjectActionStruct
  class << self; include MetaReadIsClassifiedObjectAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaStartClassifierBehaviorAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'StartClassifierBehaviorAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'object', InputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module StartClassifierBehaviorActionCommon
end

module StartClassifierBehaviorActionImpl
end


module StartClassifierBehaviorActionStruct
    
  __meta_reference__ 'object'

#TODO: QUITAR ESTO
include StartClassifierBehaviorActionCommon
include StartClassifierBehaviorActionImpl
end

class StartClassifierBehaviorAction
  include StartClassifierBehaviorActionStruct
  class << self; include MetaStartClassifierBehaviorAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaQualifierValue
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'QualifierValue'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Element)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'qualifier', Property
      define_reference 'value', InputPin

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module QualifierValueCommon
end

module QualifierValueImpl
end


module QualifierValueStruct
    
  __meta_reference__ 'qualifier'
  __meta_reference__ 'value'

#TODO: QUITAR ESTO
include QualifierValueCommon
include QualifierValueImpl
end

class QualifierValue
  include QualifierValueStruct
  class << self; include MetaQualifierValue; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaLinkEndData
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'LinkEndData'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Element)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'value', InputPin
      define_reference 'end', Property
      define_reference 'qualifier', QualifierValue, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module LinkEndDataCommon
end

module LinkEndDataImpl
end


module LinkEndDataStruct
    
  __meta_reference__ 'value'
  __meta_reference__ 'end'
  __meta_reference__ 'qualifier'

#TODO: QUITAR ESTO
include LinkEndDataCommon
include LinkEndDataImpl
end

class LinkEndData
  include LinkEndDataStruct
  class << self; include MetaLinkEndData; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaReadLinkObjectEndAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ReadLinkObjectEndAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'object', InputPin, :containment => true
      define_reference 'end', Property
      define_reference 'result', OutputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ReadLinkObjectEndActionCommon
end

module ReadLinkObjectEndActionImpl
end


module ReadLinkObjectEndActionStruct
    
  __meta_reference__ 'object'
  __meta_reference__ 'end'
  __meta_reference__ 'result'

#TODO: QUITAR ESTO
include ReadLinkObjectEndActionCommon
include ReadLinkObjectEndActionImpl
end

class ReadLinkObjectEndAction
  include ReadLinkObjectEndActionStruct
  class << self; include MetaReadLinkObjectEndAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaReadLinkObjectEndQualifierAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ReadLinkObjectEndQualifierAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'object', InputPin, :containment => true
      define_reference 'result', OutputPin, :containment => true
      define_reference 'qualifier', Property

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ReadLinkObjectEndQualifierActionCommon
end

module ReadLinkObjectEndQualifierActionImpl
end


module ReadLinkObjectEndQualifierActionStruct
    
  __meta_reference__ 'object'
  __meta_reference__ 'result'
  __meta_reference__ 'qualifier'

#TODO: QUITAR ESTO
include ReadLinkObjectEndQualifierActionCommon
include ReadLinkObjectEndQualifierActionImpl
end

class ReadLinkObjectEndQualifierAction
  include ReadLinkObjectEndQualifierActionStruct
  class << self; include MetaReadLinkObjectEndQualifierAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaCreateLinkObjectAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'CreateLinkObjectAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(CreateLinkAction)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'result', OutputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module CreateLinkObjectActionCommon
end

module CreateLinkObjectActionImpl
end


module CreateLinkObjectActionStruct
    
  __meta_reference__ 'result'

#TODO: QUITAR ESTO
include CreateLinkObjectActionCommon
include CreateLinkObjectActionImpl
end

class CreateLinkObjectAction
  include CreateLinkObjectActionStruct
  class << self; include MetaCreateLinkObjectAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaAcceptEventAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'AcceptEventAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isUnmarshall', ECore::EBoolean
    
      define_reference 'result', OutputPin, :upperBound => -1, :containment => true
      define_reference 'trigger', Trigger, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module AcceptEventActionCommon
end

module AcceptEventActionImpl
end


module AcceptEventActionStruct
  __meta_attribute__ 'isUnmarshall'
    
  __meta_reference__ 'result'
  __meta_reference__ 'trigger'

#TODO: QUITAR ESTO
include AcceptEventActionCommon
include AcceptEventActionImpl
end

class AcceptEventAction
  include AcceptEventActionStruct
  class << self; include MetaAcceptEventAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaAcceptCallAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'AcceptCallAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(AcceptEventAction)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'returnInformation', OutputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module AcceptCallActionCommon
end

module AcceptCallActionImpl
end


module AcceptCallActionStruct
    
  __meta_reference__ 'returnInformation'

#TODO: QUITAR ESTO
include AcceptCallActionCommon
include AcceptCallActionImpl
end

class AcceptCallAction
  include AcceptCallActionStruct
  class << self; include MetaAcceptCallAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaReplyAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ReplyAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'replyToCall', Trigger
      define_reference 'returnInformation', InputPin, :containment => true
      define_reference 'replyValue', InputPin, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ReplyActionCommon
end

module ReplyActionImpl
end


module ReplyActionStruct
    
  __meta_reference__ 'replyToCall'
  __meta_reference__ 'returnInformation'
  __meta_reference__ 'replyValue'

#TODO: QUITAR ESTO
include ReplyActionCommon
include ReplyActionImpl
end

class ReplyAction
  include ReplyActionStruct
  class << self; include MetaReplyAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaUnmarshallAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'UnmarshallAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'result', OutputPin, :upperBound => -1, :containment => true
      define_reference 'unmarshallType', Classifier
      define_reference 'object', InputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module UnmarshallActionCommon
end

module UnmarshallActionImpl
end


module UnmarshallActionStruct
    
  __meta_reference__ 'result'
  __meta_reference__ 'unmarshallType'
  __meta_reference__ 'object'

#TODO: QUITAR ESTO
include UnmarshallActionCommon
include UnmarshallActionImpl
end

class UnmarshallAction
  include UnmarshallActionStruct
  class << self; include MetaUnmarshallAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaReduceAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ReduceAction'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Action)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isOrdered', ECore::EBoolean
    
      define_reference 'reducer', Behavior
      define_reference 'result', OutputPin, :containment => true
      define_reference 'collection', InputPin, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ReduceActionCommon
end

module ReduceActionImpl
end


module ReduceActionStruct
  __meta_attribute__ 'isOrdered'
    
  __meta_reference__ 'reducer'
  __meta_reference__ 'result'
  __meta_reference__ 'collection'

#TODO: QUITAR ESTO
include ReduceActionCommon
include ReduceActionImpl
end

class ReduceAction
  include ReduceActionStruct
  class << self; include MetaReduceAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaJoinNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'JoinNode'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ControlNode)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isCombineDuplicate', ECore::EBoolean
    
      define_reference 'joinSpec', ValueSpecification, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module JoinNodeCommon
end

module JoinNodeImpl
end


module JoinNodeStruct
  __meta_attribute__ 'isCombineDuplicate'
    
  __meta_reference__ 'joinSpec'

#TODO: QUITAR ESTO
include JoinNodeCommon
include JoinNodeImpl
end

class JoinNode
  include JoinNodeStruct
  class << self; include MetaJoinNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaDataStoreNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'DataStoreNode'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(CentralBufferNode)
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

module DataStoreNodeCommon
end

module DataStoreNodeImpl
end


module DataStoreNodeStruct
    

#TODO: QUITAR ESTO
include DataStoreNodeCommon
include DataStoreNodeImpl
end

class DataStoreNode
  include DataStoreNodeStruct
  class << self; include MetaDataStoreNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaObjectFlow
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ObjectFlow'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ActivityEdge)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isMulticast', ECore::EBoolean
      define_attribute 'isMultireceive', ECore::EBoolean
    
      define_reference 'transformation', Behavior
      define_reference 'selection', Behavior

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ObjectFlowCommon
end

module ObjectFlowImpl
end


module ObjectFlowStruct
  __meta_attribute__ 'isMulticast'
  __meta_attribute__ 'isMultireceive'
    
  __meta_reference__ 'transformation'
  __meta_reference__ 'selection'

#TODO: QUITAR ESTO
include ObjectFlowCommon
include ObjectFlowImpl
end

class ObjectFlow
  include ObjectFlowStruct
  class << self; include MetaObjectFlow; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaObjectNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ObjectNode'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(ActivityNode, TypedElement)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'ordering', ObjectNodeOrderingKind
      define_attribute 'isControlType', ECore::EBoolean
    
      define_reference 'upperBound', ValueSpecification, :containment => true
      define_reference 'inState', State, :upperBound => -1
      define_reference 'selection', Behavior

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ObjectNodeCommon
end

module ObjectNodeImpl
end


module ObjectNodeStruct
  __meta_attribute__ 'ordering'
  __meta_attribute__ 'isControlType'
    
  __meta_reference__ 'upperBound'
  __meta_reference__ 'inState'
  __meta_reference__ 'selection'

#TODO: QUITAR ESTO
include ObjectNodeCommon
include ObjectNodeImpl
end

class ObjectNode
  include ObjectNodeStruct
  class << self; include MetaObjectNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaParameterSet
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ParameterSet'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(NamedElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'parameter', Parameter, :upperBound => -1
      define_reference 'condition', Constraint, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ParameterSetCommon
end

module ParameterSetImpl
end


module ParameterSetStruct
    
  __meta_reference__ 'parameter'
  __meta_reference__ 'condition'

#TODO: QUITAR ESTO
include ParameterSetCommon
include ParameterSetImpl
end

class ParameterSet
  include ParameterSetStruct
  class << self; include MetaParameterSet; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaActivity
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Activity'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Behavior)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isReadOnly', ECore::EBoolean
      define_attribute 'isSingleExecution', ECore::EBoolean
    
      define_reference 'structuredNode', StructuredActivityNode, :upperBound => -1, :containment => true
      define_reference 'variable', Variable, :upperBound => -1, :containment => true
      define_reference 'node', ActivityNode, :upperBound => -1, :containment => true
      define_reference 'edge', ActivityEdge, :upperBound => -1, :containment => true
      define_reference 'partition', ActivityPartition, :upperBound => -1
      define_reference 'group', ActivityGroup, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ActivityCommon
end

module ActivityImpl
end


module ActivityStruct
  __meta_attribute__ 'isReadOnly'
  __meta_attribute__ 'isSingleExecution'
    
  __meta_reference__ 'structuredNode'
  __meta_reference__ 'variable'
  __meta_reference__ 'node'
  __meta_reference__ 'edge'
  __meta_reference__ 'partition'
  __meta_reference__ 'group'

#TODO: QUITAR ESTO
include ActivityCommon
include ActivityImpl
end

class Activity
  include ActivityStruct
  class << self; include MetaActivity; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaParameter
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Parameter'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(MultiplicityElement, ConnectableElement)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'direction', ParameterDirectionKind
      define_attribute 'default', ECore::EString
      define_attribute 'isException', ECore::EBoolean
      define_attribute 'isStream', ECore::EBoolean
      define_attribute 'effect', ParameterEffectKind
    
      define_reference 'defaultValue', ValueSpecification, :containment => true
      define_reference 'operation', Operation
      define_reference 'parameterSet', ParameterSet, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ParameterCommon
end

module ParameterImpl
end


module ParameterStruct
  __meta_attribute__ 'direction'
  __meta_attribute__ 'default'
  __meta_attribute__ 'isException'
  __meta_attribute__ 'isStream'
  __meta_attribute__ 'effect'
    
  __meta_reference__ 'defaultValue'
  __meta_reference__ 'operation'
  __meta_reference__ 'parameterSet'

#TODO: QUITAR ESTO
include ParameterCommon
include ParameterImpl
end

class Parameter
  include ParameterStruct
  class << self; include MetaParameter; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaAction
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Action'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(ExecutableNode)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'output', OutputPin, :upperBound => -1, :containment => true
      define_reference 'input', InputPin, :upperBound => -1, :containment => true
      define_reference 'context', Classifier
      define_reference 'localPrecondition', Constraint, :upperBound => -1, :containment => true
      define_reference 'localPostcondition', Constraint, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ActionCommon
end

module ActionImpl
end


module ActionStruct
    
  __meta_reference__ 'output'
  __meta_reference__ 'input'
  __meta_reference__ 'context'
  __meta_reference__ 'localPrecondition'
  __meta_reference__ 'localPostcondition'

#TODO: QUITAR ESTO
include ActionCommon
include ActionImpl
end

class Action
  include ActionStruct
  class << self; include MetaAction; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaInterruptibleActivityRegion
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'InterruptibleActivityRegion'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ActivityGroup)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'interruptingEdge', ActivityEdge, :upperBound => -1
      define_reference 'node', ActivityNode, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module InterruptibleActivityRegionCommon
end

module InterruptibleActivityRegionImpl
end


module InterruptibleActivityRegionStruct
    
  __meta_reference__ 'interruptingEdge'
  __meta_reference__ 'node'

#TODO: QUITAR ESTO
include InterruptibleActivityRegionCommon
include InterruptibleActivityRegionImpl
end

class InterruptibleActivityRegion
  include InterruptibleActivityRegionStruct
  class << self; include MetaInterruptibleActivityRegion; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaActivityNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ActivityNode'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(RedefinableElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'inStructuredNode', StructuredActivityNode
      define_reference 'activity', Activity
      define_reference 'outgoing', ActivityEdge, :upperBound => -1
      define_reference 'incoming', ActivityEdge, :upperBound => -1
      define_reference 'redefinedNode', ActivityNode, :upperBound => -1
      define_reference 'inPartition', ActivityPartition, :upperBound => -1
      define_reference 'inInterruptibleRegion', InterruptibleActivityRegion, :upperBound => -1
      define_reference 'inGroup', ActivityGroup, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ActivityNodeCommon
end

module ActivityNodeImpl
end


module ActivityNodeStruct
    
  __meta_reference__ 'inStructuredNode'
  __meta_reference__ 'activity'
  __meta_reference__ 'outgoing'
  __meta_reference__ 'incoming'
  __meta_reference__ 'redefinedNode'
  __meta_reference__ 'inPartition'
  __meta_reference__ 'inInterruptibleRegion'
  __meta_reference__ 'inGroup'

#TODO: QUITAR ESTO
include ActivityNodeCommon
include ActivityNodeImpl
end

class ActivityNode
  include ActivityNodeStruct
  class << self; include MetaActivityNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaBehavioralFeature
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'BehavioralFeature'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(Feature, Namespace)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isAbstract', ECore::EBoolean
      define_attribute 'concurrency', CallConcurrencyKind
    
      define_reference 'ownedParameter', Parameter, :upperBound => -1, :containment => true
      define_reference 'method', Behavior, :upperBound => -1
      define_reference 'raisedException', Type, :upperBound => -1
      define_reference 'ownedParameterSet', ParameterSet, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module BehavioralFeatureCommon
end

module BehavioralFeatureImpl
end


module BehavioralFeatureStruct
  __meta_attribute__ 'isAbstract'
  __meta_attribute__ 'concurrency'
    
  __meta_reference__ 'ownedParameter'
  __meta_reference__ 'method'
  __meta_reference__ 'raisedException'
  __meta_reference__ 'ownedParameterSet'

#TODO: QUITAR ESTO
include BehavioralFeatureCommon
include BehavioralFeatureImpl
end

class BehavioralFeature
  include BehavioralFeatureStruct
  class << self; include MetaBehavioralFeature; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaBehavior
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Behavior'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(Class)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isReentrant', ECore::EBoolean
    
      define_reference 'redefinedBehavior', Behavior, :upperBound => -1
      define_reference 'specification', BehavioralFeature
      define_reference 'ownedParameter', Parameter, :upperBound => -1, :containment => true
      define_reference 'context', BehavioredClassifier
      define_reference 'precondition', Constraint, :upperBound => -1, :containment => true
      define_reference 'postcondition', Constraint, :upperBound => -1, :containment => true
      define_reference 'ownedParameterSet', ParameterSet, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module BehaviorCommon
end

module BehaviorImpl
end


module BehaviorStruct
  __meta_attribute__ 'isReentrant'
    
  __meta_reference__ 'redefinedBehavior'
  __meta_reference__ 'specification'
  __meta_reference__ 'ownedParameter'
  __meta_reference__ 'context'
  __meta_reference__ 'precondition'
  __meta_reference__ 'postcondition'
  __meta_reference__ 'ownedParameterSet'

#TODO: QUITAR ESTO
include BehaviorCommon
include BehaviorImpl
end

class Behavior
  include BehaviorStruct
  class << self; include MetaBehavior; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaPin
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Pin'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(MultiplicityElement, ObjectNode)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isControl', ECore::EBoolean
    

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module PinCommon
end

module PinImpl
end


module PinStruct
  __meta_attribute__ 'isControl'
    

#TODO: QUITAR ESTO
include PinCommon
include PinImpl
end

class Pin
  include PinStruct
  class << self; include MetaPin; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaConditionalNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ConditionalNode'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(StructuredActivityNode)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isDeterminate', ECore::EBoolean
      define_attribute 'isAssured', ECore::EBoolean
    
      define_reference 'clause', Clause, :upperBound => -1, :containment => true
      define_reference 'result', OutputPin, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ConditionalNodeCommon
end

module ConditionalNodeImpl
end


module ConditionalNodeStruct
  __meta_attribute__ 'isDeterminate'
  __meta_attribute__ 'isAssured'
    
  __meta_reference__ 'clause'
  __meta_reference__ 'result'

#TODO: QUITAR ESTO
include ConditionalNodeCommon
include ConditionalNodeImpl
end

class ConditionalNode
  include ConditionalNodeStruct
  class << self; include MetaConditionalNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaStructuredActivityNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'StructuredActivityNode'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Namespace, Action, ActivityGroup)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'mustIsolate', ECore::EBoolean
    
      define_reference 'variable', Variable, :upperBound => -1, :containment => true
      define_reference 'node', ActivityNode, :upperBound => -1, :containment => true
      define_reference 'activity', Activity
      define_reference 'edge', ActivityEdge, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module StructuredActivityNodeCommon
end

module StructuredActivityNodeImpl
end


module StructuredActivityNodeStruct
  __meta_attribute__ 'mustIsolate'
    
  __meta_reference__ 'variable'
  __meta_reference__ 'node'
  __meta_reference__ 'activity'
  __meta_reference__ 'edge'

#TODO: QUITAR ESTO
include StructuredActivityNodeCommon
include StructuredActivityNodeImpl
end

class StructuredActivityNode
  include StructuredActivityNodeStruct
  class << self; include MetaStructuredActivityNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaLoopNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'LoopNode'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(StructuredActivityNode)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isTestedFirst', ECore::EBoolean
    
      define_reference 'bodyPart', ExecutableNode, :upperBound => -1
      define_reference 'setupPart', ExecutableNode, :upperBound => -1
      define_reference 'decider', OutputPin
      define_reference 'test', ExecutableNode, :upperBound => -1
      define_reference 'result', OutputPin, :upperBound => -1, :containment => true
      define_reference 'loopVariable', OutputPin, :upperBound => -1
      define_reference 'bodyOutput', OutputPin, :upperBound => -1
      define_reference 'loopVariableInput', InputPin, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module LoopNodeCommon
end

module LoopNodeImpl
end


module LoopNodeStruct
  __meta_attribute__ 'isTestedFirst'
    
  __meta_reference__ 'bodyPart'
  __meta_reference__ 'setupPart'
  __meta_reference__ 'decider'
  __meta_reference__ 'test'
  __meta_reference__ 'result'
  __meta_reference__ 'loopVariable'
  __meta_reference__ 'bodyOutput'
  __meta_reference__ 'loopVariableInput'

#TODO: QUITAR ESTO
include LoopNodeCommon
include LoopNodeImpl
end

class LoopNode
  include LoopNodeStruct
  class << self; include MetaLoopNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaClause
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Clause'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Element)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'test', ExecutableNode, :upperBound => -1
      define_reference 'body', ExecutableNode, :upperBound => -1
      define_reference 'predecessorClause', Clause, :upperBound => -1
      define_reference 'successorClause', Clause, :upperBound => -1
      define_reference 'decider', OutputPin
      define_reference 'bodyOutput', OutputPin, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ClauseCommon
end

module ClauseImpl
end


module ClauseStruct
    
  __meta_reference__ 'test'
  __meta_reference__ 'body'
  __meta_reference__ 'predecessorClause'
  __meta_reference__ 'successorClause'
  __meta_reference__ 'decider'
  __meta_reference__ 'bodyOutput'

#TODO: QUITAR ESTO
include ClauseCommon
include ClauseImpl
end

class Clause
  include ClauseStruct
  class << self; include MetaClause; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaActivityEdge
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ActivityEdge'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(RedefinableElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'activity', Activity
      define_reference 'source', ActivityNode
      define_reference 'target', ActivityNode
      define_reference 'redefinedEdge', ActivityEdge, :upperBound => -1
      define_reference 'inPartition', ActivityPartition, :upperBound => -1
      define_reference 'guard', ValueSpecification, :containment => true
      define_reference 'weight', ValueSpecification, :containment => true
      define_reference 'interrupts', InterruptibleActivityRegion
      define_reference 'inStructuredNode', StructuredActivityNode
      define_reference 'inGroup', ActivityGroup, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ActivityEdgeCommon
end

module ActivityEdgeImpl
end


module ActivityEdgeStruct
    
  __meta_reference__ 'activity'
  __meta_reference__ 'source'
  __meta_reference__ 'target'
  __meta_reference__ 'redefinedEdge'
  __meta_reference__ 'inPartition'
  __meta_reference__ 'guard'
  __meta_reference__ 'weight'
  __meta_reference__ 'interrupts'
  __meta_reference__ 'inStructuredNode'
  __meta_reference__ 'inGroup'

#TODO: QUITAR ESTO
include ActivityEdgeCommon
include ActivityEdgeImpl
end

class ActivityEdge
  include ActivityEdgeStruct
  class << self; include MetaActivityEdge; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaActivityGroup
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ActivityGroup'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(Element)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'subgroup', ActivityGroup, :upperBound => -1, :containment => true
      define_reference 'superGroup', ActivityGroup
      define_reference 'inActivity', Activity
      define_reference 'containedNode', ActivityNode, :upperBound => -1
      define_reference 'containedEdge', ActivityEdge, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ActivityGroupCommon
end

module ActivityGroupImpl
end


module ActivityGroupStruct
    
  __meta_reference__ 'subgroup'
  __meta_reference__ 'superGroup'
  __meta_reference__ 'inActivity'
  __meta_reference__ 'containedNode'
  __meta_reference__ 'containedEdge'

#TODO: QUITAR ESTO
include ActivityGroupCommon
include ActivityGroupImpl
end

class ActivityGroup
  include ActivityGroupStruct
  class << self; include MetaActivityGroup; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaExpansionNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ExpansionNode'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ObjectNode)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'regionAsOutput', ExpansionRegion
      define_reference 'regionAsInput', ExpansionRegion

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ExpansionNodeCommon
end

module ExpansionNodeImpl
end


module ExpansionNodeStruct
    
  __meta_reference__ 'regionAsOutput'
  __meta_reference__ 'regionAsInput'

#TODO: QUITAR ESTO
include ExpansionNodeCommon
include ExpansionNodeImpl
end

class ExpansionNode
  include ExpansionNodeStruct
  class << self; include MetaExpansionNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaExpansionRegion
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ExpansionRegion'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(StructuredActivityNode)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'mode', ExpansionKind
    
      define_reference 'outputElement', ExpansionNode, :upperBound => -1
      define_reference 'inputElement', ExpansionNode, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ExpansionRegionCommon
end

module ExpansionRegionImpl
end


module ExpansionRegionStruct
  __meta_attribute__ 'mode'
    
  __meta_reference__ 'outputElement'
  __meta_reference__ 'inputElement'

#TODO: QUITAR ESTO
include ExpansionRegionCommon
include ExpansionRegionImpl
end

class ExpansionRegion
  include ExpansionRegionStruct
  class << self; include MetaExpansionRegion; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaExecutableNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ExecutableNode'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(ActivityNode)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'handler', ExceptionHandler, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ExecutableNodeCommon
end

module ExecutableNodeImpl
end


module ExecutableNodeStruct
    
  __meta_reference__ 'handler'

#TODO: QUITAR ESTO
include ExecutableNodeCommon
include ExecutableNodeImpl
end

class ExecutableNode
  include ExecutableNodeStruct
  class << self; include MetaExecutableNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaExceptionHandler
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ExceptionHandler'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Element)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'protectedNode', ExecutableNode
      define_reference 'handlerBody', ExecutableNode
      define_reference 'exceptionInput', ObjectNode
      define_reference 'exceptionType', Classifier, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ExceptionHandlerCommon
end

module ExceptionHandlerImpl
end


module ExceptionHandlerStruct
    
  __meta_reference__ 'protectedNode'
  __meta_reference__ 'handlerBody'
  __meta_reference__ 'exceptionInput'
  __meta_reference__ 'exceptionType'

#TODO: QUITAR ESTO
include ExceptionHandlerCommon
include ExceptionHandlerImpl
end

class ExceptionHandler
  include ExceptionHandlerStruct
  class << self; include MetaExceptionHandler; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaComponent
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Component'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Class, Namespace)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isIndirectlyInstantiated', ECore::EBoolean
    
      define_reference 'required', Interface, :upperBound => -1
      define_reference 'provided', Interface, :upperBound => -1
      define_reference 'realization', ComponentRealization, :upperBound => -1, :containment => true
      define_reference 'packagedElement', PackageableElement, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ComponentCommon
end

module ComponentImpl
end


module ComponentStruct
  __meta_attribute__ 'isIndirectlyInstantiated'
    
  __meta_reference__ 'required'
  __meta_reference__ 'provided'
  __meta_reference__ 'realization'
  __meta_reference__ 'packagedElement'

#TODO: QUITAR ESTO
include ComponentCommon
include ComponentImpl
end

class Component
  include ComponentStruct
  class << self; include MetaComponent; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaDeployment
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Deployment'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Dependency)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'deployedArtifact', DeployedArtifact, :upperBound => -1
      define_reference 'location', DeploymentTarget
      define_reference 'configuration', DeploymentSpecification, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module DeploymentCommon
end

module DeploymentImpl
end


module DeploymentStruct
    
  __meta_reference__ 'deployedArtifact'
  __meta_reference__ 'location'
  __meta_reference__ 'configuration'

#TODO: QUITAR ESTO
include DeploymentCommon
include DeploymentImpl
end

class Deployment
  include DeploymentStruct
  class << self; include MetaDeployment; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaDeploymentSpecification
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'DeploymentSpecification'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Artifact)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'deploymentLocation', ECore::EString
      define_attribute 'executionLocation', ECore::EString
    
      define_reference 'deployment', Deployment

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module DeploymentSpecificationCommon
end

module DeploymentSpecificationImpl
end


module DeploymentSpecificationStruct
  __meta_attribute__ 'deploymentLocation'
  __meta_attribute__ 'executionLocation'
    
  __meta_reference__ 'deployment'

#TODO: QUITAR ESTO
include DeploymentSpecificationCommon
include DeploymentSpecificationImpl
end

class DeploymentSpecification
  include DeploymentSpecificationStruct
  class << self; include MetaDeploymentSpecification; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaProtocolConformance
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ProtocolConformance'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(DirectedRelationship)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'specificMachine', ProtocolStateMachine
      define_reference 'generalMachine', ProtocolStateMachine

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ProtocolConformanceCommon
end

module ProtocolConformanceImpl
end


module ProtocolConformanceStruct
    
  __meta_reference__ 'specificMachine'
  __meta_reference__ 'generalMachine'

#TODO: QUITAR ESTO
include ProtocolConformanceCommon
include ProtocolConformanceImpl
end

class ProtocolConformance
  include ProtocolConformanceStruct
  class << self; include MetaProtocolConformance; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaInterface
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Interface'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Classifier)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'ownedAttribute', Property, :upperBound => -1, :containment => true
      define_reference 'ownedOperation', Operation, :upperBound => -1, :containment => true
      define_reference 'nestedClassifier', Classifier, :upperBound => -1, :containment => true
      define_reference 'redefinedInterface', Interface, :upperBound => -1
      define_reference 'ownedReception', Reception, :upperBound => -1, :containment => true
      define_reference 'protocol', ProtocolStateMachine, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module InterfaceCommon
end

module InterfaceImpl
end


module InterfaceStruct
    
  __meta_reference__ 'ownedAttribute'
  __meta_reference__ 'ownedOperation'
  __meta_reference__ 'nestedClassifier'
  __meta_reference__ 'redefinedInterface'
  __meta_reference__ 'ownedReception'
  __meta_reference__ 'protocol'

#TODO: QUITAR ESTO
include InterfaceCommon
include InterfaceImpl
end

class Interface
  include InterfaceStruct
  class << self; include MetaInterface; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaPort
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Port'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Property)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isBehavior', ECore::EBoolean
      define_attribute 'isService', ECore::EBoolean
    
      define_reference 'required', Interface, :upperBound => -1
      define_reference 'redefinedPort', Port, :upperBound => -1
      define_reference 'provided', Interface, :upperBound => -1
      define_reference 'protocol', ProtocolStateMachine

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module PortCommon
end

module PortImpl
end


module PortStruct
  __meta_attribute__ 'isBehavior'
  __meta_attribute__ 'isService'
    
  __meta_reference__ 'required'
  __meta_reference__ 'redefinedPort'
  __meta_reference__ 'provided'
  __meta_reference__ 'protocol'

#TODO: QUITAR ESTO
include PortCommon
include PortImpl
end

class Port
  include PortStruct
  class << self; include MetaPort; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaProtocolTransition
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ProtocolTransition'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Transition)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'postCondition', Constraint, :containment => true
      define_reference 'referred', Operation, :upperBound => -1
      define_reference 'preCondition', Constraint, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ProtocolTransitionCommon
end

module ProtocolTransitionImpl
end


module ProtocolTransitionStruct
    
  __meta_reference__ 'postCondition'
  __meta_reference__ 'referred'
  __meta_reference__ 'preCondition'

#TODO: QUITAR ESTO
include ProtocolTransitionCommon
include ProtocolTransitionImpl
end

class ProtocolTransition
  include ProtocolTransitionStruct
  class << self; include MetaProtocolTransition; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaProtocolStateMachine
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ProtocolStateMachine'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(StateMachine)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'conformance', ProtocolConformance, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ProtocolStateMachineCommon
end

module ProtocolStateMachineImpl
end


module ProtocolStateMachineStruct
    
  __meta_reference__ 'conformance'

#TODO: QUITAR ESTO
include ProtocolStateMachineCommon
include ProtocolStateMachineImpl
end

class ProtocolStateMachine
  include ProtocolStateMachineStruct
  class << self; include MetaProtocolStateMachine; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaState
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'State'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Vertex, RedefinableElement, Namespace)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isComposite', ECore::EBoolean
      define_attribute 'isOrthogonal', ECore::EBoolean
      define_attribute 'isSimple', ECore::EBoolean
      define_attribute 'isSubmachineState', ECore::EBoolean
    
      define_reference 'submachine', StateMachine
      define_reference 'connection', ConnectionPointReference, :upperBound => -1, :containment => true
      define_reference 'redefinedState', State
      define_reference 'region', Region, :upperBound => -1, :containment => true
      define_reference 'redefinitionContext', Classifier
      define_reference 'stateInvariant', Constraint, :containment => true
      define_reference 'entry', Behavior, :containment => true
      define_reference 'exit', Behavior, :containment => true
      define_reference 'doActivity', Behavior, :containment => true
      define_reference 'connectionPoint', Pseudostate, :upperBound => -1, :containment => true
      define_reference 'deferrableTrigger', Trigger, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module StateCommon
end

module StateImpl
end


module StateStruct
  __meta_attribute__ 'isComposite'
  __meta_attribute__ 'isOrthogonal'
  __meta_attribute__ 'isSimple'
  __meta_attribute__ 'isSubmachineState'
    
  __meta_reference__ 'submachine'
  __meta_reference__ 'connection'
  __meta_reference__ 'redefinedState'
  __meta_reference__ 'region'
  __meta_reference__ 'redefinitionContext'
  __meta_reference__ 'stateInvariant'
  __meta_reference__ 'entry'
  __meta_reference__ 'exit'
  __meta_reference__ 'doActivity'
  __meta_reference__ 'connectionPoint'
  __meta_reference__ 'deferrableTrigger'

#TODO: QUITAR ESTO
include StateCommon
include StateImpl
end

class State
  include StateStruct
  class << self; include MetaState; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaRegion
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Region'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(RedefinableElement, Namespace)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'subvertex', Vertex, :upperBound => -1, :containment => true
      define_reference 'transition', Transition, :upperBound => -1, :containment => true
      define_reference 'stateMachine', StateMachine
      define_reference 'state', State
      define_reference 'extendedRegion', Region
      define_reference 'redefinitionContext', Classifier

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module RegionCommon
end

module RegionImpl
end


module RegionStruct
    
  __meta_reference__ 'subvertex'
  __meta_reference__ 'transition'
  __meta_reference__ 'stateMachine'
  __meta_reference__ 'state'
  __meta_reference__ 'extendedRegion'
  __meta_reference__ 'redefinitionContext'

#TODO: QUITAR ESTO
include RegionCommon
include RegionImpl
end

class Region
  include RegionStruct
  class << self; include MetaRegion; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaAssociationClass
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'AssociationClass'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Association, Class)
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

module AssociationClassCommon
end

module AssociationClassImpl
end


module AssociationClassStruct
    

#TODO: QUITAR ESTO
include AssociationClassCommon
include AssociationClassImpl
end

class AssociationClass
  include AssociationClassStruct
  class << self; include MetaAssociationClass; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaTemplateSignature
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'TemplateSignature'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Element)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'parameter', TemplateParameter, :upperBound => -1
      define_reference 'ownedParameter', TemplateParameter, :upperBound => -1, :containment => true
      define_reference 'template', TemplateableElement

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module TemplateSignatureCommon
end

module TemplateSignatureImpl
end


module TemplateSignatureStruct
    
  __meta_reference__ 'parameter'
  __meta_reference__ 'ownedParameter'
  __meta_reference__ 'template'

#TODO: QUITAR ESTO
include TemplateSignatureCommon
include TemplateSignatureImpl
end

class TemplateSignature
  include TemplateSignatureStruct
  class << self; include MetaTemplateSignature; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaNamedElement
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'NamedElement'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(Element)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'name', ECore::EString
      define_attribute 'visibility', VisibilityKind
      define_attribute 'qualifiedName', ECore::EString
    
      define_reference 'clientDependency', Dependency, :upperBound => -1
      define_reference 'namespace', Namespace
      define_reference 'nameExpression', StringExpression, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module NamedElementCommon
end

module NamedElementImpl
end


module NamedElementStruct
  __meta_attribute__ 'name'
  __meta_attribute__ 'visibility'
  __meta_attribute__ 'qualifiedName'
    
  __meta_reference__ 'clientDependency'
  __meta_reference__ 'namespace'
  __meta_reference__ 'nameExpression'

#TODO: QUITAR ESTO
include NamedElementCommon
include NamedElementImpl
end

class NamedElement
  include NamedElementStruct
  class << self; include MetaNamedElement; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaTemplateParameter
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'TemplateParameter'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Element)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'signature', TemplateSignature
      define_reference 'parameteredElement', ParameterableElement
      define_reference 'ownedParameteredElement', ParameterableElement, :containment => true
      define_reference 'default', ParameterableElement
      define_reference 'ownedDefault', ParameterableElement, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module TemplateParameterCommon
end

module TemplateParameterImpl
end


module TemplateParameterStruct
    
  __meta_reference__ 'signature'
  __meta_reference__ 'parameteredElement'
  __meta_reference__ 'ownedParameteredElement'
  __meta_reference__ 'default'
  __meta_reference__ 'ownedDefault'

#TODO: QUITAR ESTO
include TemplateParameterCommon
include TemplateParameterImpl
end

class TemplateParameter
  include TemplateParameterStruct
  class << self; include MetaTemplateParameter; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaStringExpression
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'StringExpression'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(TemplateableElement, Expression)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'subExpression', StringExpression, :upperBound => -1, :containment => true
      define_reference 'owningExpression', StringExpression

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module StringExpressionCommon
end

module StringExpressionImpl
end


module StringExpressionStruct
    
  __meta_reference__ 'subExpression'
  __meta_reference__ 'owningExpression'

#TODO: QUITAR ESTO
include StringExpressionCommon
include StringExpressionImpl
end

class StringExpression
  include StringExpressionStruct
  class << self; include MetaStringExpression; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaTemplateBinding
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'TemplateBinding'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(DirectedRelationship)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'boundElement', TemplateableElement
      define_reference 'signature', TemplateSignature
      define_reference 'parameterSubstitution', TemplateParameterSubstitution, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module TemplateBindingCommon
end

module TemplateBindingImpl
end


module TemplateBindingStruct
    
  __meta_reference__ 'boundElement'
  __meta_reference__ 'signature'
  __meta_reference__ 'parameterSubstitution'

#TODO: QUITAR ESTO
include TemplateBindingCommon
include TemplateBindingImpl
end

class TemplateBinding
  include TemplateBindingStruct
  class << self; include MetaTemplateBinding; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaTemplateParameterSubstitution
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'TemplateParameterSubstitution'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Element)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'formal', TemplateParameter
      define_reference 'templateBinding', TemplateBinding
      define_reference 'actual', ParameterableElement, :upperBound => -1
      define_reference 'ownedActual', ParameterableElement, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module TemplateParameterSubstitutionCommon
end

module TemplateParameterSubstitutionImpl
end


module TemplateParameterSubstitutionStruct
    
  __meta_reference__ 'formal'
  __meta_reference__ 'templateBinding'
  __meta_reference__ 'actual'
  __meta_reference__ 'ownedActual'

#TODO: QUITAR ESTO
include TemplateParameterSubstitutionCommon
include TemplateParameterSubstitutionImpl
end

class TemplateParameterSubstitution
  include TemplateParameterSubstitutionStruct
  class << self; include MetaTemplateParameterSubstitution; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaTemplateableElement
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'TemplateableElement'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(Element)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'templateBinding', TemplateBinding, :upperBound => -1, :containment => true
      define_reference 'ownedTemplateSignature', TemplateSignature, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module TemplateableElementCommon
end

module TemplateableElementImpl
end


module TemplateableElementStruct
    
  __meta_reference__ 'templateBinding'
  __meta_reference__ 'ownedTemplateSignature'

#TODO: QUITAR ESTO
include TemplateableElementCommon
include TemplateableElementImpl
end

class TemplateableElement
  include TemplateableElementStruct
  class << self; include MetaTemplateableElement; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaParameterableElement
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ParameterableElement'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(Element)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'templateParameter', TemplateParameter
      define_reference 'owningTemplateParameter', TemplateParameter

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ParameterableElementCommon
end

module ParameterableElementImpl
end


module ParameterableElementStruct
    
  __meta_reference__ 'templateParameter'
  __meta_reference__ 'owningTemplateParameter'

#TODO: QUITAR ESTO
include ParameterableElementCommon
include ParameterableElementImpl
end

class ParameterableElement
  include ParameterableElementStruct
  class << self; include MetaParameterableElement; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaProperty
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Property'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(ConnectableElement, DeploymentTarget, StructuralFeature, TemplateableElement)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isDerived', ECore::EBoolean
      define_attribute 'isReadOnly', ECore::EBoolean
      define_attribute 'isDerivedUnion', ECore::EBoolean
      define_attribute 'default', ECore::EString
      define_attribute 'aggregation', AggregationKind
      define_attribute 'isComposite', ECore::EBoolean
    
      define_reference 'klass_', Class
      define_reference 'redefinedProperty', Property, :upperBound => -1
      define_reference 'owningAssociation', Association
      define_reference 'datatype', DataType
      define_reference 'defaultValue', ValueSpecification, :containment => true
      define_reference 'opposite', Property
      define_reference 'subsettedProperty', Property, :upperBound => -1
      define_reference 'association', Association
      define_reference 'qualifier', Property, :upperBound => -1, :containment => true
      define_reference 'associationEnd', Property

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module PropertyCommon
end

module PropertyImpl
end


module PropertyStruct
  __meta_attribute__ 'isDerived'
  __meta_attribute__ 'isReadOnly'
  __meta_attribute__ 'isDerivedUnion'
  __meta_attribute__ 'default'
  __meta_attribute__ 'aggregation'
  __meta_attribute__ 'isComposite'
    
  __meta_reference__ 'klass_'
  __meta_reference__ 'redefinedProperty'
  __meta_reference__ 'owningAssociation'
  __meta_reference__ 'datatype'
  __meta_reference__ 'defaultValue'
  __meta_reference__ 'opposite'
  __meta_reference__ 'subsettedProperty'
  __meta_reference__ 'association'
  __meta_reference__ 'qualifier'
  __meta_reference__ 'associationEnd'

#TODO: QUITAR ESTO
include PropertyCommon
include PropertyImpl
end

class Property
  include PropertyStruct
  class << self; include MetaProperty; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaValueSpecification
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ValueSpecification'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(TypedElement, PackageableElement)
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

module ValueSpecificationCommon
end

module ValueSpecificationImpl
end


module ValueSpecificationStruct
    

#TODO: QUITAR ESTO
include ValueSpecificationCommon
include ValueSpecificationImpl
end

class ValueSpecification
  include ValueSpecificationStruct
  class << self; include MetaValueSpecification; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaOperation
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Operation'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(BehavioralFeature, ParameterableElement, TemplateableElement)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isQuery', ECore::EBoolean
      define_attribute 'isOrdered', ECore::EBoolean
      define_attribute 'isUnique', ECore::EBoolean
      define_attribute 'lower', ECore::EInt
      define_attribute 'upper', ECore::EInt
    
      define_reference 'klass_', Class
      define_reference 'precondition', Constraint, :upperBound => -1, :containment => true
      define_reference 'postcondition', Constraint, :upperBound => -1, :containment => true
      define_reference 'redefinedOperation', Operation, :upperBound => -1
      define_reference 'datatype', DataType
      define_reference 'bodyCondition', Constraint, :containment => true
      define_reference 'type', Type
      define_reference 'ownedParameter', Parameter, :upperBound => -1, :containment => true
      define_reference 'raisedException', Type, :upperBound => -1
      define_reference 'interface', Interface
      define_reference 'templateParameter', OperationTemplateParameter

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module OperationCommon
end

module OperationImpl
end


module OperationStruct
  __meta_attribute__ 'isQuery'
  __meta_attribute__ 'isOrdered'
  __meta_attribute__ 'isUnique'
  __meta_attribute__ 'lower'
  __meta_attribute__ 'upper'
    
  __meta_reference__ 'klass_'
  __meta_reference__ 'precondition'
  __meta_reference__ 'postcondition'
  __meta_reference__ 'redefinedOperation'
  __meta_reference__ 'datatype'
  __meta_reference__ 'bodyCondition'
  __meta_reference__ 'type'
  __meta_reference__ 'ownedParameter'
  __meta_reference__ 'raisedException'
  __meta_reference__ 'interface'
  __meta_reference__ 'templateParameter'

#TODO: QUITAR ESTO
include OperationCommon
include OperationImpl
end

class Operation
  include OperationStruct
  class << self; include MetaOperation; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaOperationTemplateParameter
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'OperationTemplateParameter'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(TemplateParameter)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'parameteredElement', Operation

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module OperationTemplateParameterCommon
end

module OperationTemplateParameterImpl
end


module OperationTemplateParameterStruct
    
  __meta_reference__ 'parameteredElement'

#TODO: QUITAR ESTO
include OperationTemplateParameterCommon
include OperationTemplateParameterImpl
end

class OperationTemplateParameter
  include OperationTemplateParameterStruct
  class << self; include MetaOperationTemplateParameter; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaPackageableElement
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'PackageableElement'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(NamedElement, ParameterableElement)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'visibility', VisibilityKind
    

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module PackageableElementCommon
end

module PackageableElementImpl
end


module PackageableElementStruct
  __meta_attribute__ 'visibility'
    

#TODO: QUITAR ESTO
include PackageableElementCommon
include PackageableElementImpl
end

class PackageableElement
  include PackageableElementStruct
  class << self; include MetaPackageableElement; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaClassifier
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Classifier'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(RedefinableElement, Type, TemplateableElement, Namespace)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'isAbstract', ECore::EBoolean
    
      define_reference 'generalization', Generalization, :upperBound => -1, :containment => true
      define_reference 'feature', Feature, :upperBound => -1
      define_reference 'inheritedMember', NamedElement, :upperBound => -1
      define_reference 'redefinedClassifier', Classifier, :upperBound => -1
      define_reference 'general', Classifier, :upperBound => -1
      define_reference 'substitution', Substitution, :upperBound => -1, :containment => true
      define_reference 'attribute', Property, :upperBound => -1
      define_reference 'representation', CollaborationUse
      define_reference 'collaborationUse', CollaborationUse, :upperBound => -1, :containment => true
      define_reference 'ownedUseCase', UseCase, :upperBound => -1, :containment => true
      define_reference 'useCase', UseCase, :upperBound => -1
      define_reference 'powertypeExtent', GeneralizationSet, :upperBound => -1
      define_reference 'ownedTemplateSignature', RedefinableTemplateSignature, :containment => true
      define_reference 'templateParameter', ClassifierTemplateParameter

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ClassifierCommon
end

module ClassifierImpl
end


module ClassifierStruct
  __meta_attribute__ 'isAbstract'
    
  __meta_reference__ 'generalization'
  __meta_reference__ 'feature'
  __meta_reference__ 'inheritedMember'
  __meta_reference__ 'redefinedClassifier'
  __meta_reference__ 'general'
  __meta_reference__ 'substitution'
  __meta_reference__ 'attribute'
  __meta_reference__ 'representation'
  __meta_reference__ 'collaborationUse'
  __meta_reference__ 'ownedUseCase'
  __meta_reference__ 'useCase'
  __meta_reference__ 'powertypeExtent'
  __meta_reference__ 'ownedTemplateSignature'
  __meta_reference__ 'templateParameter'

#TODO: QUITAR ESTO
include ClassifierCommon
include ClassifierImpl
end

class Classifier
  include ClassifierStruct
  class << self; include MetaClassifier; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaClassifierTemplateParameter
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ClassifierTemplateParameter'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(TemplateParameter)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'allowSubstitutable', ECore::EBoolean
    
      define_reference 'parameteredElement', Classifier
      define_reference 'defaultClassifier', Classifier
      define_reference 'constrainingClassifier', Classifier

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ClassifierTemplateParameterCommon
end

module ClassifierTemplateParameterImpl
end


module ClassifierTemplateParameterStruct
  __meta_attribute__ 'allowSubstitutable'
    
  __meta_reference__ 'parameteredElement'
  __meta_reference__ 'defaultClassifier'
  __meta_reference__ 'constrainingClassifier'

#TODO: QUITAR ESTO
include ClassifierTemplateParameterCommon
include ClassifierTemplateParameterImpl
end

class ClassifierTemplateParameter
  include ClassifierTemplateParameterStruct
  class << self; include MetaClassifierTemplateParameter; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaRedefinableTemplateSignature
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'RedefinableTemplateSignature'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(RedefinableElement, TemplateSignature)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'classifier', Classifier
      define_reference 'extendedSignature', RedefinableTemplateSignature, :upperBound => -1
      define_reference 'inheritedParameter', TemplateParameter, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module RedefinableTemplateSignatureCommon
end

module RedefinableTemplateSignatureImpl
end


module RedefinableTemplateSignatureStruct
    
  __meta_reference__ 'classifier'
  __meta_reference__ 'extendedSignature'
  __meta_reference__ 'inheritedParameter'

#TODO: QUITAR ESTO
include RedefinableTemplateSignatureCommon
include RedefinableTemplateSignatureImpl
end

class RedefinableTemplateSignature
  include RedefinableTemplateSignatureStruct
  class << self; include MetaRedefinableTemplateSignature; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaConnectableElementTemplateParameter
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ConnectableElementTemplateParameter'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(TemplateParameter)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'parameteredElement', ConnectableElement

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ConnectableElementTemplateParameterCommon
end

module ConnectableElementTemplateParameterImpl
end


module ConnectableElementTemplateParameterStruct
    
  __meta_reference__ 'parameteredElement'

#TODO: QUITAR ESTO
include ConnectableElementTemplateParameterCommon
include ConnectableElementTemplateParameterImpl
end

class ConnectableElementTemplateParameter
  include ConnectableElementTemplateParameterStruct
  class << self; include MetaConnectableElementTemplateParameter; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaPackage
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Package'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(PackageableElement, Namespace, TemplateableElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'packageMerge', PackageMerge, :upperBound => -1, :containment => true
      define_reference 'packagedElement', PackageableElement, :upperBound => -1, :containment => true
      define_reference 'ownedType', Type, :upperBound => -1, :containment => true
      define_reference 'nestedPackage', Package, :upperBound => -1, :containment => true
      define_reference 'nestingPackage', Package
      define_reference 'profileApplication', ProfileApplication, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module PackageCommon
end

module PackageImpl
end


module PackageStruct
    
  __meta_reference__ 'packageMerge'
  __meta_reference__ 'packagedElement'
  __meta_reference__ 'ownedType'
  __meta_reference__ 'nestedPackage'
  __meta_reference__ 'nestingPackage'
  __meta_reference__ 'profileApplication'

#TODO: QUITAR ESTO
include PackageCommon
include PackageImpl
end

class Package
  include PackageStruct
  class << self; include MetaPackage; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaConnectableElement
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ConnectableElement'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(TypedElement, ParameterableElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'templateParameter', ConnectableElementTemplateParameter
      define_reference 'end', ConnectorEnd, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ConnectableElementCommon
end

module ConnectableElementImpl
end


module ConnectableElementStruct
    
  __meta_reference__ 'templateParameter'
  __meta_reference__ 'end'

#TODO: QUITAR ESTO
include ConnectableElementCommon
include ConnectableElementImpl
end

class ConnectableElement
  include ConnectableElementStruct
  class << self; include MetaConnectableElement; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaConnectorEnd
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'ConnectorEnd'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(MultiplicityElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'definingEnd', Property
      define_reference 'partWithPort', Property
      define_reference 'role', ConnectableElement

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module ConnectorEndCommon
end

module ConnectorEndImpl
end


module ConnectorEndStruct
    
  __meta_reference__ 'definingEnd'
  __meta_reference__ 'partWithPort'
  __meta_reference__ 'role'

#TODO: QUITAR ESTO
include ConnectorEndCommon
include ConnectorEndImpl
end

class ConnectorEnd
  include ConnectorEndStruct
  class << self; include MetaConnectorEnd; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaVertex
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Vertex'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types(NamedElement)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'container', Region
      define_reference 'incoming', Transition, :upperBound => -1
      define_reference 'outgoing', Transition, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module VertexCommon
end

module VertexImpl
end


module VertexStruct
    
  __meta_reference__ 'container'
  __meta_reference__ 'incoming'
  __meta_reference__ 'outgoing'

#TODO: QUITAR ESTO
include VertexCommon
include VertexImpl
end

class Vertex
  include VertexStruct
  class << self; include MetaVertex; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaTransition
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Transition'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(RedefinableElement, Namespace)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'kind', TransitionKind
    
      define_reference 'container', Region
      define_reference 'redefinedTransition', Transition
      define_reference 'guard', Constraint, :containment => true
      define_reference 'redefinitionContext', Classifier
      define_reference 'effect', Behavior, :containment => true
      define_reference 'trigger', Trigger, :upperBound => -1, :containment => true
      define_reference 'target', Vertex
      define_reference 'source', Vertex

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module TransitionCommon
end

module TransitionImpl
end


module TransitionStruct
  __meta_attribute__ 'kind'
    
  __meta_reference__ 'container'
  __meta_reference__ 'redefinedTransition'
  __meta_reference__ 'guard'
  __meta_reference__ 'redefinitionContext'
  __meta_reference__ 'effect'
  __meta_reference__ 'trigger'
  __meta_reference__ 'target'
  __meta_reference__ 'source'

#TODO: QUITAR ESTO
include TransitionCommon
include TransitionImpl
end

class Transition
  include TransitionStruct
  class << self; include MetaTransition; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  


module AggregationKind
  extend ClassAutoImplementation

  def self.eLiterals
  	unless @eLiterals
      @eLiterals = []
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 0
      literal.name    = 'none'
      literal.literal = 'none'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 1
      literal.name    = 'shared'
      literal.literal = 'shared'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 2
      literal.name    = 'composite'
      literal.literal = 'composite'
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
  	'AggregationKind'
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
  
module ParameterDirectionKind
  extend ClassAutoImplementation

  def self.eLiterals
  	unless @eLiterals
      @eLiterals = []
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 0
      literal.name    = 'in'
      literal.literal = 'in'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 1
      literal.name    = 'inout'
      literal.literal = 'inout'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 2
      literal.name    = 'out'
      literal.literal = 'out'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 3
      literal.name    = 'return'
      literal.literal = 'return'
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
  	'ParameterDirectionKind'
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
  
module VisibilityKind
  extend ClassAutoImplementation

  def self.eLiterals
  	unless @eLiterals
      @eLiterals = []
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 0
      literal.name    = 'public'
      literal.literal = 'public'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 1
      literal.name    = 'private'
      literal.literal = 'private'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 2
      literal.name    = 'protected'
      literal.literal = 'protected'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 3
      literal.name    = 'package'
      literal.literal = 'package'
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
  	'VisibilityKind'
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
  
module MessageKind
  extend ClassAutoImplementation

  def self.eLiterals
  	unless @eLiterals
      @eLiterals = []
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 0
      literal.name    = 'complete'
      literal.literal = 'complete'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 1
      literal.name    = 'lost'
      literal.literal = 'lost'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 2
      literal.name    = 'found'
      literal.literal = 'found'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 3
      literal.name    = 'unknown'
      literal.literal = 'unknown'
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
  	'MessageKind'
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
  
module MessageSort
  extend ClassAutoImplementation

  def self.eLiterals
  	unless @eLiterals
      @eLiterals = []
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 0
      literal.name    = 'synchCall'
      literal.literal = 'synchCall'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 1
      literal.name    = 'asynchCall'
      literal.literal = 'asynchCall'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 2
      literal.name    = 'asynchSignal'
      literal.literal = 'asynchSignal'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 3
      literal.name    = 'createMessage'
      literal.literal = 'createMessage'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 4
      literal.name    = 'deleteMessage'
      literal.literal = 'deleteMessage'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 5
      literal.name    = 'reply'
      literal.literal = 'reply'
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
  	'MessageSort'
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
  
module CallConcurrencyKind
  extend ClassAutoImplementation

  def self.eLiterals
  	unless @eLiterals
      @eLiterals = []
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 0
      literal.name    = 'sequential'
      literal.literal = 'sequential'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 1
      literal.name    = 'guarded'
      literal.literal = 'guarded'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 2
      literal.name    = 'concurrent'
      literal.literal = 'concurrent'
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
  	'CallConcurrencyKind'
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
  
module ConnectorKind
  extend ClassAutoImplementation

  def self.eLiterals
  	unless @eLiterals
      @eLiterals = []
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 0
      literal.name    = 'assembly'
      literal.literal = 'assembly'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 1
      literal.name    = 'delegation'
      literal.literal = 'delegation'
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
  	'ConnectorKind'
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
  
module InteractionOperatorKind
  extend ClassAutoImplementation

  def self.eLiterals
  	unless @eLiterals
      @eLiterals = []
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 0
      literal.name    = 'seq'
      literal.literal = 'seq'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 1
      literal.name    = 'alt'
      literal.literal = 'alt'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 2
      literal.name    = 'opt'
      literal.literal = 'opt'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 3
      literal.name    = 'break'
      literal.literal = 'break'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 4
      literal.name    = 'par'
      literal.literal = 'par'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 5
      literal.name    = 'strict'
      literal.literal = 'strict'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 6
      literal.name    = 'loop'
      literal.literal = 'loop'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 7
      literal.name    = 'critical'
      literal.literal = 'critical'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 8
      literal.name    = 'neg'
      literal.literal = 'neg'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 9
      literal.name    = 'assert'
      literal.literal = 'assert'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 10
      literal.name    = 'ignore'
      literal.literal = 'ignore'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 11
      literal.name    = 'consider'
      literal.literal = 'consider'
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
  	'InteractionOperatorKind'
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
  
module PseudostateKind
  extend ClassAutoImplementation

  def self.eLiterals
  	unless @eLiterals
      @eLiterals = []
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 0
      literal.name    = 'initial'
      literal.literal = 'initial'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 1
      literal.name    = 'deepHistory'
      literal.literal = 'deepHistory'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 2
      literal.name    = 'shallowHistory'
      literal.literal = 'shallowHistory'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 3
      literal.name    = 'join'
      literal.literal = 'join'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 4
      literal.name    = 'fork'
      literal.literal = 'fork'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 5
      literal.name    = 'junction'
      literal.literal = 'junction'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 6
      literal.name    = 'choice'
      literal.literal = 'choice'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 7
      literal.name    = 'entryPoint'
      literal.literal = 'entryPoint'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 8
      literal.name    = 'exitPoint'
      literal.literal = 'exitPoint'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 9
      literal.name    = 'terminate'
      literal.literal = 'terminate'
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
  	'PseudostateKind'
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
  
module TransitionKind
  extend ClassAutoImplementation

  def self.eLiterals
  	unless @eLiterals
      @eLiterals = []
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 0
      literal.name    = 'internal'
      literal.literal = 'internal'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 1
      literal.name    = 'local'
      literal.literal = 'local'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 2
      literal.name    = 'external'
      literal.literal = 'external'
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
  	'TransitionKind'
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
  
module ObjectNodeOrderingKind
  extend ClassAutoImplementation

  def self.eLiterals
  	unless @eLiterals
      @eLiterals = []
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 0
      literal.name    = 'unordered'
      literal.literal = 'unordered'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 1
      literal.name    = 'ordered'
      literal.literal = 'ordered'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 2
      literal.name    = 'LIFO'
      literal.literal = 'LIFO'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 3
      literal.name    = 'FIFO'
      literal.literal = 'FIFO'
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
  	'ObjectNodeOrderingKind'
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
  
module ParameterEffectKind
  extend ClassAutoImplementation

  def self.eLiterals
  	unless @eLiterals
      @eLiterals = []
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 0
      literal.name    = 'create'
      literal.literal = 'create'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 1
      literal.name    = 'read'
      literal.literal = 'read'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 2
      literal.name    = 'update'
      literal.literal = 'update'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 3
      literal.name    = 'delete'
      literal.literal = 'delete'
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
  	'ParameterEffectKind'
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
  
module ExpansionKind
  extend ClassAutoImplementation

  def self.eLiterals
  	unless @eLiterals
      @eLiterals = []
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 0
      literal.name    = 'parallel'
      literal.literal = 'parallel'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 1
      literal.name    = 'iterative'
      literal.literal = 'iterative'
      @eLiterals << literal  
      literal = ECore::EEnumLiteral.new
      # TODO: Fix this error... self is not an EEnum, a type check error occurs
      # literal.eEnum   = self
      literal.value   = 2
      literal.name    = 'stream'
      literal.literal = 'stream'
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
  	'ExpansionKind'
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
  


class Comment
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaComment;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include CommentStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class DirectedRelationship
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaDirectedRelationship;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include RelationshipStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include DirectedRelationshipStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class LiteralSpecification
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaLiteralSpecification;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ValueSpecificationStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include TypedElementStruct
  include LiteralSpecificationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class LiteralInteger
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaLiteralInteger;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include LiteralSpecificationStruct
  include TypedElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ValueSpecificationStruct
  include LiteralIntegerStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class LiteralString
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaLiteralString;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include LiteralSpecificationStruct
  include TypedElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ValueSpecificationStruct
  include LiteralStringStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class LiteralBoolean
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaLiteralBoolean;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include LiteralSpecificationStruct
  include TypedElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ValueSpecificationStruct
  include LiteralBooleanStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class LiteralNull
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaLiteralNull;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include LiteralSpecificationStruct
  include TypedElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ValueSpecificationStruct
  include LiteralNullStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Constraint
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaConstraint;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ConstraintStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ElementImport
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaElementImport;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include DirectedRelationshipStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include RelationshipStruct
  include ElementImportStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class TypedElement
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaTypedElement;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include TypedElementStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Feature
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaFeature;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include FeatureStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class RedefinableElement
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaRedefinableElement;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class StructuralFeature
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaStructuralFeature;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include FeatureStruct
  include TypedElementStruct
  include MultiplicityElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include StructuralFeatureStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Slot
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaSlot;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include SlotStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class PackageImport
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaPackageImport;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include DirectedRelationshipStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include RelationshipStruct
  include PackageImportStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class DataType
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaDataType;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include DataTypeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Enumeration
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaEnumeration;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include DataTypeStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include EnumerationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class EnumerationLiteral
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaEnumerationLiteral;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include InstanceSpecificationStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include DeployedArtifactStruct
  include DeploymentTargetStruct
  include PackageableElementStruct
  include EnumerationLiteralStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class PrimitiveType
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaPrimitiveType;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include DataTypeStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include PrimitiveTypeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Association
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaAssociation;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include RelationshipStruct
  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include AssociationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Relationship
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaRelationship;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include RelationshipStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class PackageMerge
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaPackageMerge;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include DirectedRelationshipStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include RelationshipStruct
  include PackageMergeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class InstanceValue
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaInstanceValue;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ValueSpecificationStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include TypedElementStruct
  include InstanceValueStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class LiteralUnlimitedNatural
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaLiteralUnlimitedNatural;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include LiteralSpecificationStruct
  include TypedElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ValueSpecificationStruct
  include LiteralUnlimitedNaturalStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Type
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaType;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include TypeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Expression
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaExpression;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ValueSpecificationStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include TypedElementStruct
  include ExpressionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class OpaqueExpression
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaOpaqueExpression;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ValueSpecificationStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include TypedElementStruct
  include OpaqueExpressionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class OpaqueBehavior
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaOpaqueBehavior;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include BehaviorStruct
  include BehavioredClassifierStruct
  include EncapsulatedClassifierStruct
  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include StructuredClassifierStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include ClassStruct
  include OpaqueBehaviorStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class FunctionBehavior
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaFunctionBehavior;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include OpaqueBehaviorStruct
  include ClassStruct
  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include StructuredClassifierStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include EncapsulatedClassifierStruct
  include BehavioredClassifierStruct
  include BehaviorStruct
  include FunctionBehaviorStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class OpaqueAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaOpaqueAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include OpaqueActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class CallAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaCallAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include InvocationActionStruct
  include ExecutableNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include ActionStruct
  include CallActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class SendSignalAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaSendSignalAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include InvocationActionStruct
  include ExecutableNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include ActionStruct
  include SendSignalActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class CallOperationAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaCallOperationAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include CallActionStruct
  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include InvocationActionStruct
  include CallOperationActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class CallBehaviorAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaCallBehaviorAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include CallActionStruct
  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include InvocationActionStruct
  include CallBehaviorActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class MultiplicityElement
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaMultiplicityElement;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include MultiplicityElementStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class SequenceNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaSequenceNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include StructuredActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ExecutableNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ActivityGroupStruct
  include ActionStruct
  include NamespaceStruct
  include SequenceNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class InputPin
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaInputPin;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include PinStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ActivityNodeStruct
  include TypedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ObjectNodeStruct
  include MultiplicityElementStruct
  include InputPinStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class OutputPin
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaOutputPin;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include PinStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ActivityNodeStruct
  include TypedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ObjectNodeStruct
  include MultiplicityElementStruct
  include OutputPinStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Usage
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaUsage;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include DependencyStruct
  include RelationshipStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include DirectedRelationshipStruct
  include UsageStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Abstraction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaAbstraction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include DependencyStruct
  include RelationshipStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include DirectedRelationshipStruct
  include AbstractionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Dependency
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaDependency;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include DirectedRelationshipStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include RelationshipStruct
  include DependencyStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Realization
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaRealization;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include AbstractionStruct
  include DirectedRelationshipStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include RelationshipStruct
  include DependencyStruct
  include RealizationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Substitution
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaSubstitution;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include RealizationStruct
  include DependencyStruct
  include RelationshipStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include DirectedRelationshipStruct
  include AbstractionStruct
  include SubstitutionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Namespace
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaNamespace;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class InterfaceRealization
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaInterfaceRealization;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include RealizationStruct
  include DependencyStruct
  include RelationshipStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include DirectedRelationshipStruct
  include AbstractionStruct
  include InterfaceRealizationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class StructuredClassifier
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaStructuredClassifier;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include StructuredClassifierStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Variable
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaVariable;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include MultiplicityElementStruct
  include ConnectableElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include TypedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include VariableStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class CollaborationUse
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaCollaborationUse;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include CollaborationUseStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Collaboration
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaCollaboration;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include StructuredClassifierStruct
  include BehavioredClassifierStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include CollaborationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ControlNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaControlNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ControlNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ControlFlow
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaControlFlow;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActivityEdgeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ControlFlowStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class InitialNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaInitialNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ControlNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include InitialNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ActivityParameterNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaActivityParameterNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ObjectNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include TypedElementStruct
  include ActivityNodeStruct
  include ActivityParameterNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ValuePin
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaValuePin;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include InputPinStruct
  include MultiplicityElementStruct
  include ObjectNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include TypedElementStruct
  include ActivityNodeStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PinStruct
  include ValuePinStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Message
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaMessage;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include MessageStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class GeneralOrdering
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaGeneralOrdering;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include GeneralOrderingStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ExecutionSpecification
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaExecutionSpecification;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include InteractionFragmentStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ExecutionSpecificationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class OccurrenceSpecification
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaOccurrenceSpecification;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include InteractionFragmentStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include OccurrenceSpecificationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class MessageEnd
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaMessageEnd;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include MessageEndStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class StateInvariant
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaStateInvariant;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include InteractionFragmentStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include StateInvariantStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ActionExecutionSpecification
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaActionExecutionSpecification;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ExecutionSpecificationStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include InteractionFragmentStruct
  include ActionExecutionSpecificationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class BehaviorExecutionSpecification
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaBehaviorExecutionSpecification;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ExecutionSpecificationStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include InteractionFragmentStruct
  include BehaviorExecutionSpecificationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ExecutionEvent
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaExecutionEvent;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include EventStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ExecutionEventStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class CreationEvent
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaCreationEvent;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include EventStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include CreationEventStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class DestructionEvent
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaDestructionEvent;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include EventStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include DestructionEventStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class SendOperationEvent
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaSendOperationEvent;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include MessageEventStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include EventStruct
  include SendOperationEventStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class SendSignalEvent
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaSendSignalEvent;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include MessageEventStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include EventStruct
  include SendSignalEventStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class MessageOccurrenceSpecification
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaMessageOccurrenceSpecification;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include MessageEndStruct
  include OccurrenceSpecificationStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include InteractionFragmentStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include MessageOccurrenceSpecificationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ExecutionOccurrenceSpecification
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaExecutionOccurrenceSpecification;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include OccurrenceSpecificationStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include InteractionFragmentStruct
  include ExecutionOccurrenceSpecificationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ReceiveOperationEvent
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaReceiveOperationEvent;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include MessageEventStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include EventStruct
  include ReceiveOperationEventStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ReceiveSignalEvent
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaReceiveSignalEvent;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include MessageEventStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include EventStruct
  include ReceiveSignalEventStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Actor
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaActor;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include BehavioredClassifierStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include ActorStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Extend
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaExtend;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include DirectedRelationshipStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include RelationshipStruct
  include ExtendStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Include
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaInclude;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include DirectedRelationshipStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include RelationshipStruct
  include IncludeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class UseCase
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaUseCase;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include BehavioredClassifierStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include UseCaseStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ExtensionPoint
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaExtensionPoint;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ExtensionPointStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class CallEvent
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaCallEvent;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include MessageEventStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include EventStruct
  include CallEventStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ChangeEvent
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaChangeEvent;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include EventStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ChangeEventStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Reception
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaReception;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include BehavioralFeatureStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include FeatureStruct
  include ReceptionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Signal
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaSignal;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include SignalStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class SignalEvent
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaSignalEvent;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include MessageEventStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include EventStruct
  include SignalEventStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class MessageEvent
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaMessageEvent;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include EventStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include MessageEventStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class AnyReceiveEvent
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaAnyReceiveEvent;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include MessageEventStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include EventStruct
  include AnyReceiveEventStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class BehavioredClassifier
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaBehavioredClassifier;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include BehavioredClassifierStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Event
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaEvent;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include EventStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ForkNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaForkNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ControlNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include ForkNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class FlowFinalNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaFlowFinalNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include FinalNodeStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ControlNodeStruct
  include FlowFinalNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class CentralBufferNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaCentralBufferNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ObjectNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include TypedElementStruct
  include ActivityNodeStruct
  include CentralBufferNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ActivityPartition
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaActivityPartition;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include NamedElementStruct
  include ActivityGroupStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ActivityPartitionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class MergeNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaMergeNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ControlNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include MergeNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class DecisionNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaDecisionNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ControlNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include DecisionNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class FinalNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaFinalNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ControlNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include FinalNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ActivityFinalNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaActivityFinalNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include FinalNodeStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ControlNodeStruct
  include ActivityFinalNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class EncapsulatedClassifier
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaEncapsulatedClassifier;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include StructuredClassifierStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include EncapsulatedClassifierStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ComponentRealization
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaComponentRealization;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include RealizationStruct
  include DependencyStruct
  include RelationshipStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include DirectedRelationshipStruct
  include AbstractionStruct
  include ComponentRealizationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Connector
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaConnector;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include FeatureStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ConnectorStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Manifestation
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaManifestation;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include AbstractionStruct
  include DirectedRelationshipStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include RelationshipStruct
  include DependencyStruct
  include ManifestationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Node
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ClassStruct
  include DeploymentTargetStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include StructuredClassifierStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include EncapsulatedClassifierStruct
  include BehavioredClassifierStruct
  include NodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Device
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaDevice;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include NodeStruct
  include BehavioredClassifierStruct
  include EncapsulatedClassifierStruct
  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include StructuredClassifierStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include DeploymentTargetStruct
  include ClassStruct
  include DeviceStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ExecutionEnvironment
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaExecutionEnvironment;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include NodeStruct
  include BehavioredClassifierStruct
  include EncapsulatedClassifierStruct
  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include StructuredClassifierStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include DeploymentTargetStruct
  include ClassStruct
  include ExecutionEnvironmentStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class DeploymentTarget
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaDeploymentTarget;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include DeploymentTargetStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class DeployedArtifact
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaDeployedArtifact;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include DeployedArtifactStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class CommunicationPath
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaCommunicationPath;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include AssociationStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include RelationshipStruct
  include CommunicationPathStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class InstanceSpecification
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaInstanceSpecification;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include PackageableElementStruct
  include DeploymentTargetStruct
  include DeployedArtifactStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include InstanceSpecificationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Artifact
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaArtifact;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ClassifierStruct
  include DeployedArtifactStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include ArtifactStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class InteractionUse
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaInteractionUse;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include InteractionFragmentStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include InteractionUseStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class PartDecomposition
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaPartDecomposition;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include InteractionUseStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include InteractionFragmentStruct
  include PartDecompositionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class InteractionOperand
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaInteractionOperand;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include InteractionFragmentStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include InteractionOperandStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class InteractionConstraint
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaInteractionConstraint;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ConstraintStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include InteractionConstraintStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Gate
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaGate;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include MessageEndStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include GateStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class CombinedFragment
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaCombinedFragment;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include InteractionFragmentStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include CombinedFragmentStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Interaction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaInteraction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include InteractionFragmentStruct
  include BehaviorStruct
  include BehavioredClassifierStruct
  include EncapsulatedClassifierStruct
  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include StructuredClassifierStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include ClassStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include InteractionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Lifeline
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaLifeline;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include LifelineStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Continuation
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaContinuation;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include InteractionFragmentStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ContinuationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class InteractionFragment
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaInteractionFragment;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include InteractionFragmentStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ConsiderIgnoreFragment
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaConsiderIgnoreFragment;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include CombinedFragmentStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include InteractionFragmentStruct
  include ConsiderIgnoreFragmentStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class CreateObjectAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaCreateObjectAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include CreateObjectActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class DestroyObjectAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaDestroyObjectAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include DestroyObjectActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class TestIdentityAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaTestIdentityAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include TestIdentityActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ReadSelfAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaReadSelfAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include ReadSelfActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class StructuralFeatureAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaStructuralFeatureAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include StructuralFeatureActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ReadStructuralFeatureAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaReadStructuralFeatureAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include StructuralFeatureActionStruct
  include ExecutableNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include ActionStruct
  include ReadStructuralFeatureActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class WriteStructuralFeatureAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaWriteStructuralFeatureAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include StructuralFeatureActionStruct
  include ExecutableNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include ActionStruct
  include WriteStructuralFeatureActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ClearStructuralFeatureAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaClearStructuralFeatureAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include StructuralFeatureActionStruct
  include ExecutableNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include ActionStruct
  include ClearStructuralFeatureActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class RemoveStructuralFeatureValueAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaRemoveStructuralFeatureValueAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include WriteStructuralFeatureActionStruct
  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include StructuralFeatureActionStruct
  include RemoveStructuralFeatureValueActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class AddStructuralFeatureValueAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaAddStructuralFeatureValueAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include WriteStructuralFeatureActionStruct
  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include StructuralFeatureActionStruct
  include AddStructuralFeatureValueActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class LinkAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaLinkAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include LinkActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ReadLinkAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaReadLinkAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include LinkActionStruct
  include ExecutableNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include ActionStruct
  include ReadLinkActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class LinkEndCreationData
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaLinkEndCreationData;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include LinkEndDataStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include LinkEndCreationDataStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class CreateLinkAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaCreateLinkAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include WriteLinkActionStruct
  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include LinkActionStruct
  include CreateLinkActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class DestroyLinkAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaDestroyLinkAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include WriteLinkActionStruct
  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include LinkActionStruct
  include DestroyLinkActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class WriteLinkAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaWriteLinkAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include LinkActionStruct
  include ExecutableNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include ActionStruct
  include WriteLinkActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ClearAssociationAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaClearAssociationAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include ClearAssociationActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class BroadcastSignalAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaBroadcastSignalAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include InvocationActionStruct
  include ExecutableNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include ActionStruct
  include BroadcastSignalActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class SendObjectAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaSendObjectAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include InvocationActionStruct
  include ExecutableNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include ActionStruct
  include SendObjectActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class LinkEndDestructionData
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaLinkEndDestructionData;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include LinkEndDataStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include LinkEndDestructionDataStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ValueSpecificationAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaValueSpecificationAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include ValueSpecificationActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class TimeExpression
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaTimeExpression;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ValueSpecificationStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include TypedElementStruct
  include TimeExpressionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Duration
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaDuration;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ValueSpecificationStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include TypedElementStruct
  include DurationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class DurationInterval
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaDurationInterval;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include IntervalStruct
  include TypedElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ValueSpecificationStruct
  include DurationIntervalStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class TimeConstraint
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaTimeConstraint;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include IntervalConstraintStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ConstraintStruct
  include TimeConstraintStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class TimeInterval
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaTimeInterval;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include IntervalStruct
  include TypedElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ValueSpecificationStruct
  include TimeIntervalStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class DurationConstraint
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaDurationConstraint;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include IntervalConstraintStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ConstraintStruct
  include DurationConstraintStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class IntervalConstraint
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaIntervalConstraint;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ConstraintStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include IntervalConstraintStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Interval
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaInterval;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ValueSpecificationStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include TypedElementStruct
  include IntervalStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Observation
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaObservation;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ObservationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class TimeObservation
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaTimeObservation;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ObservationStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include TimeObservationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class DurationObservation
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaDurationObservation;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ObservationStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include DurationObservationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class InvocationAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaInvocationAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include InvocationActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Trigger
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaTrigger;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include TriggerStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class StateMachine
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaStateMachine;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include BehaviorStruct
  include BehavioredClassifierStruct
  include EncapsulatedClassifierStruct
  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include StructuredClassifierStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include ClassStruct
  include StateMachineStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Pseudostate
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaPseudostate;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include VertexStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include PseudostateStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class FinalState
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaFinalState;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include StateStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include RedefinableElementStruct
  include VertexStruct
  include FinalStateStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ConnectionPointReference
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaConnectionPointReference;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include VertexStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ConnectionPointReferenceStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class TimeEvent
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaTimeEvent;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include EventStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include TimeEventStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Stereotype
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaStereotype;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ClassStruct
  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include StructuredClassifierStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include EncapsulatedClassifierStruct
  include BehavioredClassifierStruct
  include StereotypeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Profile
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaProfile;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include PackageStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include PackageableElementStruct
  include ProfileStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Class
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaClass;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include BehavioredClassifierStruct
  include EncapsulatedClassifierStruct
  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include StructuredClassifierStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include ClassStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ProfileApplication
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaProfileApplication;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include DirectedRelationshipStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include RelationshipStruct
  include ProfileApplicationStruct
  
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

  include AssociationStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include RelationshipStruct
  include ExtensionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Image
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaImage;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ImageStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Element
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaElement;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ExtensionEnd
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaExtensionEnd;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include PropertyStruct
  include TypedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include FeatureStruct
  include TypedElementStruct
  include MultiplicityElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include TemplateableElementStruct
  include StructuralFeatureStruct
  include DeploymentTargetStruct
  include ConnectableElementStruct
  include ExtensionEndStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class VariableAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaVariableAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include VariableActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ReadVariableAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaReadVariableAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include VariableActionStruct
  include ExecutableNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include ActionStruct
  include ReadVariableActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class WriteVariableAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaWriteVariableAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include VariableActionStruct
  include ExecutableNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include ActionStruct
  include WriteVariableActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ClearVariableAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaClearVariableAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include VariableActionStruct
  include ExecutableNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include ActionStruct
  include ClearVariableActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class AddVariableValueAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaAddVariableValueAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include WriteVariableActionStruct
  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include VariableActionStruct
  include AddVariableValueActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class RemoveVariableValueAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaRemoveVariableValueAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include WriteVariableActionStruct
  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include VariableActionStruct
  include RemoveVariableValueActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class RaiseExceptionAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaRaiseExceptionAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include RaiseExceptionActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ActionInputPin
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaActionInputPin;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include InputPinStruct
  include MultiplicityElementStruct
  include ObjectNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include TypedElementStruct
  include ActivityNodeStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PinStruct
  include ActionInputPinStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class GeneralizationSet
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaGeneralizationSet;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include GeneralizationSetStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Generalization
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaGeneralization;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include DirectedRelationshipStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include RelationshipStruct
  include GeneralizationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class InformationItem
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaInformationItem;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include InformationItemStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class InformationFlow
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaInformationFlow;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include DirectedRelationshipStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include RelationshipStruct
  include InformationFlowStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Model
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaModel;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include PackageStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include PackageableElementStruct
  include ModelStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ReadExtentAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaReadExtentAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include ReadExtentActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ReclassifyObjectAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaReclassifyObjectAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include ReclassifyObjectActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ReadIsClassifiedObjectAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaReadIsClassifiedObjectAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include ReadIsClassifiedObjectActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class StartClassifierBehaviorAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaStartClassifierBehaviorAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include StartClassifierBehaviorActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class QualifierValue
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaQualifierValue;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include QualifierValueStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class LinkEndData
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaLinkEndData;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include LinkEndDataStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ReadLinkObjectEndAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaReadLinkObjectEndAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include ReadLinkObjectEndActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ReadLinkObjectEndQualifierAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaReadLinkObjectEndQualifierAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include ReadLinkObjectEndQualifierActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class CreateLinkObjectAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaCreateLinkObjectAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include CreateLinkActionStruct
  include LinkActionStruct
  include ExecutableNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include ActionStruct
  include WriteLinkActionStruct
  include CreateLinkObjectActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class AcceptEventAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaAcceptEventAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include AcceptEventActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class AcceptCallAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaAcceptCallAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include AcceptEventActionStruct
  include ExecutableNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include ActionStruct
  include AcceptCallActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ReplyAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaReplyAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include ReplyActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class UnmarshallAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaUnmarshallAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include UnmarshallActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ReduceAction
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaReduceAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActionStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include ReduceActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class JoinNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaJoinNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ControlNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include JoinNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class DataStoreNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaDataStoreNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include CentralBufferNodeStruct
  include ActivityNodeStruct
  include TypedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ObjectNodeStruct
  include DataStoreNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ObjectFlow
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaObjectFlow;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActivityEdgeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ObjectFlowStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ObjectNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaObjectNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActivityNodeStruct
  include TypedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ObjectNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ParameterSet
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaParameterSet;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ParameterSetStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Activity
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaActivity;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include BehaviorStruct
  include BehavioredClassifierStruct
  include EncapsulatedClassifierStruct
  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include StructuredClassifierStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include ClassStruct
  include ActivityStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Parameter
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaParameter;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include MultiplicityElementStruct
  include ConnectableElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include TypedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ParameterStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Action
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaAction;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ExecutableNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include ActionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class InterruptibleActivityRegion
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaInterruptibleActivityRegion;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActivityGroupStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include InterruptibleActivityRegionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ActivityNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaActivityNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class BehavioralFeature
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaBehavioralFeature;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include FeatureStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include BehavioralFeatureStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Behavior
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaBehavior;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ClassStruct
  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include StructuredClassifierStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include EncapsulatedClassifierStruct
  include BehavioredClassifierStruct
  include BehaviorStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Pin
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaPin;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include MultiplicityElementStruct
  include ObjectNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include TypedElementStruct
  include ActivityNodeStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PinStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ConditionalNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaConditionalNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include StructuredActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ExecutableNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ActivityGroupStruct
  include ActionStruct
  include NamespaceStruct
  include ConditionalNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class StructuredActivityNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaStructuredActivityNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include NamespaceStruct
  include ActionStruct
  include ActivityGroupStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include StructuredActivityNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class LoopNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaLoopNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include StructuredActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ExecutableNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ActivityGroupStruct
  include ActionStruct
  include NamespaceStruct
  include LoopNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Clause
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaClause;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ClauseStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ActivityEdge
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaActivityEdge;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityEdgeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ActivityGroup
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaActivityGroup;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ActivityGroupStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ExpansionNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaExpansionNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ObjectNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include TypedElementStruct
  include ActivityNodeStruct
  include ExpansionNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ExpansionRegion
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaExpansionRegion;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include StructuredActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ExecutableNodeStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ActivityNodeStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ActivityGroupStruct
  include ActionStruct
  include NamespaceStruct
  include ExpansionRegionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ExecutableNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaExecutableNode;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ActivityNodeStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ExecutableNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ExceptionHandler
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaExceptionHandler;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ExceptionHandlerStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Component
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaComponent;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ClassStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include StructuredClassifierStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include EncapsulatedClassifierStruct
  include BehavioredClassifierStruct
  include ComponentStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Deployment
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaDeployment;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include DependencyStruct
  include RelationshipStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include DirectedRelationshipStruct
  include DeploymentStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class DeploymentSpecification
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaDeploymentSpecification;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ArtifactStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include DeployedArtifactStruct
  include ClassifierStruct
  include DeploymentSpecificationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ProtocolConformance
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaProtocolConformance;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include DirectedRelationshipStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include RelationshipStruct
  include ProtocolConformanceStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Interface
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaInterface;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include InterfaceStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Port
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaPort;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include PropertyStruct
  include TypedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include FeatureStruct
  include TypedElementStruct
  include MultiplicityElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include TemplateableElementStruct
  include StructuralFeatureStruct
  include DeploymentTargetStruct
  include ConnectableElementStruct
  include PortStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ProtocolTransition
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaProtocolTransition;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include TransitionStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include RedefinableElementStruct
  include ProtocolTransitionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ProtocolStateMachine
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaProtocolStateMachine;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include StateMachineStruct
  include ClassStruct
  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include StructuredClassifierStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include EncapsulatedClassifierStruct
  include BehavioredClassifierStruct
  include BehaviorStruct
  include ProtocolStateMachineStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class State
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaState;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include VertexStruct
  include RedefinableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include StateStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Region
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaRegion;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include RedefinableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include RegionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class AssociationClass
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaAssociationClass;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include AssociationStruct
  include ClassStruct
  include ClassifierStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include TypeStruct
  include RedefinableElementStruct
  include StructuredClassifierStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include EncapsulatedClassifierStruct
  include BehavioredClassifierStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  include RelationshipStruct
  include AssociationClassStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class TemplateSignature
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaTemplateSignature;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include TemplateSignatureStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class NamedElement
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaNamedElement;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class TemplateParameter
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaTemplateParameter;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include TemplateParameterStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class StringExpression
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaStringExpression;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include TemplateableElementStruct
  include ExpressionStruct
  include TypedElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ValueSpecificationStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include StringExpressionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class TemplateBinding
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaTemplateBinding;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include DirectedRelationshipStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include RelationshipStruct
  include TemplateBindingStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class TemplateParameterSubstitution
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaTemplateParameterSubstitution;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include TemplateParameterSubstitutionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class TemplateableElement
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaTemplateableElement;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include TemplateableElementStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ParameterableElement
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaParameterableElement;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Property
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaProperty;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include ConnectableElementStruct
  include DeploymentTargetStruct
  include StructuralFeatureStruct
  include TemplateableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include MultiplicityElementStruct
  include TypedElementStruct
  include FeatureStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include TypedElementStruct
  include PropertyStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ValueSpecification
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaValueSpecification;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include TypedElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ValueSpecificationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Operation
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaOperation;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include BehavioralFeatureStruct
  include ParameterableElementStruct
  include TemplateableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include RedefinableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamespaceStruct
  include FeatureStruct
  include OperationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class OperationTemplateParameter
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaOperationTemplateParameter;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include TemplateParameterStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include OperationTemplateParameterStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class PackageableElement
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaPackageableElement;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Classifier
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaClassifier;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include RedefinableElementStruct
  include TypeStruct
  include TemplateableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include NamedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include PackageableElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ClassifierStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ClassifierTemplateParameter
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaClassifierTemplateParameter;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include TemplateParameterStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ClassifierTemplateParameterStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class RedefinableTemplateSignature
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaRedefinableTemplateSignature;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include RedefinableElementStruct
  include TemplateSignatureStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include RedefinableTemplateSignatureStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ConnectableElementTemplateParameter
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaConnectableElementTemplateParameter;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include TemplateParameterStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ConnectableElementTemplateParameterStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Package
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaPackage;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include PackageableElementStruct
  include NamespaceStruct
  include TemplateableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include ParameterableElementStruct
  include NamedElementStruct
  include PackageStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ConnectableElement
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaConnectableElement;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include TypedElementStruct
  include ParameterableElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ConnectableElementStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class ConnectorEnd
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaConnectorEnd;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include MultiplicityElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include ConnectorEndStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Vertex
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaVertex;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include NamedElementStruct
  include ECore::EModelElementStruct
  include ECore::EObjectStruct
  include ElementStruct
  include VertexStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Transition
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaTransition;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include RedefinableElementStruct
  include NamespaceStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include ElementStruct
  include ECore::EObjectStruct
  include ECore::EModelElementStruct
  include NamedElementStruct
  include TransitionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

end
end
