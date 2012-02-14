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
import java.util.Collection;
import java.util.HashMap;
import java.util.List;

import org.eclipse.gmt.modisco.core.modeling.Feature;
import org.eclipse.gmt.modisco.core.modeling.ModelElement;

public class StatementBuilder {
	public enum Mode { INJECT, EXTRACT }

	public static final String DEFAULT_APPEND_METHOD = "add";

	private SyntaxHelper syntaxHelper;
	private ModelManager modelManager;

	public StatementBuilder(SyntaxHelper syntaxHelper, ModelManager modelManager) {
		this.syntaxHelper = syntaxHelper;
		this.modelManager = modelManager;
	}

	/**
	 * Builds the corresponding set of statement to inject/extract information to/from ametaclass
	 * @param feature Feature of the metaclass to be projected
	 * @param section Section which defines the behavior for such a feature
	 * @param mode Injection or Extraction
	 * @param params Params used in the projection
	 * @return
	 */
	public Statement[] buildStatements(Feature feature, ModelElement section, Mode mode, HashMap<String, Object> params) {	
		List<Statement> result = new ArrayList<Statement>();

		String methodName = null; 
		Object[] args = null;
		ModelElement statement = null;
		ModelElement methodCall = null;

		if(section != null) {
			// If a property section is found, we try to locate the statement
			Api2molLogger.getInstance().print("Section located. Locating statement...");

			switch(mode) {
			case INJECT:
				if((statement = syntaxHelper.locateStatement(section, "GET")) != null) {
					// The GET statement exists
					List<ModelElement> calls = (List<ModelElement>) statement.get("calls");
					if(calls.size() > 0) {
						// The GET statement specifies a name for the method
						methodCall = calls.get(0); // TODO: This just deals with one call!!
						methodName = (String) methodCall.get("name");

						List<ModelElement> syntaxParams = (List<ModelElement>) methodCall.get("params");
						args = new Object[syntaxParams.size()];
						for(int i = 0; i < syntaxParams.size(); i++) {
							ModelElement param = syntaxParams.get(i);
							String paramName = (String) param.get("name");
							if(paramName.equals("self")) {
								args[i] = params.get("self");
							} 
						}
					} else {
						// There is no name for the GET method, using the default
						methodName = generateGetter(feature, (String) section.get("property"));
					}
					result.add(new MethodCall(methodName, args));
				} else if((statement = syntaxHelper.locateStatement(section, "ACCESSORS")) != null) {
					methodName = generateGetter(feature, (String) section.get("property"));
					result.add(new MethodCall(methodName, args));
				} else if((statement = syntaxHelper.locateStatement(section, "DIRECT")) != null) {
					result.add(new PublicField(feature.getName()));
				}
				break;
			case EXTRACT:
				if((statement = syntaxHelper.locateStatement(section, "SET")) != null) {
					List<ModelElement> calls = (List<ModelElement>) statement.get("calls");
					if(calls.size() > 0) {
						methodCall = calls.get(0); 
						methodName = (String) methodCall.get("name");

						List<ModelElement> syntaxParams = (List<ModelElement>) methodCall.get("params");
						args = new Object[syntaxParams.size()];
						for(int i = 0; i < syntaxParams.size(); i++) {
							ModelElement param = syntaxParams.get(i);
							String paramName = (String) param.get("name");
							args[i] = params.get(paramName);
						}
					} else {
						// There is no name for the SET method, using the default
						methodName = generateSetter((String) section.get("property"));
						args = new Object[1];
						args[0] = params.get("value");;
					}
					result.add(new MethodCall(methodName, args));
				} else if((statement = syntaxHelper.locateStatement(section, "ACCESSORS")) != null) {
					methodName = generateSetter((String) section.get("property"));
					args = new Object[1];
					args[0] = params.get("value");
					result.add(new MethodCall(methodName, args));
				} else if(((statement = syntaxHelper.locateStatement(section, "APPEND")) != null) && (params.get("value") != null)) {
					// TODO: Factorize the following code!
					List<ModelElement> calls = (List<ModelElement>) statement.get("calls");
					if(calls.size() > 0) {
						methodCall = calls.get(0); 
						methodName = (String) methodCall.get("name");

						List<ModelElement> syntaxParams = (List<ModelElement>) methodCall.get("params");

						// building the list of objects to append
						List<Object> toAppend = new ArrayList<Object>();
						if(params.get("value").getClass().isArray()) {
							Object[] values = (Object[]) params.get("value");
							for(Object value : values) 
								toAppend.add(value);
						} else {
							toAppend.add(params.get("value"));
						}
						
						// Building the append statements
						for(Object value : toAppend) {
							args = new Object[syntaxParams.size()];
							params.put("value", value);
							for(int i = 0; i < syntaxParams.size(); i++) {
								ModelElement param = syntaxParams.get(i);
								String paramName = (String) param.get("name");
								args[i] = params.get(paramName);
							}
							result.add(new MethodCall(methodName, args));
						}
					} else {
						// There is no name for the APPEND method, using the default
						methodName = DEFAULT_APPEND_METHOD;
						
						// building the list of objects to append
						List<Object> toAppend = new ArrayList<Object>();
						if(params.get("value").getClass().isArray()) {
							Object[] values = (Object[]) params.get("value");
							for(Object value : values) 
								toAppend.add(value);
						} else {
							toAppend.add(params.get("value"));
						}
						
						for(Object value : toAppend) {
							args = new Object[1];
							args[0] = value;
							result.add(new MethodCall(methodName, args));
						}
					}
				} else if((statement = syntaxHelper.locateStatement(section, "DIRECT")) != null) {
					result.add(new PublicField(feature.getName(), params.get("value")));
				}
				break;
			}
		} 

		if(statement == null && Api2molExtractor.INFER_STATEMENTS) {
			// If there is no statement, we try to infer the statement
			Api2molLogger.getInstance().print("Inferring statement... ");

			switch(mode) {
			case INJECT:
				result.add(new MethodCall(generateGetter(feature, feature.getName())));
				break;
			case EXTRACT:
				result.add(new MethodCall(generateSetter(feature.getName()), new Object[] { params.get("value") }));
				break;
			}
		}
		return result.toArray(new Statement[] {});
	}

	public Statement buildMultipleStatement(ModelElement statement, ModelElement modelElement, Collection<? extends Feature> features) {
		MethodCall result = null;
		ModelElement methodCall = null;
		String methodName = null;
		Object[] args = null;

		List<ModelElement> calls = (List<ModelElement>) statement.get("calls");
		if(calls.size() > 0) { // TODO: Dealing wit more than one statement
			methodCall = calls.get(0); 
			methodName = (String) methodCall.get("name");

			List<ModelElement> syntaxParams = (List<ModelElement>) methodCall.get("params");
			args = new Object[syntaxParams.size()];
			for(int i = 0; i < syntaxParams.size(); i++) {
				ModelElement param = syntaxParams.get(i);
				String paramName = (String) param.get("name");

				for(Feature feature : features) {
					if(feature.getName().equals(paramName)) {
						args[i] = modelElement.get(feature.getName());
						break;
					}
				}

			}
			result = new MethodCall(methodName, args);
		}
		return result;
	}

	/**
	 * Generates the default GET
	 * @param feature The feature from which the type is inferred
	 * @param property The property from which the name is generated
	 * @return The name of the default GET
	 */
	private String generateGetter(Feature feature, String property) {
		String prefix = (modelManager.isBoolean(feature)) ? "is" : "get";
		return prefix + property.substring(0, 1).toUpperCase() + property.substring(1, property.length());

	}

	/**
	 * Generates the deafult SET
	 * @param property The name of the property
	 * @return The name of the default SET
	 */
	private String generateSetter(String property) {
		return "set" + property.substring(0, 1).toUpperCase() + property.substring(1, property.length());
	}

}
