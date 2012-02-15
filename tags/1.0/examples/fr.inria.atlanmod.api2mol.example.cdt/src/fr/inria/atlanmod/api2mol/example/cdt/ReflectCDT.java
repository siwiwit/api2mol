/*******************************************************************************
 * Copyright (c) 2008, 2012
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/

package fr.inria.atlanmod.api2mol.example.cdt;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Field;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLClassLoader;
import org.eclipse.emf.common.util.URI;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import javax.swing.JFrame;
import javax.swing.JPanel;

import org.eclipse.cdt.internal.core.CContentTypes;
import org.eclipse.gmt.modisco.core.modeling.Model;
import org.eclipse.gmt.modisco.core.modeling.ReferenceModel;
import org.eclipse.gmt.modisco.core.projectors.ProjectorActualParameter;
import org.eclipse.gmt.modisco.modelhandler.emf.EMFModelHandler;
import org.eclipse.gmt.modisco.modelhandler.emf.modeling.EMFModel;
import org.eclipse.gmt.modisco.modelhandler.emf.projectors.EMFExtractor;

import fr.inria.atlanmod.api2mol.AbstractTestReflect;
import fr.inria.atlanmod.api2mol.discoverers.ATLApiMetamodelDiscoverer;
import fr.inria.atlanmod.api2mol.discoverers.ApiMetamodelDiscoverer;
import fr.inria.atlanmod.api2mol.interpreter.Api2molInjector;
import fr.inria.atlanmod.api2mol.interpreter.Api2molLauncher;



public class ReflectCDT extends AbstractTestReflect {

	public static String api2molTransformationPath = "../fr.inria.atlanmod.api2mol.concreteSyntax/model/api2molTransformation-reflect.ecore";
	public static String metamodelPath = "../fr.inria.atlanmod.api2mol/bootstrap/reflect.ecore";
	
	public static String modelPath = "./bootstrap/resultReflect-CDT.ecore.xmi";
	public static String modelConfigurationPath = "./bootstrap/discovererConfiguration-CDT.ecore.xmi";
	public static String apiMetamodelDiscoveredPath = "./metamodel/resultEcore-ATL-CDT.ecore";
	public static String api2molTransformationDiscoveredPath = "./transformation/resultApi2mol-ATL-CDT.ecore";
	
	
	public static void main(String args[]) throws Exception {
		
		List<Object> api = ClassLoaderHelper.getClasses("org.eclipse.cdt.core");
		System.out.println("Total classes: " + api.size());
		
		launchReflectProcess(api, api2molTransformationPath, metamodelPath, modelPath, modelConfigurationPath, apiMetamodelDiscoveredPath, api2molTransformationDiscoveredPath);
	} 
	
}
