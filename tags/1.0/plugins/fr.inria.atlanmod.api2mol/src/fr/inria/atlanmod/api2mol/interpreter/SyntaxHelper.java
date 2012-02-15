/*******************************************************************************
 * Copyright (c) 2008, 2012
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *    Javier Canovas (javier.canovas@inria.fr) 
 *******************************************************************************/

package fr.inria.atlanmod.api2mol.interpreter;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.eclipse.gmt.modisco.core.modeling.EnumLiteral;
import org.eclipse.gmt.modisco.core.modeling.Feature;
import org.eclipse.gmt.modisco.core.modeling.Model;
import org.eclipse.gmt.modisco.core.modeling.ModelElement;
import org.eclipse.gmt.modisco.core.modeling.ReferenceModel;
import org.eclipse.gmt.modisco.core.modeling.ReferenceModelElement;

/**
 * This class offers a set of methods for making easier the management of the abstract syntax
 * @author jlcanovas
 *
 */
public class SyntaxHelper {
	public enum Mode { INJECT, EXTRACT }

	public static final String INJECT = "__INJECTIG__";
	public static final String EXTRACT = "__EXTRACT__";
	public static final String PREFIX = "api2mol";

	ReferenceModel api2molMetamodel;
	Model mappingDef;
	ModelManager modelManager;

	// For efficient purposes, we store the default metaclass
	ModelElement defaultMetaclass = null;

	public SyntaxHelper(Model mappingDef, ModelManager modelManager) {
		this.api2molMetamodel = mappingDef.getReferenceModel();
		this.mappingDef = mappingDef;
		this.modelManager = modelManager;
	}

	/**
	 * Locates a Mapping definition whose target API instace class name is the same of the parameter
	 * @param obj
	 * @return
	 */
	public ModelElement locateMappingForObject(Object obj) {
		String tgtInstanceName = obj.getClass().getName();

		ReferenceModelElement mappingmetaclass = api2molMetamodel.getReferenceModelElementByName(PREFIX + "::Mapping");

		Set<? extends ModelElement> mappings = mappingDef.getModelElementsByType(mappingmetaclass);
		for(ModelElement me : mappings) {
			String mapInstanceName = (String) me.get("instanceClass");
			if(tgtInstanceName.equals(mapInstanceName)) {
				return me;
			}
		}

		return null;
	}

	/**
	 * Locates a Mapping definition for a particular modelElement instance. This method retrieves the metaclass of
	 * the instance and look the mapping up in the transformation. This method calls to locateMappingForMetaclass.
	 * @param instance The model element instance
	 * @return The Mapping definition
	 */
	public ModelElement locateMappingForMetaclass(ModelElement instance) {
		return locateMappingForMetaclass(instance.getReferenceModelElement());
	}

	/**
	 * Locates a Mapping definition for a particular metaclass. 
	 * @param metaclass The reference model element
	 * @return The mapping definition
	 */
	public ModelElement locateMappingForMetaclass(ReferenceModelElement metaclass) {
		String tgtMetaclassName = (String) metaclass.get("name");

		ReferenceModelElement mappingmetaclass = api2molMetamodel.getReferenceModelElementByName(PREFIX + "::Mapping");

		Set<? extends ModelElement> mappings = mappingDef.getModelElementsByType(mappingmetaclass);
		for(ModelElement me : mappings) {
			String mapMetaclassName = (String) me.get("metaclass");
			if(tgtMetaclassName.equals(mapMetaclassName)) {
				return me;
			}
		}

		return null;
	}


	/**
	 * Locates the section for a particular feature in a mapping
	 * TODO: For now, this is specified to deal with just Propertysections
	 * @param feature
	 * @param mapping
	 * @return
	 */
	public ModelElement locateSectionForFeature(Feature feature, ModelElement mapping) {
		String tgtName = feature.getName();

		List<ModelElement> propSections = (List<ModelElement>) mapping.get("sections");
		for(ModelElement me : propSections) {
			ReferenceModelElement propertySectionMetaclass = api2molMetamodel.getReferenceModelElementByName(PREFIX + "::PropertySection");
			if(me.isKindOf(propertySectionMetaclass)) {
				String property = (String) me.get("property");
				if(tgtName.equals(property)) {
					return me;
				}
			}
		}

		return null;
	}

	/**
	 * Locates the section for a particular feature in a mapping list
	 * @param feature
	 * @param mapping
	 * @return
	 */
	public ModelElement locateSectionForFeature(Feature feature, List<ModelElement> mappingList) {
		String tgtName = feature.getName();

		for(ModelElement mapping : mappingList) {
			ModelElement result = locateSectionForFeature(feature, mapping);
			if(result != null) return result;
		}

		return null;
	}

	/**
	 * Locates the statement specified as parameter
	 * @param section
	 * @param statementType
	 * @return
	 */
	public ModelElement locateStatement(ModelElement section, String statementType) {		
		List<ModelElement> statements = (List<ModelElement>) section.get("statements");
		for(ModelElement me : statements) {
			EnumLiteral type = (EnumLiteral) me.get("type");
			if(type.toString().equals(statementType)) {
				return me;
			}
		}
		return null;
	}

	/**
	 * Locates all the enumerated values for a particular type. The values must be defined in the transformation
	 * definition as "enum" mappings
	 * @param type The type 
	 * @return A list of ModelElement which contains the valueSections
	 */
	public List<ModelElement> locateValueSectionsForMetaclass(ReferenceModelElement type) {
		List<ModelElement> result = null;
		ReferenceModelElement valueSectionMetaclass = api2molMetamodel.getReferenceModelElementByName(PREFIX + "::ValueSection");

		ModelElement mapping = locateMappingForMetaclass(type);
		if(mapping != null) {
			result = new ArrayList<ModelElement>();

			List<ModelElement> sections = (List<ModelElement>) mapping.get("sections");
			for(ModelElement section : sections) {
				if(section.isKindOf(valueSectionMetaclass)) {
					result.add(section);
				}
			}
		}

		return result;		
	}

	/**
	 * Obtains the string value specified by the ValueProperti model element for the instance value. 
	 * The metaclass type of the parameter is checked before any computation
	 * @param enumValue The model element from which the instanceName must be obtained
	 * @return The instance name string value
	 */
	public String locateInstanceName(ModelElement enumValue) {
		ReferenceModelElement valueSectionMetaclass = api2molMetamodel.getReferenceModelElementByName(PREFIX + "::ValueSection");
		if(enumValue.isKindOf(valueSectionMetaclass)) {
			return (String) enumValue.get("instanceValue");
		}
		return null;
	}

	/**
	 * Obtains the string value specified by the ValueProperti model element for the metaclass value. 
	 * The metaclass type of the parameter is checked before any computation
	 * @param enumValue The model element from which the instanceName must be obtained
	 * @return The instance name string value
	 */
	public String locateMetaValue(ModelElement enumValue) {
		ReferenceModelElement valueSectionMetaclass = api2molMetamodel.getReferenceModelElementByName(PREFIX + "::ValueSection");
		if(enumValue.isKindOf(valueSectionMetaclass)) {
			return (String) enumValue.get("metaValue");
		}
		return null;
	}

	/**
	 * Looks for a DefaultMetaclass Section in the root of the transformation definition
	 * @return the ModelElement which represents to the DefaultClass section
	 */
	public ModelElement locateDefaultMetaclass() {
		if(defaultMetaclass == null) {
			ReferenceModelElement definitionMetaclass = api2molMetamodel.getReferenceModelElementByName(PREFIX + "::Definition");

			Set<? extends ModelElement> definitions = (Set<? extends ModelElement>) mappingDef.getModelElementsByKind(definitionMetaclass);
			if(definitions.size() > 0)  { //TODO: Take care, we take the first one definition. Should we support more?
				ModelElement definition = definitions.iterator().next();
				ModelElement defaultMetaclass = (ModelElement) definition.get("defaultMetaclass");
				return defaultMetaclass;
			}

			return null; 
		} else {
			return this.defaultMetaclass;
		}
	}

	/**
	 * Return the context, if it exists
	 * @return
	 */
	public List<String> locateContext() {		
		ReferenceModelElement definitionMetaclass = api2molMetamodel.getReferenceModelElementByName(PREFIX + "::Definition");

		Set<? extends ModelElement> definitions = (Set<? extends ModelElement>) mappingDef.getModelElementsByKind(definitionMetaclass);
		if(definitions.size() > 0)  { //TODO: Take care, we take the first one definition. Should we support more?
			ModelElement definition = definitions.iterator().next();
			List<String> result = (List<String>) definition.get("context");
			int a = 0; a++;
			return result;
		}
		return null;
	}

	/**
	 * Obtains the new section of a Mapping element. It first checks that the mapping element received is
	 * an instance of Mapping metaclass
	 * @param mapping The mapping where the new section is going to be located
	 * @return The new section, null if it is not located.
	 */
	public ModelElement locateNewSection(ModelElement mapping) {
		List<ModelElement> sections = (List<ModelElement>) mapping.get("sections");
		for(ModelElement section : sections) {
			if(section.getReferenceModelElement().getName().equals("NewSection")) {
				return section;
			}
		}

		return null;
	}

	/**
	 * Locates the multiple section of a set of mappings
	 * @param allMappings Set of mappings which contains the multiple section
	 * @return The multiple sections
	 */
	public List<ModelElement> locateMultipleSection(List<ModelElement> allMappings) {
		List<ModelElement> result = new ArrayList<ModelElement>();

		for(ModelElement mapping : allMappings) {
			ModelElement multipleSection = locateMultipleSection(mapping);
			if(multipleSection != null) {
				result.add(multipleSection);
			}
		}

		return result;
	}

	/**
	 * Locates the multiple section of a mapping
	 * @param mapping The mapping which contains the multiple section
	 * @return The multiple section
	 */
	public ModelElement locateMultipleSection(ModelElement mapping) {	
		List<ModelElement> sections = (List<ModelElement>) mapping.get("sections");
		for(ModelElement section : sections) {
			if(section.getReferenceModelElement().getName().equals("MultipleSection")) {
				return section;
			}
		}
		return null;
	}
	
	/**
	 * Obtains the mappings for each metaclass. 
	 * @param typeClasses List of ReferenceModelElements which represent the metaclasses
	 * @return List of ModelElements (instances of Mapping metaclass) 
	 */
	public List<ModelElement> locateAllMappings(List<ReferenceModelElement> typeClasses) {
		List<ModelElement> result = new ArrayList<ModelElement>();
		for(ReferenceModelElement superclass : typeClasses) {
			ModelElement superMapping = locateMappingForMetaclass(superclass);
			if(superMapping != null) result.add(superMapping);
		}
		return result;
	}
}
