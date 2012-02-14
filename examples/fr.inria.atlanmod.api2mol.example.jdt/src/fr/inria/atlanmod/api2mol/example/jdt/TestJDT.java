package fr.inria.atlanmod.api2mol.example.jdt;

import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.equinox.app.IApplication;
import org.eclipse.equinox.app.IApplicationContext;
import org.eclipse.jdt.core.IJavaModel;
import org.eclipse.jdt.core.JavaCore;

import fr.inria.atlanmod.api2mol.AbstractTest;

public class TestJDT extends AbstractTest implements IApplication {

	private static String name = "JDT";

	// Output model
	public static String modelPath = "./model/Test-" + name + ".xmi";
	
	// Input mapping
	public static String api2molTransformationPath = "./transformation/" + name + "-API2MoL.ecore";

	// Input metamodel
	public static String metamodelPath = "./metamodel/" + name + ".ecore";

	@Override
	public Object start(IApplicationContext arg0) throws Exception {
		IJavaModel javaModel = JavaCore.create(ResourcesPlugin.getWorkspace().getRoot());
        launchInjector(api2molTransformationPath, metamodelPath, javaModel, modelPath);
		return null;
	}

	@Override
	public void stop() {
		// TODO Auto-generated method stub
		
	}
}
