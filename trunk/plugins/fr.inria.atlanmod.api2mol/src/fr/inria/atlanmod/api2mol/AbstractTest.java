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

package fr.inria.atlanmod.api2mol;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;

import org.eclipse.emf.common.util.URI;
import org.eclipse.gmt.modisco.core.modeling.Model;
import org.eclipse.gmt.modisco.core.projectors.ProjectorActualParameter;
import org.eclipse.gmt.modisco.modelhandler.emf.EMFModelHandler;
import org.eclipse.gmt.modisco.modelhandler.emf.modeling.EMFModel;
import org.eclipse.gmt.modisco.modelhandler.emf.modeling.EMFReferenceModel;
import org.eclipse.gmt.modisco.modelhandler.emf.projectors.EMFExtractor;
import org.eclipse.gmt.modisco.modelhandler.emf.projectors.EMFInjector;

import fr.inria.atlanmod.api2mol.interpreter.Api2molExtractor;
import fr.inria.atlanmod.api2mol.interpreter.Api2molInjector;
import fr.inria.atlanmod.api2mol.interpreter.Api2molLauncher;



/**
 * This class encapsulates the logic which is necessary to create api2mol tests
 * 
 * @author <a href="mailto:jlcanovas@um.es">Javier Canovas</a>
 *
 */
public abstract class AbstractTest {
	public static String API2MOL_ABSTRACT_SYNTAX_METAMODEL = "../fr.inria.atlanmod.api2mol.abstractSyntax/model/api2mol.ecore";

	/**
	 * Loads an API2MoL abstract model
	 * @param file Path which containg the abstract model
	 * @return
	 */
	public static Model loadAbstractModel(File file) {
		return loadModel(API2MOL_ABSTRACT_SYNTAX_METAMODEL, file.getAbsolutePath());
	}
	
	/**
	 * This method encapsulates the statements that must be performed to launch an api2mol injector. The abstract syntax
	 * model must be provided. 
	 * @param api2molTransformationPath Path to the abstract syntax model
	 * @param metamodelPath Path to the target metamodel
	 * @param object Object to be injected
	 * @param resultInjectedModelPath Path where the injected model will be stored
	 * @return The injected model
	 */
	public static Model launchInjector(String api2molTransformationPath, String metamodelPath, Object object, String resultInjectedModelPath) {

		Model abstractModel = loadAbstractModel(new File(api2molTransformationPath));
		Api2molLauncher launcher = new Api2molLauncher(abstractModel);
		Api2molInjector injector = launcher.createInjector(metamodelPath);

		System.out.println("\nInjecting Application...");
		Model result = injector.launch(object, true);
		System.out.println("Resulting elements: " + result.getContents().size());

		Map<String, ProjectorActualParameter<?>> params = new HashMap<String, ProjectorActualParameter<?>>();
		params.put("URI", new ProjectorActualParameter<URI>(URI.createFileURI(resultInjectedModelPath)));
		(new EMFModelHandler()).saveModel((EMFModel) result, EMFExtractor.getInstance(), params);
		
		return result;
	}
	
	/**
	 * This method encapsulates the statements that must be performed to launch an api2mol extractor. The abstract syntax
	 * model must be provided. The statements must be inferred
	 * @param api2molTransformationPath Path to the abstract syntax model
	 * @param metamodelPath Path to the target metamodel 
	 * @param sourceModel Source model
	 * @param rootElement Root element of the model
	 * @return The set of extracted elements
	 */
	public static Object[] launchExtractor(String api2molTransformationPath, String metamodelPath, Model sourceModel, String rootElement) {
		return launchExtractor(api2molTransformationPath, metamodelPath, sourceModel, rootElement, true);
	}

	/**
	 * This method encapsulates the statements that must be performed to launch an api2mol extractor. The abstract syntax
	 * model must be provided
	 * @param api2molTransformationPath Path to the abstract syntax model
	 * @param metamodelPath Path to the target metamodel 
	 * @param sourceModel Source model
	 * @param rootElement Root element of the model
	 * @param inferStatements Inidicates if the statements must be inferred
	 * @return The set of extracted elements
	 */
	public static Object[] launchExtractor(String api2molTransformationPath, String metamodelPath, Model sourceModel, String rootElement, boolean inferStatements) {
		Model abstractModel = loadAbstractModel(new File(api2molTransformationPath));
		Api2molLauncher launcher = new Api2molLauncher(abstractModel);
		Api2molExtractor extractor = launcher.createExtractor(sourceModel);
		extractor.INFER_STATEMENTS = inferStatements;
		Object[] extractedObj = extractor.launch(rootElement);
		return extractedObj;
	}
	
	/**
	 * Loads a model conforming to a metamodel
	 * @param metamodelPath The metamodel path
	 * @param modelPath The model Path
	 * @return Loaded model (using old modisco infrastructure)
	 */
	public static Model loadModel(String metamodelPath, String modelPath) {
		EMFModelHandler emh = new EMFModelHandler();
		Map<String, ProjectorActualParameter<?>> params = new HashMap<String, ProjectorActualParameter<?>>();
		params.put("URI", new ProjectorActualParameter<URI>(URI.createFileURI((new File(metamodelPath)).getAbsolutePath())));
		EMFReferenceModel rm = (EMFReferenceModel) emh.loadModel(EMFReferenceModel.getMetametamodel(), EMFInjector.getInstance(), params);

		Map<String, ProjectorActualParameter<?>> params2 = new HashMap<String, ProjectorActualParameter<?>>();
		params2.put("URI", new ProjectorActualParameter<URI>(URI.createFileURI((new File(modelPath).getAbsolutePath()))));
		Model result = emh.loadModel(rm, EMFInjector.getInstance(), params2);
		return result;
	}
	
	/**
	 * Wait for an input from keyboard
	 */
	public static void waitForInput() {
		System.out.println("Push enter:");
		InputStreamReader isr = new InputStreamReader(System.in);
		BufferedReader br = new BufferedReader(isr);
		try {
			String pause = br.readLine();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
}
