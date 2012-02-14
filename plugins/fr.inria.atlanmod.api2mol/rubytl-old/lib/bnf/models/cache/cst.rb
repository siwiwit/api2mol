module RubyTL 
# TODO: This should be in some CacheRepository
# automate the loading from here... 

module CST
  extend ::ECore::EPackageLookup
  cattr_accessor :owning_model # TODO: Strange, is it really necessary?

  def self.eClassifiers
  	[Tree,Node,RNode,TNode]
  end

  def self.eSubpackages
    []
  end

  def self.eSuperPackage
    
  end

  def self.nsURI
	'http://gts.inf.um.es/rubytl/cst'
  end
	
  def self.nsPrefix
  	'cst'
  end		
 
  def self.root_package
	return self unless self.eSuperPackage
	return self.eSuperPackage.root_package
  end  	
    
  module ClassAutoImplementation
  	def ePackage
  		CST
  	end
  	
  	def nsURI
      self.ePackage.nsURI
  	end
  	
  	def nsPrefix
  	  self.ePackage.nsPrefix
  	end  
  end

  # TODO: Generate nested EPackages	

module MetaTree
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Tree'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types()
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'root', Node, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module TreeCommon
end

module TreeImpl
end


module TreeStruct
    
  __meta_reference__ 'root'

#TODO: QUITAR ESTO
include TreeCommon
include TreeImpl
end

class Tree
  include TreeStruct
  class << self; include MetaTree; end      
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
    define_super_types()
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'kind', ECore::EString
    
      define_reference 'children', Node, :upperBound => -1, :containment => true
      define_reference 'parent', Node
      reference_opposite 'children', 'parent'
      reference_opposite 'parent', 'children'

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
  __meta_attribute__ 'kind'
    
  __meta_reference__ 'children'
  __meta_reference__ 'parent'

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
  

module MetaRNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'RNode'
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

module RNodeCommon
end

module RNodeImpl
end


module RNodeStruct
    

#TODO: QUITAR ESTO
include RNodeCommon
include RNodeImpl
end

class RNode
  include RNodeStruct
  class << self; include MetaRNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaTNode
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'TNode'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Node)
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

module TNodeCommon
end

module TNodeImpl
end


module TNodeStruct
  __meta_attribute__ 'value'
    

#TODO: QUITAR ESTO
include TNodeCommon
include TNodeImpl
end

class TNode
  include TNodeStruct
  class << self; include MetaTNode; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  




class Tree
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaTree;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include TreeStruct
  
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

  include NodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class RNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaRNode;
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
  include RNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class TNode
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaTNode;
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
  include TNodeStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

end
end
