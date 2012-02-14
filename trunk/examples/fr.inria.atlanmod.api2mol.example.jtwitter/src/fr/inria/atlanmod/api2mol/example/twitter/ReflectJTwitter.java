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

package fr.inria.atlanmod.api2mol.example.twitter;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import fr.inria.atlanmod.api2mol.AbstractTest;
import fr.inria.atlanmod.api2mol.AbstractTestReflect;


public class ReflectJTwitter extends AbstractTestReflect {
	public static String api2molTransformationPath = "../api2mol.concreteSyntax/model/api2molTransformation-reflect.ecore";
	public static String metamodelPath = "../api2mol/bootstrap/reflect.ecore";
	public static String modelPath = "./bootstrap/resultReflect-JTwitter.ecore.xmi";
	
	public static String modelConfigurationPath = "./bootstrap/discovererConfiguration-JTwitter.ecore.xmi";
	public static String apiMetamodelDiscoveredPath = "./metamodel/resultEcore-ATL-JTwitter.ecore";
	public static String api2molTransformationDiscoveredPath = "./transformation/resultApi2mol-ATL-JTwitter.ecore";
	
	public static void main(String[] args) {
		List<Object> api = jtwitterAPI();
		System.out.println("Total classes: " + api.size());
		
		launchReflectProcess(api, api2molTransformationPath, metamodelPath, modelPath, modelConfigurationPath, apiMetamodelDiscoveredPath, api2molTransformationDiscoveredPath);
	} 
	
	public static List<Object> jtwitterAPI() {
		File d1 = new File("api/com");
		List<Object> list1 = collectJavaClassesFromDisk(d1, "com."); 

		File d2 = new File("api/lgpl");
		List<Object> list2 = collectJavaClassesFromDisk(d2, "lgpl.");
		
		File d3 = new File("api/oauth");
		List<Object> list3 = collectJavaClassesFromDisk(d3, "oauth."); 
		
		File d4 = new File("api/org");
		List<Object> list4 = collectJavaClassesFromDisk(d4, "org."); 
		
		File d5 = new File("api/winterwell");
		List<Object> list5 = collectJavaClassesFromDisk(d5, "winterwell.");
		
		List<Object> finalList = new ArrayList<Object>();
		finalList.addAll(list1);
		finalList.addAll(list2);
		finalList.addAll(list3);
		finalList.addAll(list4);
		finalList.addAll(list5);
		
		return finalList;
	}
}

class MyClass {
	public List<AbstractTest> myGet(){ return null;};
}
