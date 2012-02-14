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

import java.util.HashMap;
import java.util.Map;

import org.eclipse.emf.common.util.URI;
import org.eclipse.gmt.modisco.core.modeling.Model;
import org.eclipse.gmt.modisco.core.modeling.ReferenceModel;
import org.eclipse.gmt.modisco.core.projectors.ProjectorActualParameter;
import org.eclipse.gmt.modisco.modelhandler.emf.EMFModelHandler;
import org.eclipse.gmt.modisco.modelhandler.emf.modeling.EMFReferenceModel;
import org.eclipse.gmt.modisco.modelhandler.emf.projectors.EMFInjector;

import gts.modernization.launcher.Gra2MoLInterpreterLauncher;

/**
 * This class acts as a sort of facade for creating injectors and extractors
 * 
 * @author jlcanovas
 *
 */
public class Api2molLauncher {
	public static String GRA2MOL_TRANSFORMATION_PATH = "../api2mol.concreteSyntax/transformation/api2molInjector.g2m";
	public static String API2MOL_AS = "../api2mol.abstractSyntax/model/api2mol.ecore";
	public static String API2MOL_PACKAGE = "api2mol";
	public static String RESULT_PATH = "../api2mol.concreteSyntax/resultModel.ecore.xmi";
	public static String GRAMMAR_NAME = "api2mol";
	public static String GRAMMAR_MAIN_RULE = "mainRule";
	
	String mappingPath;
	Model mappingDef;
	
	public Api2molLauncher(String mappingPath) {
		this.mappingPath = mappingPath;
	}
	
	public Api2molLauncher(Model mappingDef) {
		this.mappingDef = mappingDef;
	}
	
	public static void main(String[] args) {
		Api2molLauncher launcher = new Api2molLauncher("./bootstrap/reflect.api2mol");
		launcher.loadConcreteSyntax("./bootstrap/reflect.api2mol");
	}
	
	/**
	 * Creates a new API2MoL injector for a certain metamodel
	 * @param metamodelPath The path to the metamodel
	 * @return
	 */
	public Api2molInjector createInjector(String metamodelPath) {
		ReferenceModel metamodel = loadMetamodel(metamodelPath);
		return createInjector(metamodel);
	}	
	
	/**
	 * Creates a new API2MoL injector for a certain metamodel
	 * @param metamodel The ReferenceModel
	 * @return
	 */
	public Api2molInjector createInjector(ReferenceModel metamodel) {
		// Obtaining the mapping from the concrete syntax if it does not exists
		if(mappingDef == null) {
			mappingDef = loadConcreteSyntax(mappingPath);
		}
		
		// Creating the injector
		Api2molInjector result = new Api2molInjector(metamodel, mappingDef);
		return result;
	}
	
	/**
	 * Creates a new API2MoL extractor for a certain model
	 * @return The API2MoL extractor
	 */
	public Api2molExtractor createExtractor(Model model) {
		Api2molExtractor result = new Api2molExtractor(model, mappingDef);
		return result;
	}
	
	private ReferenceModel loadMetamodel(String metamodelPath) {
		// Obtaining the ReferenceModel element 
		// We use the MoDisco infraestructure
		Map<String, ProjectorActualParameter<?>> params = new HashMap<String, ProjectorActualParameter<?>>();
		params.put("URI", new ProjectorActualParameter<URI>(URI.createFileURI(metamodelPath)));
		ReferenceModel metamodel = (ReferenceModel) (new EMFModelHandler()).loadModel(EMFReferenceModel.getMetametamodel(), EMFInjector.getInstance(), params);
		return metamodel;
	}

	/**
	 * Loads a new api2mol abstract syntax from a concrete syntax definition. This method uses Gra2MoL 
	 * for obtaining the instance of the abstract syntax so it must be configured with some path that are 
	 * defined as static strings. 
	 * @param path
	 * @return
	 */
	public Model loadConcreteSyntax(String path) {
		// Calling to Gra2MoL API
		Gra2MoLInterpreterLauncher launcher = new Gra2MoLInterpreterLauncher(
				GRA2MOL_TRANSFORMATION_PATH, 
				API2MOL_AS, 
				API2MOL_PACKAGE, 
				RESULT_PATH, 
				GRAMMAR_NAME, 
				GRAMMAR_MAIN_RULE,
				path);
		launcher.setCaseSensitive(true);
		Model result = launcher.launch();
		
		return result;
	}
}
