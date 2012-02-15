#/*******************************************************************************
#* Copyright (c) 2008, 2012
#* All rights reserved. This program and the accompanying materials
#* are made available under the terms of the Eclipse Public License v1.0
#* which accompanies this distribution, and is available at
#* http://www.eclipse.org/legal/epl-v10.html
#*
#* Contributors:
#*    Javier Canovas (javier.canovas@inria.fr) 
#*******************************************************************************/

BTYPES = { "java.lang.String" => ::ECore::EString, 
           "char"    => ::ECore::EChar, 
           "int"     => ::ECore::EInt, 
           "long"    => ::ECore::ELong, 
           "double"  => ::ECore::EDouble, 
           "boolean" => ::ECore::EBoolean, 
           "byte"    => ::ECore::EByte,
           "void"    => "", 
           "float"   => ::ECore::EFloat, 
           "short"   => ::ECore::EShort}#, 
           #"java.lang.Object" => ::ECore::EObject}#, 
           #"java.lang.Class" => Ecore::EClass}

#FILTERS = ["javax.swing", "java.awt"]
#FILTERS = ["org.eclipse.jdt.core.dom"]
FILTERS = Configuration::ConfigurationElement.all_objects.first.filter
#TGT_PACKAGE_NAME = "swing"
#TGT_PACKAGE_NAME = "jdt"
TGT_PACKAGE_NAME = Configuration::ConfigurationElement.all_objects.first.mainPackage
  
  
#######################
## DECORATORS
#######################
decorator Reflect::ClassType do
  def isMainClassType
    FILTERS.any?{|f| self.canonicalName =~ /^#{f}/} and not (BTYPES.has_key?(self.canonicalName)) and not (self.canonicalName =~ /\[\]$/) and not (self.canonicalName =~ /^\[/) 
  end

  def digestName 
    nameDigested = self.name[self.name.rindex('.')+1, self.name.length].sub("$", ".")
    if(nameDigested.rindex(';') == nameDigested.length-1) 
      return nameDigested = nameDigested[0, nameDigested.length-1]
    else 
      return nameDigested
    end
  end
  
  def digestFields
    allFields = self.declaredFields.select{|f| (not f.name == f.name.upcase) and f.hasGetOrSet and not f.isFinal}
    # TODO uncomment the following lines
    #if(self.isAbstract) 
    #return allFields.reject{|f| f.hasDefaultGet and (f.defaultGet.first.isPackageVisible or f.defaultGet.first.isPrivate)}
    #else
    #  return allFields
    #end 
  end
  
  def createAnnotations
    anotations            = Ecore::EAnnotation.new
    anotations.references = self
    anotations.source     = "ExtendedMetaData"
    anotations.details   << Ecore::EStringToStringMapEntry.new(:key => "canonicalName", :value => self.name)
    anotations.details   << Ecore::EStringToStringMapEntry.new(:key => "isMainType", :value => self.isMainClassType.to_s) 
    return anotations
  end
  
  def isAbstract 
    self.modifiers.each do |mod|
      return true if (mod == Reflect::Modifier::ABSTRACT) 
    end
    return false
  end
end

decorator Reflect::Member do
  def isAbstract 
    self.modifiers.each do |mod|
      return true if (mod == Reflect::Modifier::ABSTRACT) 
    end
    return false
  end
  
  def isPackageVisible
    self.modifiers.all?{|mod| mod != Reflect::Modifier::PUBLIC and mod != Reflect::Modifier::PRIVATE and mod != Reflect::Modifier::PROTECTED}
  end
  
  def isPrivate
    self.modifiers.any?{|mod| mod == Reflect::Modifier::PRIVATE}
  end
  
  def isFinal
    self.modifiers.any?{|mod| mod == Reflect::Modifier::FINAL}
  end
end


decorator Reflect::Field do
  def isPrimitiveTyped
    BTYPES.has_key?(self.type.name) or BTYPES.keys.any?{|t| self.type.canonicalName =~ /^#{t}/} 
  end

  def hasGetOrSet
    #self.__container__.get('methods').any?{|m| m.name =~ /#{self.name[0,1].to_s.capitalize + self.name[1,self.name.length]}$/ and m.returnType == self.type} or 
    #self.__container__.declaredMethods.any?{|m| m.name =~ /#{self.name[0,1].to_s.capitalize + self.name[1,self.name.length]}$/}
    self.hasDefaultGet #|| self.hasDefaultSet 
  end

  def hasDefaultGet
    #self.__container__.get('methods').any?{|m| m.name == 'get' + self.name[0,1].to_s.capitalize + self.name[1,self.name.length] and m.parameterTypes.size == 0 and m.returnType == self.type} or
    self.defaultGet.size > 0    
  end
  
  def hasDefaultSet
    #self.__container__.get('methods').any?{|m| m.name == 'set' + self.name[0,1].to_s.capitalize + self.name[1,self.name.length] and m.parameterTypes.size == 0} or
    #self.__container__.declaredMethods.any?{|m| m.name == 'set' + self.name[0,1].to_s.capitalize + self.name[1,self.name.length] and m.parameterTypes.size == 1 and m.parameterType.first.name == self.type.name}
    self.defaultSet.size > 0     
  end
  
  def defaultGet
    self.__container__.declaredMethods.select{|m| m.name == ((self.type.name == "boolean") ? 'is' : 'get') + self.name[0,1].to_s.capitalize + self.name[1,self.name.length] and m.parameterTypes.size == 0  and m.returnType.name == self.type.name}
  end
  
  def defaultSet
    self.__container__.declaredMethods.select{|m| m.name == 'set' + self.name[0,1].to_s.capitalize + self.name[1,self.name.length] and m.parameterTypes.size == 1 and m.parameterTypes.first.name == self.type.name} 
  end
end

#########################
## TRANSFORMATION RULES
#########################

#########################
## MAIN PHASE
#########################

phase 'mainPhase' do

PACKAGE = Ecore::EPackage.new(:name => TGT_PACKAGE_NAME)
PACKAGE.nsURI = "http://modelum.es/atlanmod/"+ TGT_PACKAGE_NAME
PACKAGE.nsPrefix = TGT_PACKAGE_NAME

DEFAULT_ELEMENT = Ecore::EClass.new(:name => "UnknownElement")
DEFAULT_ELEMENT.eStructuralFeatures << Ecore::EAttribute.new(:name => "type", :eType => ::ECore::EString)
PACKAGE.eClassifiers << DEFAULT_ELEMENT

top_rule 'mapMainClassType' do
  from  Reflect::ClassType
  to    Ecore::EClass
  filter do |src|
    src.isMainClassType
  end
  
  mapping do |src, tgt|
    tgt.name                = src.digestName
    tgt.abstract            = src.isAbstract
    tgt.eStructuralFeatures = src.digestFields
    tgt.eSuperTypes         = src.superclass
    tgt.eSuperTypes         = src.interfaces
    tgt.eAnnotations        = src.createAnnotations
    PACKAGE.eClassifiers << tgt
  end 
end

rule 'mapClassType' do
  from  Reflect::ClassType
  to    Ecore::EClass
  filter do |src|
    not src.isMainClassType
  end
  
  mapping do |src, tgt|
    tgt.name         = src.digestName
    tgt.eSuperTypes  = src.superclass
    tgt.eSuperTypes  = src.interfaces
    tgt.eAnnotations = src.createAnnotations
    PACKAGE.eClassifiers << tgt
  end
end

rule 'mapAttribute' do
  from  Reflect::Field  
  to    Ecore::EAttribute
  filter do |src|
    src.isPrimitiveTyped
  end
  mapping do |src, tgt|
    tgt.name = src.name  
    
    # Inferring the type
    typeName = (src.type.canonicalName =~ /\[\]$/) ?  src.type.canonicalName[0, src.type.canonicalName.index('[')] : src.type.name 
    tgt.set 'eType', BTYPES[typeName]
    
    # Inferring the cardinality
    tgt.upperBound = -1 if src.type.canonicalName =~ /\[\]$/
  end
end 

rule 'mapReference' do
  from  Reflect::Field  
  to    Ecore::EReference
  filter do |src|
    not src.isPrimitiveTyped
  end
  mapping do |src, tgt|
    tgt.name  = src.name  
    
    # Detectin arrays
    if(src.type.canonicalName =~ /\[\]$/)
      typeName  = src.type.canonicalName[0, src.type.canonicalName.index('[')] 
      tgt.eType = Reflect::ClassType.all_objects.select{|c| c.canonicalName == typeName}
    else
      tgt.eType = src.type 
    end
    
    # Inferring the cardinality
    tgt.upperBound = -1 if src.type.canonicalName =~ /\[\]$/

    # We suppose that it is containment because the field has been obtained from declaredFields
    #tgt.containment = true
  end
end 

end

#########################
## EXTRA PHASE
#########################

phase 'extra_phase' do

MainDef = Api2mol::Definition.new
MainDef.context = FILTERS
#MainDef.context << 'java.awt.*'
MainDef.set 'defaultMetaclass', Api2mol::DefaultMetaclassSection.new(:metaclassName =>  Configuration::ConfigurationElement.all_objects.first.defaultMetaclassName, :attribute =>  Configuration::ConfigurationElement.all_objects.first.defaultMetaclassAttribute)

top_rule 'mapMapping' do
  from  Reflect::ClassType
  to    Api2mol::Mapping
  filter do |src|
    src.isMainClassType
  end
  
  mapping do |src, tgt|
    tgt.metaclass     = src.digestName
    tgt.instanceClass = src.name
    #tgt.sections      = src.declaredFields.select{|f| f.hasDefaultGet} if src.isMainClassType
    tgt.sections      = src.digestFields if src.isMainClassType
    
    MainDef.mappings << tgt
  end 
end

rule 'mapSections' do
  from  Reflect::Field
  to    Api2mol::PropertySection
  mapping do |src, tgt|
    tgt.property   = src.name
    tgt.statements = src
  end
end

# Rules for statements
rule 'mapDefaultGet' do
  from  Reflect::Field
  to    Api2mol::Statement
  filter do |src|
    src.hasDefaultGet
  end
  mapping do |src, tgt|
    tgt.type      = Api2mol::StatementType::GET
    #tgt.variables = 
    #tgt.calls     =
  end
end

rule 'mapDefaultSet' do
  from  Reflect::Field
  to    Api2mol::Statement
  filter do |src|
    src.hasDefaultSet
  end
  mapping do |src, tgt|
    tgt.type      = Api2mol::StatementType::SET
    #tgt.variables = 
    #tgt.calls     =
  end
end

end