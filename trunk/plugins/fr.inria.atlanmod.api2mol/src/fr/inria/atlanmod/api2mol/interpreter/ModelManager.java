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

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.eclipse.gmt.modisco.core.modeling.Feature;
import org.eclipse.gmt.modisco.core.modeling.Model;
import org.eclipse.gmt.modisco.core.modeling.ModelElement;
import org.eclipse.gmt.modisco.core.modeling.ReferenceModel;
import org.eclipse.gmt.modisco.core.modeling.ReferenceModelElement;
import org.eclipse.gmt.modisco.modelhandler.emf.EMFModelHandler;

/**
 * Main class that helps API2MoL to manage the injected/extracted models
 * 
 * @author <a href="mailto:jlcanovas@um.es">Javier Canovas</a>
 *
 */
public class ModelManager {
	private ReferenceModel metamodel;
	private String mainPackage;
	
	public ModelManager(ReferenceModel metamodel) {
		Api2molLogger.getInstance().print("ModelManager created");
		this.metamodel = metamodel;
		this.mainPackage = locateMainPackage(metamodel);
		Api2molLogger.getInstance().print("Main Package:" + this.mainPackage);
		Api2molLogger.getInstance().print("\n");
	}
	
	public Model createModel() {
		return (new EMFModelHandler()).createModel(metamodel);
	}
	
	
	/**
	 * Locates the main package of a metamodel.
	 * For now, it takes the first EPackage declaration.
	 * 
	 * @param metamodel The metamodel where the main package must be located
	 * @return The name of the main package
	 */
	private String locateMainPackage(ReferenceModel metamodel) {
		Set<? extends ModelElement> packages = metamodel.getModelElementsByKind(metamodel.getReferenceModel().getReferenceModelElementByName("ecore::EPackage"));
		if(packages.size() > 0) return (String) packages.iterator().next().get("name");
		else return null;
		
	}
	
	/**
	 * Converts the name of the metaclass in order to considerate the packages.
	 * For now, it is an adhoc value
	 * TODO: Generalize it!
	 * @param name
	 * @return
	 */
	public String digestClassname(String name) {
		return (mainPackage == null) ? name : mainPackage + "::" + name;
	}
	
	/**
	 * Indicates if the feature is Boolean
	 * @param feature
	 * @return
	 */
	public boolean isBoolean(Feature feature) {		
		ModelElement type = feature.getType();
		
		if(((String) type.get("name")).equals("EBoolean"))
			return true;
		
		return false;
	}
	
	/**
	 * Initializes a feature of a particular modelElement. It takes into account if the feature is
	 * multivaluated or not
	 * @param modelElement
	 * @param feature
	 * @param value
	 */
	public void initFeature(ModelElement modelElement, Feature feature, Object value) {
		
		if(feature.isMultiValued()) {
			modelElement.add(feature.getName(), value);
		} else {
			modelElement.set(feature.getName(), value);
		}
	}

	/**
	 * Checks if the ModelElement is a basic type
	 * @param type
	 * @return
	 */
	public boolean isBasicType(ModelElement type) {
		String name = (String)type.get("name");
		if(name.equals("EBoolean") || name.equals("EInt") || name.equals("EDouble") || name.equals("EString") || name.equals("EFloat") || name.equals("ELong"))
			return true;
		else if(name.equals("ZBoolean") || name.equals("ZInt") || name.equals("ZDouble") || name.equals("ZString") || name.equals("ZFloat") || name.equals("ZLong"))
			return true;
		else
			return false;
	}
	


	/**
	 * Obtain all the superclasses for a particular metaclass. 
	 * Returns a list of those ReferenceModelElement's which represent to the metaclasses. In such a list
	 * it is also contained the metaclass received. 
	 * @param metaclass The metaclass from which obtain the superclasses
	 * @return List of ReferenceModelElements which represents the metaclasses
	 */
	public List<ReferenceModelElement> locateAllSuperclasses(ReferenceModelElement metaclass) {
		List<ReferenceModelElement> typeClasses = new ArrayList<ReferenceModelElement>();
		typeClasses.add(metaclass);

		List<ReferenceModelElement> superclasses = (List<ReferenceModelElement>) metaclass.get("eSuperTypes");
		while(superclasses.size() != 0) {
			typeClasses.addAll(superclasses);
			List<ReferenceModelElement> temporalList = new ArrayList<ReferenceModelElement>();
			for(ReferenceModelElement superclass : superclasses) {
				List<ReferenceModelElement> auxSuperclasses =  (List<ReferenceModelElement>) superclass.get("eSuperTypes");
				for(ReferenceModelElement auxSuperClass : auxSuperclasses) {
					if(!temporalList.contains(auxSuperClass)) temporalList.add(auxSuperClass);
				}
			}
			superclasses = temporalList;
		}
		return typeClasses;
	}

}
