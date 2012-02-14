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
import java.util.HashMap;
import java.util.Map;

import org.eclipse.emf.common.util.URI;
import org.eclipse.gmt.modisco.core.modeling.Model;
import org.eclipse.gmt.modisco.core.modeling.ReferenceModel;
import org.eclipse.gmt.modisco.core.projectors.ProjectorActualParameter;
import org.eclipse.gmt.modisco.modelhandler.emf.EMFModelHandler;
import org.eclipse.gmt.modisco.modelhandler.emf.modeling.EMFReferenceModel;
import org.eclipse.gmt.modisco.modelhandler.emf.projectors.EMFInjector;

/**
 * This class calls to ATL Java API to execute the transformation for discovering the 
 * API metamodel.
 * @author jlcanovas
 *
 */
public class ATLApiMetamodelDiscoverer extends ATLApi2molDiscoverer implements ApiMetamodelDiscoverer  {
	private final static String TRANSFORMATION_PATH = "./bootstrap/atl/apiMetamodelDiscoverer.asm";
	private final static String DEFAULT_CONFIGURATION_PATH = "./bootstrap/discovererConfiguration-Swing.ecore.xmi";
	
	private String configurationPath;

	public ATLApiMetamodelDiscoverer(String configurationPath) {
		this.configurationPath = configurationPath;
	}
	
	public ATLApiMetamodelDiscoverer() {
		this.configurationPath = DEFAULT_CONFIGURATION_PATH;
	}
	
	@Override
	public ReferenceModel discoverApiMetamodel(Model model) {
		return (ReferenceModel) executeDiscoverer(model, TRANSFORMATION_PATH, configurationPath);
	}

	public static void main(String[] args) {
		long startTime = System.currentTimeMillis();
		
		EMFModelHandler emh = new EMFModelHandler();

		Map<String, ProjectorActualParameter<?>> params = new HashMap<String, ProjectorActualParameter<?>>();
		params.put("URI", new ProjectorActualParameter<URI>(URI.createFileURI((new File("./bootstrap/reflect.ecore")).getAbsolutePath())));
		EMFReferenceModel rm = (EMFReferenceModel) emh.loadModel(EMFReferenceModel.getMetametamodel(), EMFInjector.getInstance(), params);

		Map<String, ProjectorActualParameter<?>> params2 = new HashMap<String, ProjectorActualParameter<?>>();
		params2.put("URI", new ProjectorActualParameter<URI>(URI.createFileURI((new File("./bootstrap/resultReflect.ecore").getAbsolutePath()))));

		Model model = emh.loadModel(rm, EMFInjector.getInstance(), params2);

		ATLApiMetamodelDiscoverer discoverer = new ATLApiMetamodelDiscoverer();
		discoverer.discoverApiMetamodel(model);
		
		long endTime = System.currentTimeMillis() - startTime;
		System.out.println(" (" + endTime + " milisecs)");
	}

}
