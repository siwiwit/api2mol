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

import java.lang.reflect.Constructor;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.eclipse.gmt.modisco.core.modeling.EnumLiteral;
import org.eclipse.gmt.modisco.core.modeling.Feature;
import org.eclipse.gmt.modisco.core.modeling.Model;
import org.eclipse.gmt.modisco.core.modeling.ModelElement;
import org.eclipse.gmt.modisco.core.modeling.ReferenceModelElement;

/**
 * This class is in charge of extracting models into an API
 * @author jlcanovas
 *
 */
public class Api2molExtractor extends Api2molProjector {
	public static boolean USE_DEFAULT_CONSTRUCTOR = true;
	public static boolean INFER_STATEMENTS = true;

	// Cache of created objects
	HashMap<ModelElement, Object> cachedObjects;

	Model sourceModel;

	public Api2molExtractor(Model model, Model mapping) {
		super(mapping, model.getReferenceModel());
		Api2molLogger.getInstance().print("Api2MoL Extractor");
		this.sourceModel = model;
		this.cachedObjects = new HashMap<ModelElement, Object>(); 
	}

	/**
	 * Launchs an api2mol extraction process
	 * The root element must be specified
	 * 
	 * @param URIElement The URI of the root element
	 * @return The set of instance objects created
	 */
	public Object[] launch(String URIElement) {
		ArrayList<Object> result = new ArrayList<Object>();

		Set<? extends ModelElement> elements = this.sourceModel.getModelElementsByKind(sourceModel.getReferenceModel().getReferenceModelElementByName(URIElement));
		Iterator<? extends ModelElement> itElements = elements.iterator();
		while(itElements.hasNext()) {
			result.add(extract(itElements.next()));
		}
		return result.toArray();
	}

	/**
	 * Extracts a model element. It checks if the modelElement has been extracted previously. If so,
	 * the previously created object is returned
	 * @param modelElement ModelElement to be extracted
	 * @return The object created for the model element received
	 */
	private Object extract(ModelElement modelElement) {
		Api2molLogger.getInstance().incDeep();
		Api2molLogger.getInstance().print("Extracting " + modelElement.getReferenceModelElement().getName() + " metaclass... " + modelElement + " ");

		Object result = null;
		Object cachedElement = cachedObjects.get(modelElement);
		if (cachedElement == null) {
			result = extractNew(modelElement);
		} else {
			Api2molLogger.getInstance().append("cached! ");
			result = cachedElement;
		}

		Api2molLogger.getInstance().decDeep();
		return result;		
	}

	/**
	 * Extracts a new model element
	 * @param modelElement The ModelElement to be extracted
	 * @return The object created for the model element received
	 */
	private Object extractNew(ModelElement modelElement) {
		Object result = null;

		Collection<? extends Feature> features = modelElement.getReferenceModelElement().getFeatures();

		// 1. Locating the mapping for such a model element
		ModelElement mapping = syntaxHelper.locateMappingForMetaclass(modelElement);

		if(mapping != null) {
			// Mapping located
			// 2. We have to create the element for this instance. How we can create it? Is there a new section?
			ModelElement newSection = syntaxHelper.locateNewSection(mapping);
			if(newSection != null) {
				// 2.1. There is a new section,  we have to create the element according to it
				Object[] constructorArgs = null;
				List<ModelElement> constructorMethods = (List<ModelElement>) newSection.get("constructors");
				String instanceClass = (String) mapping.get("instanceClass");

				if(constructorMethods.size() > 0) { 
					ModelElement possibleConstructor = constructorMethods.get(0); // TODO: Just the first is considered

					String name = (String) possibleConstructor.get("name");
					if(name.equals("ComponentOrientation")) {
						int a = 0; a++;
					}

					List<ModelElement> syntaxParams = (List<ModelElement>) possibleConstructor.get("params");
					constructorArgs = new Object[syntaxParams.size()];
					boolean syntaxParamsWithoutValue = false;


					for(int i = 0; i < syntaxParams.size(); i++) {
						boolean valueFromFeature = false;
						String nameSyntaxParam = (String) syntaxParams.get(i).get("name");

						for(Feature feature : features) {
							if(feature.getName().equals(nameSyntaxParam)) {
								Object argValue = null;
								if(feature.isPrimitive() && modelmanager.isBasicType(feature.getType())) {
									argValue = modelElement.get(feature.getName());
								} else {
									if(!feature.isMultiValued()) {
										ModelElement element = (ModelElement) modelElement.get(feature.getName());
										argValue = extract(element);
									}
								}
								valueFromFeature = true;
								constructorArgs[i]  = argValue;
							} 
						}

						if(!valueFromFeature) {
							if(nameSyntaxParam.matches("[0-9]+")) {
								constructorArgs[i] = new Integer(nameSyntaxParam);
							} else {
								constructorArgs[i] = nameSyntaxParam;
							}
						}
					}	
					result = apiAccessor.invokeConstructor((String) mapping.get("instanceClass"), constructorArgs);
				}


			} else {
				// 2.2. There is not a new section
				Constructor constructor =  null;
				if(USE_DEFAULT_CONSTRUCTOR && (((String) mapping.get("instanceClass")) != null)) {
					// 2.2.1. We can use the default constructor and it exists
					result = apiAccessor.invokeDefaultConstructor((String) mapping.get("instanceClass"));
				} else {
					// 2.2.2. We cannot use the default constructor -> ERROR
					// We cannot create the element
					return null;
				}
			}

			// At this point the object should have been constructed so we can put into the cached elements
			if(result != null) {
				cachedObjects.put(modelElement, result);
			} else {
				Api2molLogger.getInstance().print("The object cannot be built");
				return null;
			}

			// Obtaining all of the possible types (superclasses) that the metaclass has
			List<ReferenceModelElement> typeClasses = modelmanager.locateAllSuperclasses(modelElement.getReferenceModelElement());

			// Obtaining all the mappings for each metaclass
			List<ModelElement> allMappings = syntaxHelper.locateAllMappings(typeClasses);

			// 2. Initialization of the object features
			Api2molLogger.getInstance().print("[" + features.size() + "] Features for metaclass: " + modelElement.getReferenceModelElement().get("name"));

			// 2.1 We first initialize the features specified by multiple sections
			List<ModelElement> multipleSections = syntaxHelper.locateMultipleSection(allMappings);
			for(ModelElement multipleSection : multipleSections) {
				List<ModelElement> stats = (List<ModelElement>) multipleSection.get("statements");
				for(ModelElement multipleStatement : stats) {
					EnumLiteral enumValue =  (EnumLiteral) multipleStatement.get("type");
					if(enumValue.toString().equals("SET")) {
						List<ModelElement> calls = (List<ModelElement>) multipleStatement.get("calls");
						if(calls.size() > 0) {
							ModelElement methodCall = calls.get(0);
							// We have to locate the features that are being initialized
							List<ModelElement> syntaxParams = (List<ModelElement>) methodCall.get("params");
							List<Feature> featuresToInit = new ArrayList<Feature>();

							for(ModelElement syntaxParam : syntaxParams) {
								String nameSyntaxParam = (String) syntaxParam.get("name");

								for(Feature feature : features) {
									if(feature.getName().equals(nameSyntaxParam)) featuresToInit.add(feature);
								}
							}	

							// Calling the multiple method
							Statement statement = statementBuilder.buildMultipleStatement(multipleStatement, modelElement, featuresToInit);

							apiAccessor.invokeStatement(result, statement);

							// We remove the initialized features from the general list
							features.removeAll(featuresToInit);
						}
					}
				}
			}

			// 2.2. The rest of features
			for(Feature feature : features) {
				Api2molLogger.getInstance().print("Feature: " + feature.getName() + "...");
				ModelElement section = syntaxHelper.locateSectionForFeature(feature, allMappings);

				if(feature.isPrimitive() && modelmanager.isBasicType(feature.getType())) {
					// It is primitive. 
					Api2molLogger.getInstance().print("Primitive type [" + feature.getType().get("name") +"]");
					extractPrimitiveFeature(result, modelElement, feature, section);	
				} else if(feature.isPrimitive() && !modelmanager.isBasicType(feature.getType())) {
					// It is a enumerated feature
					Api2molLogger.getInstance().print("Enum type [" + feature.getType().get("name") +"]");
				} else if(feature.isContainer()) {
					// It is a containment reference.
					Api2molLogger.getInstance().print("Container.");
					extractNonPrimitiveFeature(result, modelElement, feature, section);	
				} else if(!feature.isContainer() && !feature.isPrimitive()) {
					// It is a non-containment reference.
					Api2molLogger.getInstance().print("Reference.");
					extractNonPrimitiveFeature(result, modelElement, feature, section);	
				}
			}
		} else {
			// Mapping not located
			// 1.2. What can I do?
		}

		return result;
	}

	/**
	 * Extracs the value of a particular primitive feature to an instance object. 
	 * @param instance The instance object to which the feature value is going to be extracted
	 * @param modelElement The metaclass instance which contains the feature
	 * @param feature The feature to be extracted
	 * @param section The section which contains the statements
	 */
	private void extractPrimitiveFeature(Object instance, ModelElement modelElement, Feature feature, ModelElement section) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("self", instance);
		params.put("value", modelElement.get(feature.getName()));

		if(feature.getName().equals("visible")) {
			int a = 0; a++;
		}

		Statement[] statements = statementBuilder.buildStatements(feature, section, StatementBuilder.Mode.EXTRACT, params);

		for(Statement statement : statements) {
			if(statement != null) {
				apiAccessor.invokeStatement(instance, statement);
				Api2molLogger.getInstance().append(" invoking... " + statement.toString());
			} else {
				Api2molLogger.getInstance().append(" statement not located.");
			}
		}
	}

	/**
	 * Extracts the value of a non primitive feature to an instance object. 
	 * @param instance The instance object to which the feature value is going to be extracted
	 * @param modelElement The metaclass instance which contains the feature
	 * @param feature The feature to be extracted
	 * @param section The section which contains the statements
	 */
	private void extractNonPrimitiveFeature(Object instance, ModelElement modelElement, Feature feature, ModelElement section) {
		List<ModelElement> elements = new ArrayList<ModelElement>();

		if(feature.getName().equals("synchronizer")) {
			int a = 0; a++;
		}

		if(feature.isMultiValued()) {
			elements.addAll((List<ModelElement>) modelElement.get(feature.getName()));
		} else {
			ModelElement element = (ModelElement) modelElement.get(feature.getName());
			if(element != null) {
				elements.add(element);
			} else {
				Api2molLogger.getInstance().append("Empty.");
			}
		}		


		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("self", instance);
		if(elements.size() > 1) {
			Object extractedObjs[] = new Object[elements.size()];
			for(int i = 0; i < elements.size(); i++) {
				extractedObjs[i] = extract(elements.get(i));
			}
			params.put("value", extractedObjs);
		} else if(elements.size() == 1) {
			Object extractedObj = extract(elements.get(0));
			params.put("value", extractedObj);
		}

		Statement[] statements = statementBuilder.buildStatements(feature, section, StatementBuilder.Mode.EXTRACT, params);

		for(Statement statement : statements) {
			if(statement != null) {
				Api2molLogger.getInstance().append(" invoking... " + statement.toString());
				apiAccessor.invokeStatement(instance, statement);
			} else {
				Api2molLogger.getInstance().append(" statement not located.");
			}
		}

	}
}
