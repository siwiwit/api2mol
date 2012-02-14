package fr.inria.atlanmod.api2mol.example.jdt;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.eclipse.jdt.core.IJavaModel;

import fr.inria.atlanmod.api2mol.AbstractTestReflect;

public class ReflectJDT extends AbstractTestReflect {

	// Input from API2MoL framework
	public static String api2molTransformationPath = "../fr.inria.atlanmod.api2mol.concreteSyntax/model/api2molTransformation-reflect.ecore";
	public static String metamodelPath = "../fr.inria.atlanmod.api2mol/bootstrap/reflect.ecore";

	// Note: file names are of the form
	//	- Domain-Metamodel.xmi for terminal models
	//	- Domain.ecore for metamodels

	private static String name = "JDT";

	// Output: reflect model of LinkedIn API
	public static String modelPath = "./bootstrap/" + name + "-Reflect.xmi";

	// Input: configuration (filter)
	public static String modelConfigurationPath = "./bootstrap/" + name + "-discovererConfiguration.xmi";

	// Output: LinkedIn metamodel
	public static String apiMetamodelDiscoveredPath = "./metamodel/" + name + ".ecore";

	// Output: LinkedIn metamodel-API mapping
	public static String api2molTransformationDiscoveredPath = "./transformation/" + name + "-API2MoL.xmi";

	public static void main(String[] args) {
		long start = System.currentTimeMillis();
//		Collection<Class> classes = new HashSet<Class>();
		List<Class> classes = new ArrayList<Class>();
		addClass(classes, IJavaModel.class);
		System.out.println((System.currentTimeMillis() - start) / 1000. + "s");
//		List<Class> classes2 = new ArrayList<Class>(classes);
		List<Class> classes2 = classes;
		Collections.sort(classes2, new Comparator<Object>() {
			@Override
			public int compare(Object arg0, Object arg1) {
				return arg0.toString().compareTo(arg1.toString());
			}
			
		});
		System.out.println((System.currentTimeMillis() - start) / 1000. + "s");
		for(Class c : classes2) {
			System.out.println(c);
		}
		System.out.println(classes2.size());
		List<Object> api = new ArrayList<Object>();
		for(Class c : classes) {
			// TODO: use filter from discovererConfig?
			// Anyway, maybe not so much of an optimization considering
			// that API2MoL apparently injects referenced classes completely
			// (i.e., including their methods)
			if(c.getName().startsWith("org.eclipse.jdt.core"))
				api.add(c);
		}
		System.out.println(api.size());
		System.out.println((System.currentTimeMillis() - start) / 1000. + "s");
		launchReflectProcess(api, api2molTransformationPath, metamodelPath, modelPath, modelConfigurationPath, apiMetamodelDiscoveredPath, api2molTransformationDiscoveredPath);
	}

	private static void addClass(Collection<Class> classes, Class c) {
		if(classes.contains(c))
			return;
		classes.add(c);
		for(Method m : c.getMethods()) {
			addClass(classes, m.getReturnType());
		}
	}
}
