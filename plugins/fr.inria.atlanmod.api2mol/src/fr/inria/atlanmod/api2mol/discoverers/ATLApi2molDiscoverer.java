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

package fr.inria.atlanmod.api2mol.discoverers;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.Map;

import org.eclipse.core.runtime.NullProgressMonitor;
import org.eclipse.gmt.modisco.core.modeling.Model;
import org.eclipse.gmt.modisco.core.modeling.ReferenceModel;
import org.eclipse.m2m.atl.core.ATLCoreException;
import org.eclipse.m2m.atl.core.emf.EMFModelFactory;
import org.eclipse.m2m.atl.core.launch.ILauncher;
import org.eclipse.m2m.atl.engine.emfvm.ASM;
import org.eclipse.m2m.atl.engine.emfvm.ASMXMLReader;
import org.eclipse.m2m.atl.engine.emfvm.launch.EMFVMLauncher;

public abstract class ATLApi2molDiscoverer extends Api2molDiscoverer {
	private final static String BOOTSTRAP_PATH = "./bootstrap/";
	private final static String HELPERS_PATH = "./bootstrap/atl/api2molHelpers.asm";

	private org.eclipse.m2m.atl.core.emf.EMFInjector emfInjector = new org.eclipse.m2m.atl.core.emf.EMFInjector();
	
	Model executeDiscoverer(Model model, String transformationPath, String configurationPath) {
		// Temporal files 
		// The source and target models are serialized
		// (I am not very proud of this mechanism but I was not able to create an ATL EMF Model from MoDisco EMF Model)
		File inFilePath = saveModel("sourceModel", ".ecore.xmi", model);
		File outFilePath = createTempFile("target1", ".ecore");

		EMFModelFactory emfFactory = new EMFModelFactory(); 

		// Metamodels
		org.eclipse.m2m.atl.core.emf.EMFReferenceModel reflectMetamodel = (org.eclipse.m2m.atl.core.emf.EMFReferenceModel) emfFactory.newReferenceModel();
		org.eclipse.m2m.atl.core.emf.EMFReferenceModel ecoreMetamodel   = (org.eclipse.m2m.atl.core.emf.EMFReferenceModel) emfFactory.newReferenceModel();
		org.eclipse.m2m.atl.core.emf.EMFReferenceModel confMetamodel    = (org.eclipse.m2m.atl.core.emf.EMFReferenceModel) emfFactory.newReferenceModel();
		
		// Injecting the metamodels
		injectFromDisk(reflectMetamodel, BOOTSTRAP_PATH + "reflect.ecore");
		injectFromDisk(ecoreMetamodel,   BOOTSTRAP_PATH + "Ecore.ecore");
		injectFromDisk(confMetamodel,    BOOTSTRAP_PATH + "discovererConfiguration.ecore");

		// Models
		org.eclipse.m2m.atl.core.emf.EMFModel reflectModel = (org.eclipse.m2m.atl.core.emf.EMFModel) emfFactory.newModel(reflectMetamodel);
		org.eclipse.m2m.atl.core.emf.EMFModel confModel    = (org.eclipse.m2m.atl.core.emf.EMFModel) emfFactory.newModel(confMetamodel);
		org.eclipse.m2m.atl.core.emf.EMFModel targetModel  = (org.eclipse.m2m.atl.core.emf.EMFModel) emfFactory.newModel(ecoreMetamodel);
		
		// Loading input file
		injectFromDisk(reflectModel, BOOTSTRAP_PATH + "resultReflect.ecore.xmi");
		injectFromDisk(confModel, configurationPath); // TODO This does not work!!
		
		// TODO: This should work! But it doesn't!
		// We transform the model into a EMFModel to be able to access to the EMF Resource
		// EMFModel emfModel = (EMFModel) model;
		// emfInjector.inject(reflectModel, emfModel.getResource());

		// Loading the transformation and helpers definition
		ASM transformationDef = null;
		ASM helpersDef = null;
		try {
			transformationDef = new ASMXMLReader().read(new FileInputStream(transformationPath));
			helpersDef = new ASMXMLReader().read(new FileInputStream(HELPERS_PATH));
		} catch (FileNotFoundException e) {
			System.err.println("Error loading the the transformation / helpers in ATL Metamodel Discoverer");
			e.printStackTrace();
		}

		// Using EMF VM launcher
		EMFVMLauncher launcher = new EMFVMLauncher();
		Map<String, Object> options = new HashMap<String, Object>();
		options.put("showSummary", "true");
		options.put("printExecutionTime", "true");
		launcher.initialize(null);
		launcher.addInModel(reflectModel, "IN", "REFLECT");
		launcher.addInModel(confModel, "IN_CONF", "CONFIGURATION");
		launcher.addOutModel(targetModel, "OUT", "ECORE");
		launcher.addLibrary("api2molHelpers", helpersDef);
		Object transformationResult = launcher.launch(ILauncher.RUN_MODE, new NullProgressMonitor(), options, transformationDef);

		// Extracting to disk
		extractToDisk(targetModel, outFilePath.getAbsolutePath()); 
		
		// Inyecting the model by using the MoDisco infrastructure
		ReferenceModel result = (ReferenceModel) loadModel(outFilePath);
		return result;
	}
	
	/**
	 * Extract a model into a disk location
	 * @param targetModel The model to be extracted
	 * @param path The location where the model will be extracted
	 */
	void extractToDisk(org.eclipse.m2m.atl.core.emf.EMFModel targetModel, String path) {
		org.eclipse.m2m.atl.core.emf.EMFExtractor extractor = new org.eclipse.m2m.atl.core.emf.EMFExtractor();
		try {
			extractor.extract(targetModel, path);
		} catch (ATLCoreException e) {
			System.err.println("Error extracting the model in ATL Metamodel Discoverer");
			e.printStackTrace();
		}
	}

	/**
	 * Injects a model from a disk location
	 * @param sourceModel The source model to be injected
	 * @param path The location from which the model will be injeted
	 */
	void injectFromDisk(org.eclipse.m2m.atl.core.emf.EMFModel sourceModel, String path) {
		try {
			emfInjector.inject(sourceModel, new FileInputStream(path), null);
		} catch (FileNotFoundException e1) {
			System.err.println("Error in the injection path in ATL Metamodel Discoverer");
			e1.printStackTrace();
		} catch (ATLCoreException e1) {
			System.err.println("Error injecting the source model in ATL Metamodel Discoverer");
			e1.printStackTrace();
		}
	}
}
