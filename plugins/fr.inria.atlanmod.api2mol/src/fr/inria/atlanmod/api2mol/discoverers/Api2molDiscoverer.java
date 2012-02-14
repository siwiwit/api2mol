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
import org.eclipse.gmt.modisco.core.projectors.ProjectorActualParameter;
import org.eclipse.gmt.modisco.modelhandler.emf.EMFModelHandler;
import org.eclipse.gmt.modisco.modelhandler.emf.modeling.EMFModel;
import org.eclipse.gmt.modisco.modelhandler.emf.modeling.EMFReferenceModel;
import org.eclipse.gmt.modisco.modelhandler.emf.projectors.EMFExtractor;
import org.eclipse.gmt.modisco.modelhandler.emf.projectors.EMFInjector;

public abstract class Api2molDiscoverer {
	

	File saveModel(String prefix, String suffix, Model model) {
		File tempFile = createTempFile(prefix, suffix);

		// Saving the model
		Map<String, ProjectorActualParameter<?>> params = new HashMap<String, ProjectorActualParameter<?>>();
		params.put("URI", new ProjectorActualParameter<URI>(URI.createFileURI(tempFile.getAbsolutePath())));
		(new EMFModelHandler()).saveModel((EMFModel) model, EMFExtractor.getInstance(), params);

		return tempFile;
	}


	File createTempFile(String prefix, String suffix) {
		File tempFile = null;

		try {
			tempFile = File.createTempFile(prefix, suffix);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return tempFile;
	}

	Model loadModel(File file) {
		Map<String, ProjectorActualParameter<?>> params = new HashMap<String, ProjectorActualParameter<?>>();
		params.put("URI", new ProjectorActualParameter<URI>(URI.createFileURI(file.getAbsolutePath())));
		return (new EMFModelHandler()).loadModel(EMFReferenceModel.getMetametamodel(), EMFInjector.getInstance(), params);
	}
}
