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

import org.eclipse.gmt.modisco.core.modeling.Model;
import org.eclipse.gmt.modisco.core.modeling.ReferenceModel;


/**
 * This class serves as root of the hierarchy of injector/extractor. Any shared functionality
 * must be implemented here.
 * 
 * @author jlcanovas
 *
 */
public abstract class Api2molProjector {
	public static String VERSION = "0.1";

	ReferenceModel api2molMetamodel;
	SyntaxHelper syntaxHelper;
	ModelManager modelmanager;
	StatementBuilder statementBuilder;
	APIAccessor apiAccessor;

	public Api2molProjector(Model mapping, ReferenceModel metamodel) {
		Api2molLogger.getInstance();
		this.api2molMetamodel = mapping.getReferenceModel();
		this.modelmanager = new ModelManager(metamodel);
		this.syntaxHelper = new SyntaxHelper(mapping, this.modelmanager);
		this.statementBuilder = new StatementBuilder(syntaxHelper, modelmanager);
		this.apiAccessor = new ReflectAPIAccessor();
	}
}

