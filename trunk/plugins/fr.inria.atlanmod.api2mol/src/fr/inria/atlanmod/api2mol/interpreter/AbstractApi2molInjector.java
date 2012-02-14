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

import org.eclipse.gmt.modisco.core.modeling.Model;
import org.eclipse.gmt.modisco.core.modeling.ModelElement;
import org.eclipse.gmt.modisco.core.modeling.ReferenceModel;

public abstract class AbstractApi2molInjector extends Api2molProjector {
	public static boolean INFER_STATEMENTS = false;
	public static boolean INFER_METACLASS = false;

	ReferenceModel targetmetamodel;
	Model targetmodel;
	HashMap<Object, ModelElement> cachedModelElements;

	public AbstractApi2molInjector(ReferenceModel metamodel, Model mapping) {
		super(mapping, metamodel);
		Api2molLogger.getInstance().print("Api2MoL Injector");
		Api2molLogger.getInstance().createProcess(Api2molLogger.ProcessType.INJECT);
		this.targetmetamodel = metamodel;
		this.targetmodel = modelmanager.createModel();
		this.cachedModelElements = new HashMap<Object, ModelElement>(); 
	}

	/**
	 * Injects a model element from an object have instance deeply
	 * It checks if the Object has been injected previously
	 * @param obj The instance of the class to be injected
	 * @return
	 */
	public Model launch(Object obj) {
		return launch(obj, true);
	}
	/**
	 * Injects a model element from an object have instance
	 * If not deep then only properties which are primitive are converted
	 * It checks if the Object has been injected previously
	 * @param obj The instance of the class to be injected
	 * @param deep Specifies if the model must be traversed deeply
	 * @return
	 */
	public Model launch(Object obj, boolean deep) {
		if(obj.getClass().isArray()) {
			Object[] resultObjArray = (Object[]) obj;
			for(int i = 0; i < resultObjArray.length; i++) {
				inject(resultObjArray[i], deep);
			}
		} else {
			inject(obj, deep);
		}
		Api2molLogger.getInstance().saveModel();
		return targetmodel;
	}
	
	public ModelElement inject(Object obj, boolean deep) {
		Api2molLogger.getInstance().incDeep();
		Api2molLogger.getInstance().print("Injecting " + obj.getClass().getName() + " instance class... " + obj + " ");
		if(obj.getClass().getName().equals("javax.swing.JRootPane$AccessibleJRootPane")) {
			int a = 0; a++;
		}

		ModelElement result = null;
		ModelElement isCached = cachedModelElements.get(obj);
		if(isCached != null) {
			Api2molLogger.getInstance().createInjectionElement(obj.getClass().getName(), true);
			Api2molLogger.getInstance().append("cached! ");
			result = isCached;
		} else {
			Api2molLogger.getInstance().createInjectionElement(obj.getClass().getName(), false);
			ModelElement newInjection = injectNew(obj, deep);
			result = newInjection;
		}

		Api2molLogger.getInstance().decDeep();
		return result;
	}

	protected abstract ModelElement injectNew(Object obj, boolean deep);
}
