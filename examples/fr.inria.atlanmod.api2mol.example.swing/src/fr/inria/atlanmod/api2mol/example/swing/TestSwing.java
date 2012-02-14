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


package fr.inria.atlanmod.api2mol.example.swing;

import java.awt.Color;
import java.awt.Component;
import java.awt.ComponentOrientation;
import java.awt.Container;
import java.awt.FlowLayout;
import java.util.HashMap;
import java.util.Map;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLayeredPane;
import javax.swing.JPanel;
import javax.swing.JRootPane;

import org.eclipse.emf.common.util.URI;
import org.eclipse.gmt.modisco.core.modeling.Model;
import org.eclipse.gmt.modisco.core.projectors.ProjectorActualParameter;
import org.eclipse.gmt.modisco.modelhandler.emf.EMFModelHandler;
import org.eclipse.gmt.modisco.modelhandler.emf.modeling.EMFModel;
import org.eclipse.gmt.modisco.modelhandler.emf.projectors.EMFExtractor;

import fr.inria.atlanmod.api2mol.AbstractTest;



public class TestSwing extends AbstractTest{
	public static String modelPath = "./model/resultSwing.ecore.xmi";
	public static String modelPath2 = "./model/resultSwing2.ecore.xmi";
	//	public static String api2molTransformationPath = "./transformation/resultApi2mol-ATL-Swing.ecore";
	public static String api2molTransformationPath = "./transformation/resultApi2mol-ATL-Swing-edited.ecore";
	//	public static String metamodelPath = "./metamodel/resultEcore-ATL-Swing.ecore";
	public static String metamodelPath = "./metamodel/resultEcore-ATL-Swing-edited.ecore";


	//	public static String api2molTransformationPath = "./bootstrap/rubytl/resultApi2mol-RubyTL.ecore";
	//	public static String metamodelPath = "./bootstrap/rubytl/resultEcore-RubyTL.ecore";
	public static void main(String args[]) {
		// Creating the main JFrame
		System.setProperty("com.apple.awt.CocoaComponent.CompatibilityMode","false");
		
		JFrame jframe = createSwingApp();
		jframe.setVisible(true);
		

		// 1.- Injection of a Swing application		
		Model result = launchInjector(api2molTransformationPath, metamodelPath, jframe, modelPath);
		
//		Model result = loadModel(metamodelPath, "./model/resultSwing.ecore");

		// 2.- Extraction of the injected application
		System.out.println("\nExtracting Swing Application...");
		Object[] extractedObj = launchExtractor(api2molTransformationPath, metamodelPath, result, "Swing::JFrame");

		System.out.println("Elements extracted: " + extractedObj.length);
		if(extractedObj.length > 0) {
			if (extractedObj[0] instanceof JFrame) {
				JFrame extractedJFrame = (JFrame) extractedObj[0];
				extractedJFrame.setTitle(extractedJFrame.getTitle() + " (Extracted)");			

				// 3.- Injection of the extracted application
				result = launchInjector(api2molTransformationPath, metamodelPath, extractedJFrame, modelPath2);
				Map<String, ProjectorActualParameter<?>> params2 = new HashMap<String, ProjectorActualParameter<?>>();
				params2.put("URI", new ProjectorActualParameter<URI>(URI.createFileURI(modelPath2)));
				(new EMFModelHandler()).saveModel((EMFModel) result, EMFExtractor.getInstance(), params2);
	
				
				// Fixing extracted model...
				JRootPane rootPane = (JRootPane) extractedJFrame.getComponent(0);
				JPanel jPanel = (JPanel) rootPane.getContentPane();
				for(Component component : rootPane.getComponents()) {
					if (component instanceof JLayeredPane) {
						JLayeredPane jLayered = (JLayeredPane) component;
						jLayered.add(jPanel);
					} 
				}

				System.out.println("Showing the original JFrame and the extracted JFrame");
				jframe.setVisible(true);
				extractedJFrame.setVisible(true);
			} else {
				System.err.println("No JFrame extracted");
			}
		}

	}

	public static void checkComponents(int deep, Container container) {
		for(Component component : container.getComponents()) {
			String tab = "";
			for(int i = 0; i < deep; i++) { tab += "  "; } 
			System.out.println(tab + "-> " + component.getClass().getName());
			component.setVisible(true);
			if(container instanceof Container) {
				checkComponents(deep++, (Container) component);
			}
		}
	}

	public static JFrame createSwingApp() {
		JFrame result = new JFrame();
		result.setBounds(150, 150, 250, 75);
		result.setTitle("My Test Application");		

		Container contentPane = result.getContentPane();
		contentPane.setLayout(new FlowLayout());

		JButton b1 = new JButton("Button One");
		JButton b2 = new JButton("Button Two");

		contentPane.add(b1);
		contentPane.add(b2);

		result.setAlwaysOnTop(true);
		result.setBackground(new Color(23));

		return result;
	}


}
