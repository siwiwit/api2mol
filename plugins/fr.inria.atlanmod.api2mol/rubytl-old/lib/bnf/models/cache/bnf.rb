module RubyTL 
# TODO: This should be in some CacheRepository
# automate the loading from here... 

module BNF
  extend ::ECore::EPackageLookup
  cattr_accessor :owning_model # TODO: Strange, is it really necessary?

  def self.eClassifiers
  	[Grammar,Token,PairToken,IgnoredToken,Rule,Symbol,Terminal,NoTerminal,Optional,Repetition,Lambda]
  end

  def self.eSubpackages
    []
  end

  def self.eSuperPackage
    
  end

  def self.nsURI
	'http://gts.inf.um.es/rubytl/bnf'
  end
	
  def self.nsPrefix
  	'bnf'
  end		
 
  def self.root_package
	return self unless self.eSuperPackage
	return self.eSuperPackage.root_package
  end  	
    
  module ClassAutoImplementation
  	def ePackage
  		BNF
  	end
  	
  	def nsURI
      self.ePackage.nsURI
  	end
  	
  	def nsPrefix
  	  self.ePackage.nsPrefix
  	end  
  end

  # TODO: Generate nested EPackages	

module MetaGrammar
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Grammar'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types()
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'name', ECore::EString
    
      define_reference 'rules', Rule, :upperBound => -1, :containment => true
      define_reference 'tokens', Token, :upperBound => -1, :containment => true
      define_reference 'ignoredTokens', IgnoredToken, :upperBound => -1, :containment => true
      define_reference 'pairTokens', PairToken, :upperBound => -1, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module GrammarCommon
end

module GrammarImpl
end


module GrammarStruct
  __meta_attribute__ 'name'
    
  __meta_reference__ 'rules'
  __meta_reference__ 'tokens'
  __meta_reference__ 'ignoredTokens'
  __meta_reference__ 'pairTokens'

#TODO: QUITAR ESTO
include GrammarCommon
include GrammarImpl
end

class Grammar
  include GrammarStruct
  class << self; include MetaGrammar; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaToken
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Token'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types()
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'regexp', ECore::EString
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

module TokenCommon
end

module TokenImpl
end


module TokenStruct
  __meta_attribute__ 'regexp'
  __meta_attribute__ 'name'
    

#TODO: QUITAR ESTO
include TokenCommon
include TokenImpl
end

class Token
  include TokenStruct
  class << self; include MetaToken; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaPairToken
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'PairToken'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Token)
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'endRegexp', ECore::EString
    

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module PairTokenCommon
end

module PairTokenImpl
end


module PairTokenStruct
  __meta_attribute__ 'endRegexp'
    

#TODO: QUITAR ESTO
include PairTokenCommon
include PairTokenImpl
end

class PairToken
  include PairTokenStruct
  class << self; include MetaPairToken; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaIgnoredToken
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'IgnoredToken'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Token)
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

module IgnoredTokenCommon
end

module IgnoredTokenImpl
end


module IgnoredTokenStruct
    

#TODO: QUITAR ESTO
include IgnoredTokenCommon
include IgnoredTokenImpl
end

class IgnoredToken
  include IgnoredTokenStruct
  class << self; include MetaIgnoredToken; end      
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
      define_attribute 'name', ECore::EString
    
      define_reference 'left', NoTerminal, :containment => true
      define_reference 'right', Symbol, :upperBound => -1, :containment => true

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
  __meta_attribute__ 'name'
    
  __meta_reference__ 'left'
  __meta_reference__ 'right'

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
  

module MetaSymbol
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Symbol'
  end

  def abstract
    true
  end

  def eSuperTypes
    define_super_types()
  end

  def eStructuralFeatures
    define_structural_features do
      define_attribute 'name', ECore::EString
      define_attribute 'positionIdentifier', ECore::EString
    

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module SymbolCommon
end

module SymbolImpl
end


module SymbolStruct
  __meta_attribute__ 'name'
  __meta_attribute__ 'positionIdentifier'
    

#TODO: QUITAR ESTO
include SymbolCommon
include SymbolImpl
end

class Symbol
  include SymbolStruct
  class << self; include MetaSymbol; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaTerminal
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Terminal'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Symbol)
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

module TerminalCommon
end

module TerminalImpl
end


module TerminalStruct
    

#TODO: QUITAR ESTO
include TerminalCommon
include TerminalImpl
end

class Terminal
  include TerminalStruct
  class << self; include MetaTerminal; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaNoTerminal
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'NoTerminal'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Symbol)
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

module NoTerminalCommon
end

module NoTerminalImpl
end


module NoTerminalStruct
    

#TODO: QUITAR ESTO
include NoTerminalCommon
include NoTerminalImpl
end

class NoTerminal
  include NoTerminalStruct
  class << self; include MetaNoTerminal; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaOptional
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Optional'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Symbol)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'symbol', Symbol, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module OptionalCommon
end

module OptionalImpl
end


module OptionalStruct
    
  __meta_reference__ 'symbol'

#TODO: QUITAR ESTO
include OptionalCommon
include OptionalImpl
end

class Optional
  include OptionalStruct
  class << self; include MetaOptional; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaRepetition
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Repetition'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Symbol)
  end

  def eStructuralFeatures
    define_structural_features do
    
      define_reference 'symbol', Symbol, :containment => true

    end
  end      
  
  def eOperations
  	[]
  	#define_operations do
  		# TODO: xxxx
  	#end
  end
end

module RepetitionCommon
end

module RepetitionImpl
end


module RepetitionStruct
    
  __meta_reference__ 'symbol'

#TODO: QUITAR ESTO
include RepetitionCommon
include RepetitionImpl
end

class Repetition
  include RepetitionStruct
  class << self; include MetaRepetition; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  

module MetaLambda
  include ECore::Helper
  include ClassAutoImplementation

  def non_qualified_name
  	'Lambda'
  end

  def abstract
    false
  end

  def eSuperTypes
    define_super_types(Symbol)
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

module LambdaCommon
end

module LambdaImpl
end


module LambdaStruct
    

#TODO: QUITAR ESTO
include LambdaCommon
include LambdaImpl
end

class Lambda
  include LambdaStruct
  class << self; include MetaLambda; end      
  def metaclass; self.class; end
  
  def self.is_primitive?;   false;  end
  def self.is_enumeration?; false; end
  def self.is_metaclass?; 	true; end  
end
# This definition is duplicated (in class_definition template) why?    
  




class Grammar
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaGrammar;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include GrammarStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Token
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaToken;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include TokenStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class PairToken
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaPairToken;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include TokenStruct
  include PairTokenStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class IgnoredToken
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaIgnoredToken;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include TokenStruct
  include IgnoredTokenStruct
  
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
    
  

class Symbol
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaSymbol;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include SymbolStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Terminal
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaTerminal;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include SymbolStruct
  include TerminalStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class NoTerminal
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaNoTerminal;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include SymbolStruct
  include NoTerminalStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Optional
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaOptional;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include SymbolStruct
  include OptionalStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Repetition
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaRepetition;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include SymbolStruct
  include RepetitionStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

class Lambda
    include RMOF::ObjectHelper
    include RMOF::ObjectLookup
    include RMOF::InverseResolvers
    include RMOF::TypeChecking
    
  class << self; 
  	include MetaLambda;
  	# This to allow serialization of ECore elements in a normal metamodel
  	def owning_model
      ECore.owning_model
    end
   
    def compute_uri_fragment
      '#//' + self.non_qualified_name
    end
  end      
  def metaclass; self.class; end

  include SymbolStruct
  include LambdaStruct
  
#  def nsURI; self.ePackage.nsURI; end	
#  def nsPrefix; self.ePackage.nsPrefix; end  
  
end
    
  

end
end
