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

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.eclipse.emf.common.util.URI;
import org.eclipse.gmt.modisco.core.modeling.Model;
import org.eclipse.gmt.modisco.core.projectors.ProjectorActualParameter;
import org.eclipse.gmt.modisco.modelhandler.emf.EMFModelHandler;
import org.eclipse.gmt.modisco.modelhandler.emf.modeling.EMFModel;
import org.eclipse.gmt.modisco.modelhandler.emf.projectors.EMFExtractor;

import fr.inria.atlanmod.api2mol.interpreter.Api2molInjector;
import fr.inria.atlanmod.api2mol.interpreter.Api2molLauncher;


public abstract class AbstractTestReflect extends AbstractTest { 
	
	public static void launchReflectProcess(List<Object> api, String api2molTransformationPath, String metamodelPath, String modelPath, String modelConfigurationPath, String apiMetamodelDiscoveredPath, String api2molTransformationDiscoveredPath) {

		long totalStartTime = System.currentTimeMillis();
		
		// Phase 1: Injecting the Reflect Model by using API2MoL
		long startTime = System.currentTimeMillis();
		//		Api2molLauncher launcher = new Api2molLauncher(mappingPath);
		Model abstractModel = loadAbstractModel(new File(api2molTransformationPath));
		Api2molLauncher launcher = new Api2molLauncher(abstractModel);

		Api2molInjector injector = launcher.createInjector(metamodelPath);
		System.out.println("\nInjecting Reflect API...");
		injector.INFER_METACLASS = true;
		injector.INFER_STATEMENTS = true;
		Model result = injector.launch(api.toArray(), true);
		long endTime = System.currentTimeMillis() - startTime;
		System.out.println(" (" + endTime + " milisecs)");

		startTime = System.currentTimeMillis();
		System.out.println("\nSaving the reflect model...");
		Map<String, ProjectorActualParameter<?>> params = new HashMap<String, ProjectorActualParameter<?>>();
		params.put("URI", new ProjectorActualParameter<URI>(URI.createFileURI(modelPath)));
		(new EMFModelHandler()).saveModel((EMFModel) result, EMFExtractor.getInstance(), params);
		endTime = System.currentTimeMillis() - startTime;
		System.out.println(" (" + endTime + " milisecs)");
		
//		// Phase 2a: Discovering the API metamodel
//		startTime = System.currentTimeMillis();
//		System.out.println("\nDiscovering the API metamodel...");
//		// ApiMetamodelDiscoverer discoverer = new RubyTLDiscoverer();
//		ApiMetamodelDiscoverer discoverer = new ATLApiMetamodelDiscoverer(modelConfigurationPath); 
//		ReferenceModel rm = discoverer.discoverApiMetamodel(result);
//		endTime = System.currentTimeMillis() - startTime;
//		System.out.println(" (" + endTime + " milisecs)");
//
//		startTime = System.currentTimeMillis();
//		System.out.println("\nSaving the discovered metamodel...");
//		Map<String, ProjectorActualParameter<?>> params2 = new HashMap<String, ProjectorActualParameter<?>>();
//		params2.put("URI", new ProjectorActualParameter<URI>(URI.createFileURI(apiMetamodelDiscoveredPath)));
//		(new EMFModelHandler()).saveModel((EMFModel) rm, EMFExtractor.getInstance(), params2);
//		endTime = System.currentTimeMillis() - startTime;
//		System.out.println(" (" + endTime + " milisecs)");
//
//		// Phase 2b: Discovering the API2MoL transformation definition
//		startTime = System.currentTimeMillis();
//		System.out.println("\nDiscovering the Api2mol transformation...");
//		// Model api2molTransformation = ((Api2molTransformationDiscoverer) discoverer).discoverApi2molTransformation(result);
//		Api2molTransformationDiscoverer api2molDiscoverer = new ATLApi2molTransformationDiscoverer(modelConfigurationPath);
//		Model api2molTransformation = api2molDiscoverer.discoverApi2molTransformation(result);
//		endTime = System.currentTimeMillis() - startTime;
//		System.out.println(" (" + endTime + " milisecs)");
//
//		startTime = System.currentTimeMillis();
//		System.out.println("\nSaving the discovered transformation...");
//		Map<String, ProjectorActualParameter<?>> params3 = new HashMap<String, ProjectorActualParameter<?>>();
//		params3.put("URI", new ProjectorActualParameter<URI>(URI.createFileURI(api2molTransformationDiscoveredPath)));
//		(new EMFModelHandler()).saveModel((EMFModel) api2molTransformation, EMFExtractor.getInstance(), params3);
//		endTime = System.currentTimeMillis() - startTime;
//		System.out.println(" (" + endTime + " milisecs)");
		
		long totalEndTime = System.currentTimeMillis() - totalStartTime;
		System.out.println("\nTotal " + totalEndTime + " milisecs");
	}
	
	protected static List<Object> collectJavaClassesFromDisk(File path, String packageName) {
		ArrayList<Object> result = new ArrayList<Object>();

		File[] files = path.listFiles();
		for(int i = 0; i < files.length; i++) {
			if(files[i].getName().indexOf(".") > 0 && files[i].getName().endsWith(".java")) {
				String filename = files[i].getName().substring(0, files[i].getName().indexOf("."));
				if(!filename.equals("GREVersionRange")) { // I'm not very proud of this...
					try { 
						Class c = Class.forName(packageName + filename);
						result.add(c);
					} catch(Exception e) {
						System.err.println("Error in class: " + filename);
					}
				}
			} else if(files[i].isDirectory()) {
				result.addAll(collectJavaClassesFromDisk(files[i], packageName + files[i].getName() + "."));
			} 
		}
		return result;
	}
}
