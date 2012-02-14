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


package fr.inria.atlanmod.api2mol.example.swing;

import java.io.File;
import java.lang.reflect.Constructor;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.JFrame;
import javax.swing.JPanel;

import org.eclipse.emf.common.util.URI;
import org.eclipse.gmt.modisco.core.modeling.Model;
import org.eclipse.gmt.modisco.core.modeling.ReferenceModel;
import org.eclipse.gmt.modisco.core.projectors.ProjectorActualParameter;
import org.eclipse.gmt.modisco.modelhandler.emf.EMFModelHandler;
import org.eclipse.gmt.modisco.modelhandler.emf.modeling.EMFModel;
import org.eclipse.gmt.modisco.modelhandler.emf.projectors.EMFExtractor;

import fr.inria.atlanmod.api2mol.AbstractTest;
import fr.inria.atlanmod.api2mol.discoverers.ATLApi2molTransformationDiscoverer;
import fr.inria.atlanmod.api2mol.discoverers.ATLApiMetamodelDiscoverer;
import fr.inria.atlanmod.api2mol.discoverers.Api2molTransformationDiscoverer;
import fr.inria.atlanmod.api2mol.discoverers.ApiMetamodelDiscoverer;
import fr.inria.atlanmod.api2mol.interpreter.Api2molInjector;
import fr.inria.atlanmod.api2mol.interpreter.Api2molLauncher;


public class ReflectSwing extends AbstractTest {
	public static String metamodelPath = "../api2mol/bootstrap/reflect.ecore";
	public static String mappingPath = "../api2mol/bootstrap/reflect.api2mol";
	public static String api2molTransformationPath = "../api2mol.concreteSyntax/model/api2molTransformation-reflect.ecore";

	public static String modelPath = "./bootstrap/resultReflect-Swing.ecore.xmi";
	public static String apiMetamodelDiscoveredPath = "./metamodel/resultEcore-ATL-Swing.ecore";
	public static String api2molTransformationDiscoveredPath = "./transformation/resultApi2mol-ATL-Swing.ecore";
	public static String modelConfigurationPath = "./bootstrap/discovererConfiguration-Swing.ecore.xmi";

	public static void main(String[] args) {		
		long totalStartTime = System.currentTimeMillis();

		// Pause for connecting the JMX console :)
		//		waitForInput();

		List<Object> api = swingAPI();
		System.out.println("Total classes: " + api.size());

		checkAPI(api);

//		if(true) return;

		// Phase 1: Injecting the Reflect Model by using API2MoL
		long startTime = System.currentTimeMillis();
		//		Api2molLauncher launcher = new Api2molLauncher(mappingPath);
		Model abstractModel = loadAbstractModel(new File(api2molTransformationPath));
		Api2molLauncher launcher = new Api2molLauncher(abstractModel);

		Api2molInjector injector = launcher.createInjector(metamodelPath);
		System.out.println("\nInjecting Reflect API...");
		injector.INFER_METACLASS = true;
		injector.INFER_STATEMENTS = true;
		Object[] toInject = new Object[] { JFrame.class, JPanel.class};
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

		// Phase 2a: Discovering the API metamodel
		startTime = System.currentTimeMillis();
		System.out.println("\nDiscovering the API metamodel...");
		// ApiMetamodelDiscoverer discoverer = new RubyTLDiscoverer();
		ApiMetamodelDiscoverer discoverer = new ATLApiMetamodelDiscoverer(modelConfigurationPath); 
		ReferenceModel rm = discoverer.discoverApiMetamodel(result);
		endTime = System.currentTimeMillis() - startTime;
		System.out.println(" (" + endTime + " milisecs)");

		startTime = System.currentTimeMillis();
		System.out.println("\nSaving the discovered metamodel...");
		Map<String, ProjectorActualParameter<?>> params2 = new HashMap<String, ProjectorActualParameter<?>>();
		params2.put("URI", new ProjectorActualParameter<URI>(URI.createFileURI(apiMetamodelDiscoveredPath)));
		(new EMFModelHandler()).saveModel((EMFModel) rm, EMFExtractor.getInstance(), params2);
		endTime = System.currentTimeMillis() - startTime;
		System.out.println(" (" + endTime + " milisecs)");

		// Phase 2b: Discovering the API2MoL transformation definition
		startTime = System.currentTimeMillis();
		System.out.println("\nDiscovering the Api2mol transformation...");
		// Model api2molTransformation = ((Api2molTransformationDiscoverer) discoverer).discoverApi2molTransformation(result);
		Api2molTransformationDiscoverer api2molDiscoverer = new ATLApi2molTransformationDiscoverer(modelConfigurationPath);
		Model api2molTransformation = api2molDiscoverer.discoverApi2molTransformation(result);
		endTime = System.currentTimeMillis() - startTime;
		System.out.println(" (" + endTime + " milisecs)");

		startTime = System.currentTimeMillis();
		System.out.println("\nSaving the discovered transformation...");
		Map<String, ProjectorActualParameter<?>> params3 = new HashMap<String, ProjectorActualParameter<?>>();
		params3.put("URI", new ProjectorActualParameter<URI>(URI.createFileURI(api2molTransformationDiscoveredPath)));
		(new EMFModelHandler()).saveModel((EMFModel) api2molTransformation, EMFExtractor.getInstance(), params3);
		endTime = System.currentTimeMillis() - startTime;
		System.out.println(" (" + endTime + " milisecs)");

		long totalEndTime = System.currentTimeMillis() - totalStartTime;
		System.out.println("\nTotal " + totalEndTime + " milisecs");
	}

	public static List<Object> swingAPI() {
		File swingDirectory = new File("../../../jdk1.6/Desktop/j2se/src/share/classes/javax/swing");
		return collectJavaClassesFromDisk(swingDirectory, "javax.swing."); 
	}

	private static List<Object> collectJavaClassesFromDisk(File path, String packageName) {
		ArrayList<Object> result = new ArrayList<Object>();

		File[] files = path.listFiles();
		for(int i = 0; i < files.length; i++) {
			if(files[i].getName().indexOf(".") > 0 && files[i].getName().endsWith(".java")) {
				String filename = files[i].getName().substring(0, files[i].getName().indexOf("."));
				if(!filename.equals("GREVersionRange")) {
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
	
	private static void checkAPI(List<Object> api) {
		int num = 0;
		for(Object obj : api) {
			int zero = 0;
			int many = 0;

			List<Constructor> constructors = new ArrayList<Constructor>();

			Class objClass = (Class) obj;
			for(Constructor constructor : objClass.getDeclaredConstructors()){
				constructors.add(constructor);

			}

			for(Constructor constructor : objClass.getConstructors()){
				if(!constructors.contains(constructor)) 
					constructors.add(constructor);
			}


			for(Constructor constructor : constructors){
				if(constructor.getParameterTypes().length > 0) {	
					many++;
					break;
				} else if(constructor.getParameterTypes().length == 0) {	
					zero++;
					break;
				}
			}

			if(zero == 0 && many > 0) num++;
			System.out.println(((zero == 0 && many > 0)? "*" : "") + ((Class) obj).getName() + " zero:" + zero + " many:" + many);
		}
		
		System.out.println("-->" + num);
	}
}
