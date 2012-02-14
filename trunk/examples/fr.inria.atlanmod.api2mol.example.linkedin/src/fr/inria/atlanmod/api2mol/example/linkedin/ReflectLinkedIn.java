/*******************************************************************************
 * Copyright (c) 2008, 2012
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *    Javier Canovas (javier.canovas@inria.fr) 
 *    Fabian Somda 
 *******************************************************************************/

package fr.inria.atlanmod.api2mol.example.linkedin;

import java.io.File;
import java.util.List;

import fr.inria.atlanmod.api2mol.AbstractTestReflect;


public class ReflectLinkedIn extends AbstractTestReflect {
	// Input from API2MoL framework
	public static String api2molTransformationPath = "../api2mol.concreteSyntax/model/api2molTransformation-reflect.ecore";
	public static String metamodelPath = "../api2mol/bootstrap/reflect.ecore";

	// Note: file names are of the form
	//	- Domain-Metamodel.xmi for terminal models
	//	- Domain.ecore for metamodels

	// Output: reflect model of LinkedIn API
	public static String modelPath = "./bootstrap/LinkedIn-Reflect.xmi";

	// Input: configuration (filter)
	public static String modelConfigurationPath = "./bootstrap/LinkedIn-discovererConfiguration.xmi";

	// Output: LinkedIn metamodel
	public static String apiMetamodelDiscoveredPath = "./metamodel/LinkedIn.ecore";

	// Output: LinkedIn metamodel-API mapping
	public static String api2molTransformationDiscoveredPath = "./transformation/LinkedIn-API2MoL.xmi";

	public static void main(String args[]) {
		File d1 = new File("api/com");
		List<Object> api = collectJavaClassesFromDisk(d1, "com."); 
		System.out.println("Total classes: " + api.size());
		
		launchReflectProcess(api, api2molTransformationPath, metamodelPath, modelPath, modelConfigurationPath, apiMetamodelDiscoveredPath, api2molTransformationDiscoveredPath);
	}
}
