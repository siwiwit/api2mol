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

import org.eclipse.gmt.modisco.core.modeling.Model;
import org.eclipse.gmt.modisco.core.modeling.ReferenceModel;


public interface ApiMetamodelDiscoverer {

	/**
	 * The received model is analyzed to create a new metamodel which contains the concepts of
	 * the API. 
	 * 
	 * @param model The api model (reflective model)
	 * @return Metamodel inferred
	 */
	public ReferenceModel discoverApiMetamodel(Model model);
	
}
