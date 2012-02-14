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


package fr.inria.atlanmod.api2mol.example.swt;

import org.eclipse.gmt.modisco.core.modeling.Model;
import org.eclipse.swt.SWT;
import org.eclipse.swt.examples.controlexample.ControlExample;
import org.eclipse.swt.layout.FillLayout;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Shell;

import fr.inria.atlanmod.api2mol.AbstractTest;



public class TestSWT extends AbstractTest{
	public static String modelPath = "./model/resultSWT.ecore";
	public static String modelPath2 = "./model/resultSWT2.ecore";
	public static String api2molTransformationPath = "./transformation/resultApi2mol-ATL-SWT-edited.ecore";
	public static String metamodelPath = "./metamodel/resultEcore-ATL-SWT-edited.ecore";

	public static void main(String[] args) {
		// Creating the main Shell
//		Shell shell = createSWTApplication();  
		
		// 1.- Injection of a SWT application		
//		Model result1 = launchInjector(api2molTransformationPath, metamodelPath, shell, modelPath);
		Model result1 = loadModel(metamodelPath, modelPath);
		
		// 2.- Extraction of the injected application
		System.out.println("\nExtracting SWT Application...");
		Object[] extractedObjs = launchExtractor(api2molTransformationPath, metamodelPath, result1, "SWT::Shell", false);
		System.out.println("Elements extracted: " + extractedObjs.length);
		
		// 3.- Re-injection of the extracted application
		for(Object extractedObj : extractedObjs) {
			if (extractedObj instanceof Shell) {
				System.out.println("\nRe-injecting extracted SWT Application...");
				Shell extractedShell = (Shell) extractedObj;
				Model result2 = launchInjector(api2molTransformationPath, metamodelPath, extractedShell, modelPath2);
				
				extractedShell.open();
				Display display = extractedShell.getDisplay();
				while (! extractedShell.isDisposed()) {
					if (! display.readAndDispatch()) display.sleep();
				}
				display.dispose();
			}
		}

	}

	private static Shell createSWTApplication() {
		Display display = new Display();
		Shell shell = new Shell(display, SWT.SHELL_TRIM);
		shell.setLayout(new FillLayout());
		ControlExample instance = new ControlExample(shell);
		shell.setText("My SWT application");
		ControlExample.setShellSize(instance, shell);
		return shell;
	}


}
