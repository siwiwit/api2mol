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

import java.util.Collection;
import java.util.HashMap;
import java.util.List;

import org.eclipse.gmt.modisco.core.modeling.Feature;
import org.eclipse.gmt.modisco.core.modeling.Model;
import org.eclipse.gmt.modisco.core.modeling.ModelElement;
import org.eclipse.gmt.modisco.core.modeling.ReferenceModel;
import org.eclipse.gmt.modisco.core.modeling.ReferenceModelElement;


/**
 * This class injects new models from API methods
 * 
 * @author jlcanovas
 *
 */
public class Api2molInjector extends AbstractApi2molInjector {
	public Api2molInjector(ReferenceModel metamodel, Model mapping) {
		super(metamodel, mapping);
	}

	protected ModelElement injectNew(Object obj, boolean deep) { 
		ModelElement createdModelElement = null;

		// Firstly, we look the metaclass which corresponds to such Object
		ReferenceModelElement mainMetaclass = inferMetaclass(obj);

		// Creates the metaclass
		createdModelElement = targetmodel.createModelElement(mainMetaclass);
		// Cache the element
		cachedModelElements.put(obj, createdModelElement);

		// In case the created metaclass is the default Metaclass
		if(syntaxHelper.locateDefaultMetaclass() != null && ((String) mainMetaclass.get("name")).equals(syntaxHelper.locateDefaultMetaclass().get("metaclassName"))) {
			String defaultAttribute = (String) syntaxHelper.locateDefaultMetaclass().get("attribute");
			Api2molLogger.getInstance().print("Locating attribute " + defaultAttribute + " of " + mainMetaclass.getName() + " metaclass ");
			Feature defaultFeature = mainMetaclass.getFeature(defaultAttribute);
			modelmanager.initFeature(createdModelElement, defaultFeature, obj.getClass().getName());		
			Api2molLogger.getInstance().createDefaultMetaclassStep(syntaxHelper.locateDefaultMetaclass(), obj.getClass().getName());
			return createdModelElement;
		}

		// Obtaining all of the possible types (superclasses) that the metaclass has
		List<ReferenceModelElement> typeClasses = modelmanager.locateAllSuperclasses(mainMetaclass);

		// Obtaining all the mappings for each metaclass
		List<ModelElement> allMappings = syntaxHelper.locateAllMappings(typeClasses);

		// Traverses the features of the metaclass in order to initialize them
		Api2molLogger.getInstance().print("Features for metaclass: " + mainMetaclass.get("name"));

		Collection<? extends Feature> features = mainMetaclass.getFeatures(); 
		for(Feature feature : features) {
			// First, locates the property section
			Api2molLogger.getInstance().print("Feature: " + feature.getName() + "...");
			ModelElement section = syntaxHelper.locateSectionForFeature(feature, allMappings);

			if(section != null) {
				ModelElement mapping = (ModelElement) section.getContainer();
				String metaclass = (String) mapping.get("metaclass");
				Api2molLogger.getInstance().print("Found mapping called: " + metaclass);
			}

			if(feature.isPrimitive() && modelmanager.isBasicType(feature.getType())) {
				// It is primitive. This is executed whatever the deep parameter 
				Api2molLogger.getInstance().print("Primitive type [" + feature.getType().get("name") +"]");	
				injectPrimitiveFeature(obj, createdModelElement, feature, section);
			} else if(feature.isPrimitive() && !modelmanager.isBasicType(feature.getType())) {
				Api2molLogger.getInstance().print("Enum type [" + feature.getType().get("name") +"]");
				injectEnumFeature(obj, createdModelElement, feature, section);
			} else if(feature.isContainer() && deep) {
				// It is a containment reference. The deep parameter must be active
				Api2molLogger.getInstance().print("Container.");
				injectNonPrimitiveFeature(obj, createdModelElement, feature, section);
			} else if(!feature.isContainer() && !feature.isPrimitive() && deep) {
				// It is a non-containment reference. The deep parameter must be active
				Api2molLogger.getInstance().print("Reference.");
				injectNonPrimitiveFeature(obj, createdModelElement, feature, section);
			}
			Api2molLogger.getInstance().upToFather();
		}

		return createdModelElement;
	}

	/**
	 * Injects the value to a particular primitive feature. The property section is compulsory in order to locate the statement
	 * to be exectued
	 * @param obj The Java instance class which acts as receptor of the executed statement
	 * @param modelElement The created model element that must be initialized
	 * @param feature The feature to be injected
	 * @param section The property section which specifies the statements for that section
	 */
	private void injectPrimitiveFeature(Object obj, ModelElement modelElement, Feature feature, ModelElement section) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("self", obj);
		params.put("value", modelElement.get(feature.getName()));

		Statement[] statements = statementBuilder.buildStatements(feature, section, StatementBuilder.Mode.INJECT, params);

		for(Statement statement : statements) {
			Object resultObj = apiAccessor.invokeStatement(obj, statement);
			if(resultObj != null) { // TODO: Please, control this!
				if(resultObj.getClass().isArray()) {
					Object[] resultObjArray = (Object[]) resultObj;
					for(int i = 0; i < resultObjArray.length; i++) {
						Api2molLogger.getInstance().print("value: [" + resultObjArray[i] + "]");
						modelmanager.initFeature(modelElement, feature, resultObjArray[i]);
					}
				} else if (resultObj instanceof List) {
					List resultObjList = (List) resultObj;
					Object[] resultObjArray = (Object[]) resultObjList.toArray();
					for(int i = 0; i < resultObjArray.length; i++) {
						Api2molLogger.getInstance().print("value: [" + resultObjArray[i] + "]");
						modelmanager.initFeature(modelElement, feature, resultObjArray[i]);
					}
				} else { 
					Api2molLogger.getInstance().print("value: [" + resultObj + "]");
					modelmanager.initFeature(modelElement, feature, resultObj);
				}
			}
		}
	}

	/**
	 * Injects the value to a particular non primitive feature. The property section is compulsory in order to locate the statement
	 * to be exectued
	 * @param obj The Java instance class which acts as receptor of the executed statement
	 * @param modelElement The created model element that must be initialized
	 * @param feature The feature to be injected
	 * @param section The property section which specifies the statements for that section
	 */
	private void injectNonPrimitiveFeature(Object obj, ModelElement modelElement, Feature feature, ModelElement section) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("self", obj);
		params.put("value", modelElement.get(feature.getName()));

		Statement[] statements = statementBuilder.buildStatements(feature, section, StatementBuilder.Mode.INJECT, params);

		for(Statement statement : statements) {
			Object resultObj = apiAccessor.invokeStatement(obj, statement);
			ModelElement result = null;
			if(resultObj != null) { // TODO: Please, control this!
				if(resultObj.getClass().isArray()) {
					Object[] resultObjArray = (Object[]) resultObj;
					for(int i = 0; i < resultObjArray.length; i++) {
						Api2molLogger.getInstance().print("value: [" + resultObjArray[i] + "]");
						result = inject(resultObjArray[i], true);
						modelmanager.initFeature(modelElement, feature, result);
					}
				} else if (resultObj instanceof List) {
					List resultObjList = (List) resultObj;
					Object[] resultObjArray = (Object[]) resultObjList.toArray();
					for(int i = 0; i < resultObjArray.length; i++) {
						Api2molLogger.getInstance().print("value: [" + resultObjArray[i] + "]");
						result = inject(resultObjArray[i], true);
						modelmanager.initFeature(modelElement, feature, result);
					}
				} else {
					result = inject(resultObj, true);
					if(result != null) { // Remove this!!
						Api2molLogger.getInstance().print("value: [" + result + "]");
						modelmanager.initFeature(modelElement, feature, result);
					}
				}
			}
		}
	}

	/**
	 * Injects the value to a particular enumerated feature. The value section is compulsory in order to 
	 * locate the statement to be exectued
	 * @param obj The Java instance class which acts as receptor of the executed statement
	 * @param modelElement The created model element that must be initialized
	 * @param feature The feature to be injected
	 * @param section The property section which specifies the statements for that section
	 */
	private void injectEnumFeature(Object obj, ModelElement modelElement, Feature feature, ModelElement section) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("self", obj);

		Statement[] statements = statementBuilder.buildStatements(feature, section, StatementBuilder.Mode.INJECT, params);

		for(Statement statement : statements) {
			Object resultObj = apiAccessor.invokeStatement(obj, statement);
			if(resultObj != null) { // TODO: Please, control this!
				String typeName = (String) feature.getType().get("name");
				ReferenceModelElement type = targetmetamodel.getReferenceModelElementByName(modelmanager.digestClassname(typeName));
				List<ModelElement> enumValues = syntaxHelper.locateValueSectionsForMetaclass(type);

				for(ModelElement enumValue : enumValues) {
					String instanceValue = syntaxHelper.locateInstanceName(enumValue);
					if(checkEnumValue(resultObj, instanceValue)) {
						String metaValue = syntaxHelper.locateMetaValue(enumValue);
						modelmanager.initFeature(modelElement, feature, metaValue);
						if(!feature.isMultiValued()) break; 
					}
				}
			}
		}
	}

	/**
	 * Checks if the Object is initialized to the instanceValue value
	 * @param obj The object which represents the value
	 * @param instanceValue The string which specifies a static variable of an enumeration
	 * @return
	 */
	private boolean checkEnumValue(Object obj, String instanceValue) {
		if (obj instanceof Integer) {
			Integer intObj = (Integer) obj;
			Object enumObj = apiAccessor.locateEnumValue(instanceValue);
			if (enumObj instanceof Integer) {
				Integer intEnumObj = (Integer) enumObj;
				return (intObj.intValue() & intEnumObj.intValue()) !=  0;
			} else {
				Api2molLogger.getInstance().print("Types mismatch");
			}
		}
		return false;
	}

	/**
	 * Infers the metaclass to be created
	 * @param obj
	 * @return
	 */
	private ReferenceModelElement inferMetaclass(Object obj) {
		Api2molLogger.getInstance().print("Inferring the metaclass. ");
		ReferenceModelElement result = null;

		// Checking the context
		List<String> context = syntaxHelper.locateContext();
		if(context != null && context.size() > 0) {
			boolean inContext = false;
			String className = obj.getClass().getName();
			for(String contextName : context) {
				contextName = contextName.trim();
				if(checkContextNames(className, contextName)) {
					inContext = true;
					break;
				}
			}

			if(!inContext) {
				ModelElement defaultMetaclass = syntaxHelper.locateDefaultMetaclass();
				if(defaultMetaclass != null) {
					String defaultMetaclassName = (String) defaultMetaclass.get("metaclassName");
					return targetmetamodel.getReferenceModelElementByName(modelmanager.digestClassname(defaultMetaclassName));
				} else {
					System.err.println("There is no default metaclass for those elements not included in the context");
					return null;
				}
			}
		}


		// Trying to locate a mapping in the transformation definition
		ModelElement mainMapping = syntaxHelper.locateMappingForObject(obj);
		if(mainMapping != null) {
			// Obtains the metaclass to be created 
			String metaclass =  ((String) mainMapping.get("metaclass"));
			Api2molLogger.getInstance().print("Exists mapping. The metaclass is " + metaclass);
			Api2molLogger.getInstance().createMappingStep(mainMapping, metaclass, false);
			String digestedMetaclass = modelmanager.digestClassname(metaclass);
			result = targetmetamodel.getReferenceModelElementByName(digestedMetaclass);
		} else if (!INFER_METACLASS && syntaxHelper.locateDefaultMetaclass() != null) {
			ModelElement defaultMetaclass = syntaxHelper.locateDefaultMetaclass();
			String defaultMetaclassName = (String) defaultMetaclass.get("metaclassName");
			Api2molLogger.getInstance().createMappingStep(null, defaultMetaclassName, false);
			result = targetmetamodel.getReferenceModelElementByName(modelmanager.digestClassname(defaultMetaclassName));
		} else {
			// Inferring the metaclass from the Object class
			Api2molLogger.getInstance().print("The mapping does not exist");
			String instanceClassName = obj.getClass().getName();
			String possibleMetaclass = instanceClassName.substring(instanceClassName.lastIndexOf(".")+1, instanceClassName.length());

			// Checking for inner classes
			int innerClassIndex = possibleMetaclass.indexOf("$");
			if(innerClassIndex > 0) {
				possibleMetaclass = possibleMetaclass.substring(innerClassIndex+1, possibleMetaclass.length());
			}

			Api2molLogger.getInstance().print("Trying " + possibleMetaclass);
			String digestedMetaclass = modelmanager.digestClassname(possibleMetaclass);
			Api2molLogger.getInstance().createMappingStep(null, digestedMetaclass, false);
			result = targetmetamodel.getReferenceModelElementByName(digestedMetaclass);
		}

		return result;
	}

	/**
	 * Checks if className satifies the contextName restriction
	 * @param className
	 * @param contextName
	 * @return
	 */
	private boolean checkContextNames(String className, String contextName) {
		if(contextName.endsWith(".*")) {
			String contextPackageName = contextName.substring(0, contextName.lastIndexOf("."));
			return className.startsWith(contextPackageName);
		} else if (className.indexOf(".") > 0){
			String packageName = className.substring(0, className.lastIndexOf("."));
			return className.startsWith(packageName);
		} else if (className.indexOf(".") < 0) {
			// Primive Types
			return true;
		} else {
			return false;
		}
	}
}
