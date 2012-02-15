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

import gts.rubytl.launching.core.configuration.Binding;
import gts.rubytl.launching.core.configuration.data.ModelConfigurationData;
import gts.rubytl.launching.core.configuration.data.TaskM2MConfigurationData;
import gts.rubytl.launching.core.launcher.RtlLauncher;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import org.eclipse.emf.common.util.URI;
import org.eclipse.gmt.modisco.core.modeling.Model;
import org.eclipse.gmt.modisco.core.modeling.ReferenceModel;
import org.eclipse.gmt.modisco.core.projectors.ProjectorActualParameter;
import org.eclipse.gmt.modisco.modelhandler.emf.EMFModelHandler;
import org.eclipse.gmt.modisco.modelhandler.emf.modeling.EMFReferenceModel;
import org.eclipse.gmt.modisco.modelhandler.emf.projectors.EMFInjector;

public class RubyTLDiscoverer extends Api2molDiscoverer implements Api2molTransformationDiscoverer, ApiMetamodelDiscoverer {
	final static String RUBY_PATH = "/usr/bin/ruby";
	final static String RUBYTL_PATH = "./rubytl-last/rubytl";
	final static String RUBYTL_TRANSFORMATION_PATH = "./bootstrap/rubytl/rubyTLDiscoverer.rb";
	
	final static String REFLECT_NAMESPACE = "Reflect";
	final static String REFLECT_NAMESPACE_URI = "http://modelum.es/atlandmod/reflect";
	final static String REFLECT_METAMODEL_PATH = "./bootstrap/reflect.ecore";	
	
	final static String ECORE_NAMESPACE = "Ecore";
	final static String ECORE_NAMESPACE_URI = "http://www.eclipse.org/emf/2002/Ecore";
	final static String ECORE_METAMODEL_PATH = "./bootstrap/Ecore.ecore";
	
	final static String API2MOL_NAMESPACE = "Api2mol";
	final static String API2MOL_NAMESPACE_URI = "http://modelum.es/atlanmod/api2mol";
	final static String API2MOL_METAMODEL_PATH = "../api2mol.abstractSyntax/model/api2mol.ecore";
	
	final static String CONF_NAMESPACE = "Configuration";
	final static String CONF_NAMESPACE_URI = "http://modelum.es/atlandmod/discovererConfiguration";
	final static String CONF_METAMODEL_PATH = "./bootstrap/discovererConfiguration.ecore";
	
	final static String CONF_MODEL_PATH = "./bootstrap/discovererConfiguration-Swing.ecore.xmi";
//	final static String CONF_MODEL_PATH = "./bootstrap/discovererConfiguration-JDT.ecore.xmi";
	
	private ReferenceModel apiMetamodelDiscovered = null;
	private Model api2molTransformationDiscovered = null;
	
	@Override
	public Model discoverApi2molTransformation(Model model) {
		if(api2molTransformationDiscovered == null) executeTransformation(model);
		return api2molTransformationDiscovered;
	}

	@Override
	public ReferenceModel discoverApiMetamodel(Model model) {
		if(apiMetamodelDiscovered == null) executeTransformation(model);
		return apiMetamodelDiscovered;
	}

	public void executeTransformation(Model model) {
		// Preparing the source 1
		Binding sourceBinding1 = new Binding();
		File sourceModel1 = saveModel("sourceModel1", ".ecore.xmi", model);
		sourceBinding1.addModel(sourceModel1.getAbsolutePath());
		File sourceMetamodel1 = new File(REFLECT_METAMODEL_PATH);
		sourceBinding1.addMetamodel(REFLECT_NAMESPACE, sourceMetamodel1.getAbsolutePath());
		
		// Preparing the source 2
		Binding sourceBinding2 = new Binding();
		sourceBinding2.addModel(CONF_MODEL_PATH);
		File sourceMetamodel2 = new File(CONF_METAMODEL_PATH);
		sourceBinding2.addMetamodel(CONF_NAMESPACE, sourceMetamodel2.getAbsolutePath());

		// Preparing the target 1 (api metamodel)
		Binding targetBinding1 = new Binding();
		File targetModel1 = createTempFile("target1", ".ecore");
		targetBinding1.addModel(targetModel1.getAbsolutePath());
		File targetMetamodel1 = new File(ECORE_METAMODEL_PATH);
		targetBinding1.addMetamodel(ECORE_NAMESPACE, ECORE_NAMESPACE_URI);
		
		// Preparing the target 2 (api2model model)
		Binding targetBinding2 = new Binding();
		File targetModel2 = createTempFile("target2", ".ecore");
		targetBinding2.addModel(targetModel2.getAbsolutePath());
		File targetMetamodel2 = new File(API2MOL_METAMODEL_PATH);
		targetBinding2.addMetamodel(API2MOL_NAMESPACE, targetMetamodel2.getAbsolutePath());
		
		// Preparing the transformation sources
		TaskM2MConfigurationData m2mData = new TaskM2MConfigurationData(RUBY_PATH, RUBYTL_PATH, "./", RUBYTL_TRANSFORMATION_PATH);
		m2mData.addSourceBinding(sourceBinding1);
		m2mData.addSourceBinding(sourceBinding2);
		m2mData.addTargetBinding(targetBinding1);
		m2mData.addTargetBinding(targetBinding2);

		// Preparing the URI mappings
		ModelConfigurationData modelData = new ModelConfigurationData();
		modelData.addURIMapping(REFLECT_NAMESPACE_URI, sourceMetamodel1.getAbsolutePath());
		modelData.addURIMapping(CONF_NAMESPACE_URI, sourceMetamodel2.getAbsolutePath());
		
		RtlLauncher launcher = new RtlLauncher(m2mData, modelData);
		launcher.execute("m2m");
		
		apiMetamodelDiscovered = (ReferenceModel) loadModel(targetModel1); 
		api2molTransformationDiscovered = (Model) loadModel(targetModel2);
	}	
	
	public static void main(String[] args) {
		long startTime = System.currentTimeMillis();
		System.out.println("\nDiscovering the API metamodel...");
		
		EMFModelHandler emh = new EMFModelHandler();

		Map<String, ProjectorActualParameter<?>> params = new HashMap<String, ProjectorActualParameter<?>>();
		params.put("URI", new ProjectorActualParameter<URI>(URI.createFileURI((new File("./bootstrap/reflect.ecore")).getAbsolutePath())));
		EMFReferenceModel rm = (EMFReferenceModel) emh.loadModel(EMFReferenceModel.getMetametamodel(), EMFInjector.getInstance(), params);

		Map<String, ProjectorActualParameter<?>> params2 = new HashMap<String, ProjectorActualParameter<?>>();
		params2.put("URI", new ProjectorActualParameter<URI>(URI.createFileURI((new File("./bootstrap/resultReflect.ecore").getAbsolutePath()))));

		Model model = emh.loadModel(rm, EMFInjector.getInstance(), params2);
		
		ApiMetamodelDiscoverer discoverer = new RubyTLDiscoverer();
		ReferenceModel rm2 = discoverer.discoverApiMetamodel(model);
		
		long endTime = System.currentTimeMillis() - startTime;
		System.out.println(" (" + endTime + " milisecs)");
	}
}
