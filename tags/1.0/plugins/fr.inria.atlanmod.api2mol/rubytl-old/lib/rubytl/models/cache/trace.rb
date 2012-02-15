module RubyTL 
# TODO: This should be in some CacheRepository
# automate the loading from here... 

module Trace
  extend ::ECore::EPackageLookup
  cattr_accessor :owning_model # TODO: Strange, is it really necessary?

  def self.eClassifiers
  	[TraceElement,TraceModel,Rule,CallStack,RuleApplication]
  end

  def self.eSubpackages
    []
  end

  def self.eSuperPackage
    
  end

  def self.nsURI
	'http://gts.inf.um.es/rubytl/trace'
  end
	
  def self.nsPrefix
  	'rubytl_trace'
  end		
 
  def self.root_package
	return self unless self.eSuperPackage
	return self.eSuperPackage.root_package
  end  	
    
  module ClassAutoImplementation
  	def ePackage
  		Trace
  	end
  	
  	def nsURI
      self.ePackage.nsURI
  	end
  	
  	def nsPrefix
  	  self.ePackage.nsPrefix
  	end  
  end

  # TODO: Generate nested EPackages	

module MetaTraceElement
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'TraceElement'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types()
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'sources', ECore::EObject, :upperBound => -1
      define_reference 'targets', ECore::EObject, :upperBound => -1
      define_reference 'rule', Rule

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module TraceElementCommon
end

module TraceElementImpl
end


module TraceElementStruct
    
  __meta_reference__ 'sources'
  __meta_reference__ 'targets'
  __meta_reference__ 'rule'

#TODO: QUITAR ESTO
include TraceElementCommon
include TraceElementImpl
end

class TraceElement
  include TraceElementStruct
  class << self; include MetaTraceElement; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaTraceModel
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'TraceModel'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types()
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'rules', Rule, :upperBound => -1, :containment => true
      define_reference 'traces', TraceElement, :upperBound => -1, :containment => true
      define_reference 'callStack', CallStack, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module TraceModelCommon
end

module TraceModelImpl
end


module TraceModelStruct
    
  __meta_reference__ 'rules'
  __meta_reference__ 'traces'
  __meta_reference__ 'callStack'

#TODO: QUITAR ESTO
include TraceModelCommon
include TraceModelImpl
end

class TraceModel
  include TraceModelStruct
  class << self; include MetaTraceModel; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaRule
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Rule'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types()
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'kind', ECore::EString
    

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module RuleCommon
end

module RuleImpl
end


module RuleStruct
  __meta_attribute__ 'kind'
    

#TODO: QUITAR ESTO
include RuleCommon
include RuleImpl
end

class Rule
  include RuleStruct
  class << self; include MetaRule; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaCallStack
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'CallStack'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types()
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'ruleApplications', RuleApplication, :upperBound => -1

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module CallStackCommon
end

module CallStackImpl
end


module CallStackStruct
    
  __meta_reference__ 'ruleApplications'

#TODO: QUITAR ESTO
include CallStackCommon
include CallStackImpl
end

class CallStack
  include CallStackStruct
  class << self; include MetaCallStack; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaRuleApplication
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'RuleApplication'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types()
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'ruleApplications', RuleApplication, :upperBound => -1, :containment => true
      define_reference 'appliedBy', RuleApplication
      define_reference 'rule', Rule
      reference_opposite 'ruleApplications', 'appliedBy'
      reference_opposite 'appliedBy', 'ruleApplications'

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module RuleApplicationCommon
end

module RuleApplicationImpl
end


module RuleApplicationStruct
    
  __meta_reference__ 'ruleApplications'
  __meta_reference__ 'appliedBy'
  __meta_reference__ 'rule'

#TODO: QUITAR ESTO
include RuleApplicationCommon
include RuleApplicationImpl
end

class RuleApplication
  include RuleApplicationStruct
  class << self; include MetaRuleApplication; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  




class TraceElement
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaTraceElement;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include TraceElementStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class TraceModel
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaTraceModel;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include TraceModelStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Rule
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaRule;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include RuleStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class CallStack
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaCallStack;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include CallStackStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class RuleApplication
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaRuleApplication;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include RuleApplicationStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

end
end
