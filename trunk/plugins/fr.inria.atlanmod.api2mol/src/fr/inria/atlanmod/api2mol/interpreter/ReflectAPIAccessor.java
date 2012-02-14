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

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

/**
 * This class offers the access to the API by using the Java Reflect API
 * 
 * @author <a href="mailto:jlcanovas@um.es">Javier Canovas</a>
 *
 */
public class ReflectAPIAccessor implements APIAccessor {
	
	/* (non-Javadoc)
	 * @see api2mol.interpreter.APIAccess#invokeStatement(java.lang.Object, api2mol.interpreter.Statement)
	 */
	public Object invokeStatement(Object obj, Statement statement) {
		if (statement instanceof MethodCall) {
			MethodCall methodCall = (MethodCall) statement;
			return invokeMethod(obj, methodCall);
		} else if (statement instanceof PublicField) {
			PublicField publicField = (PublicField) statement;
			return invokePublicField(obj, publicField);
		} else {
			return null;
		}
	}

	/**
	 * Invokes a java method reflectively
	 * @param obj
	 * @param methodName
	 * @return
	 */
	private Object invokeMethod(Object obj, MethodCall methodCall) {
		Object result = null;
		try {
			Class c = obj.getClass();
			Method method = locateMethod(c, methodCall);
			if(method == null) {
				System.err.println("Method " + methodCall.getName() + " not found!");
				return null;
			}

			if(method.isAccessible()) {
				result = method.invoke(obj, methodCall.getArgs());
			} else {
				// In case the method is private
				method.setAccessible(true);
				result = method.invoke(obj, methodCall.getArgs());
				method.setAccessible(false);
			}
			return result;
		} catch (Exception e) {
			Api2molLogger.getInstance().print("Error calling " + methodCall.getName() + " method of class " + obj.getClass().getName() + "\n");
			e.printStackTrace();
		}
		return result;
	}

	private Object invokePublicField(Object obj, PublicField publicField) {
		Object result = null;
		try {
			Class c = obj.getClass();
			Field field = locateField(c, publicField);
			if(field == null) {
				System.err.println("Field " + field.getName() + " not found in class " + c.getName());
				return null;
			}

			if(field.isAccessible()) {
				switch(publicField.getAction()) {
				case GET:
					result = field.get(obj);
					break;
				case SET:
					field.set(obj, publicField.getValue());
					break;
				}
			} else {
				// In case the field is private
				field.setAccessible(true);
				switch(publicField.getAction()) {
				case GET:
					result = field.get(obj);
					break;
				case SET:
					field.set(obj, publicField.getValue());
					break;
				}
				field.setAccessible(false);
			}
			return result;

		} catch (Exception e) {
			Api2molLogger.getInstance().print("Error accessing " + publicField.getName() + " field of class " + obj.getClass().getName()+ "\n");
			e.printStackTrace();
		}
		return result;
	}

	/* (non-Javadoc)
	 * @see api2mol.interpreter.APIAccess#invokeConstructor(java.lang.String, java.lang.Object[])
	 */
	public Object invokeConstructor(String className, Object[] params) {
		Class obj = null;
		try {
			obj = Class.forName(className);
		} catch (ClassNotFoundException e) {
			System.err.println("Problem creating class for " + className);
		}

		Constructor constructor = locateConstructor(obj, params);
		if(constructor != null) 
			return invokeConstructor(constructor, params);
		else
			return null;
	}

	/* (non-Javadoc)
	 * @see api2mol.interpreter.APIAccess#invokeDefaultConstructor(java.lang.String)
	 */
	public Object invokeDefaultConstructor(String className) {
		Constructor defaultConstructor = locateDefaultConstructor(className);
		if (defaultConstructor != null) 
			return invokeConstructor(defaultConstructor, null);
		else 
			return null;
	}

	/**
	 * Invoke a Constructor with the params specified
	 * @param constructor Constructor to be executed
	 * @param params Params for the constructor
	 * @return The created object
	 */
	private Object invokeConstructor(Constructor constructor, Object[] params) {
		Object result = null;
		try {
			if(constructor == null) {
				System.err.println("Constructor " + constructor.getName() + " not found!");
				return null;
			}

			if(constructor.isAccessible()) {
				result = constructor.newInstance(params);
			} else {
				// In case the method is private
				constructor.setAccessible(true);
				result = constructor.newInstance(params);
				constructor.setAccessible(false);
			}
			return result;
		} catch (Exception e) {
			Api2molLogger.getInstance().print("Error calling " + constructor.getName() + " constructor"+ "\n");
			e.printStackTrace();
//			System.exit(1);
		}
		return result;
	}

	/**
	 * Locates a method by name (extracted from MethodCall object) in a Class
	 * @param c The class which contains the method
	 * @param methodCall The method to be found
	 * @return
	 */
	public Method locateMethod(Class c, MethodCall methodCall) {
		// Public methods
		Method result = locateMethod(c.getMethods(), methodCall);
		if(result != null) 	
			return result;

		// Private methods
		result = locateMethod(c.getDeclaredMethods(), methodCall);
		if(result != null) 	
			return result;

		return null;
	}

	/**
	 * Locates a constructor by name (extracted from MethodCall object) in a Class
	 * @param c The class which contains the method
	 * @param params Params for the constructor to be located
	 * @return
	 */
	private Constructor locateConstructor(Class c, Object[] params) {
		// Public methods
		Constructor result = locateConstructor(c.getConstructors(), params);
		if(result != null) 	
			return result; 

		// Private methods
		result = locateConstructor(c.getDeclaredConstructors(), params);
		if(result != null) 	
			return result;

		return null;
	}

	/**
	 * Locates a field by name (extracted from PublicField object) in a Class
	 * @param c The class which contains the method
	 * @param publicField The field to be found
	 * @return
	 */
	private Field locateField(Class c, PublicField publicField) {
		// Public fields
		Field result = locateField(c.getFields(), publicField);
		if(result != null) 	
			return result;

		// Private fields
		result = locateField(c.getDeclaredFields(), publicField);
		if(result != null) 	
			return result;

		return null;
	}

	/**
	 * Locates a Method by name (extracted from MethodCall class) in a Method array
	 * @param methods Array of Methods to use in the search
	 * @param methodCall The method to be found
	 * @return
	 */
	private Method locateMethod(Method[] methods, MethodCall methodCall) {
		for(int i = 0; i < methods.length; i++) {
			Method m = methods[i];
			String mName = m.getName();
			// First, we check the name of the method
			if(mName.equals(methodCall.getName())) {
				Class[] params = m.getParameterTypes();
				// Then, we check the params. 
				if(params.length == ((methodCall.getArgs() == null) ? 0 : methodCall.getArgs().length)) {
					// The method has the same number of params
					if(methodCall.getArgs() != null) {
						// Checking the type of the params
						boolean correctParams = true;
						for(int j = 0; j < params.length; j++) {
							Class locatedParam = params[j];
							if(methodCall.getArgs()[j] != null) {
								Class existentParam = methodCall.getArgs()[j].getClass();
								if((locatedParam.isInstance(existentParam)) && //((locatedParam != existentParam) && 
										!((locatedParam.getName().equals("boolean")) && (existentParam.getName().equals("java.lang.Boolean"))) &&
										!((locatedParam.getName().equals("int")) && (existentParam.getName().equals("java.lang.Integer")))  &&
										!((locatedParam.getName().equals("float")) && (existentParam.getName().equals("java.lang.Float"))) &&
										!((locatedParam.getName().equals("double")) && (existentParam.getName().equals("java.lang.Double"))) 
								) {
									correctParams = false; // the type is not the same
								}
							}
						}
						if(correctParams) return m; // Only when all the params has the same type
					} else {
						return m; 
					}
				}
			}
		}
		return null;
	}

	/**
	 * Locates a Constructor by name (extracted from MethodCall class) in a Constructor array
	 * @param methods Array of Constructor to use in the search
	 * @param methodCall The method to be found
	 * @return
	 */
	private Constructor locateConstructor(Constructor[] constructors, Object[] inputParams) {
		for(int i = 0; i < constructors.length; i++) {
			Constructor c = constructors[i];
			Class[] params = c.getParameterTypes();
			// Then, we check the params. 
			if(params.length == ((inputParams== null) ? 0 : inputParams.length)) {
				// The method has the same number of params
				if(inputParams != null) {
					// Checking the type of the params
					boolean correctParams = true;
					for(int j = 0; j < params.length; j++) {
						Class locatedParam = params[j];
						Object existentParam = inputParams[j];						
						if((!locatedParam.isInstance(existentParam)) && 
								!((locatedParam.getName().equals("boolean")) && (existentParam.getClass().getName().equals("java.lang.Boolean"))) &&
								!((locatedParam.getName().equals("int")) && (existentParam.getClass().getName().equals("java.lang.Integer")))  &&
								!((locatedParam.getName().equals("float")) && (existentParam.getClass().getName().equals("java.lang.Float"))) &&
								!((locatedParam.getName().equals("double")) && (existentParam.getClass().getName().equals("java.lang.Double"))) 
						) {
							correctParams = false; // the type is not the same
						} 
					}
					if(correctParams) return c; // Only when all the params has the same type
				} else {
					return c; 
				}
			}
		}
		return null;
	}

	/**
	 * Locates a Field by name (extracted from PublicField class) in a Field array
	 * @param methods Array of Field to use in the search
	 * @param publicField The field to be found
	 * @return
	 */
	private Field locateField(Field[] fields, PublicField publicField) {
		for(int i = 0; i < fields.length; i++) {
			Field f = fields[i];
			if(f.getName().equals(publicField.getName())) 
				return f;
		}
		return null;
	}

	/**
	 * Obtain all the superclasses for a particular one
	 * @param obj
	 * @return
	 */
	private List<Class> locateSuperclasses(Object obj) {
		Class actualClass = obj.getClass();
		Class superclass = actualClass.getSuperclass();

		List<Class> result = new ArrayList<Class>();

		while(superclass != Object.class) {
			result.add(superclass);
			superclass = superclass.getSuperclass();
		}

		return result;
	}

	/**
	 * Look for the default constructor of the class whose instance name is className. 
	 * The located constructor must not have parameters
	 * @param obj 
	 * @return
	 */
	private Constructor locateDefaultConstructor(String className) {
		Class obj = null;
		try {
			obj = Class.forName(className);
		} catch (ClassNotFoundException e) {
			System.err.println("Problem creating class for " + className);
		}

		if (obj != null) {
			Constructor[] constructors = obj.getDeclaredConstructors(); 
			for(Constructor constructor : constructors) {
				if(constructor.getGenericParameterTypes().length == 0) {
					return constructor;
				}
			}

			constructors = obj.getConstructors();
			for(Constructor constructor : constructors) {
				if(constructor.getGenericParameterTypes().length == 0) {
					return constructor;
				}
			}
		}

		return null;
	}

	private Constructor locateConstructor(String className, String name) {
		Class obj = null;
		try {
			obj = Class.forName(className);
		} catch (ClassNotFoundException e) {
			System.err.println("Problem creating class for " + className);
		}

		if (obj != null) {
			Constructor[] constructors = obj.getDeclaredConstructors(); 
			for(Constructor constructor : constructors) {
				if(constructor.getName().equals(name)) {
					return constructor;
				}
			}

			constructors = obj.getConstructors();
			for(Constructor constructor : constructors) {
				if(constructor.getName().equals(name)) {
					return constructor;
				}
			}
		}

		return null;


	}

	/* (non-Javadoc)
	 * @see api2mol.interpreter.APIAccess#locateEnumValue(java.lang.String)
	 */
	public Object locateEnumValue(String instanceValue) {
		String className = instanceValue.substring(0, instanceValue.lastIndexOf("."));
		String valueName = instanceValue.substring(instanceValue.lastIndexOf(".")+1, instanceValue.length());
		try {
			Class c = Class.forName(className);
			Field field = c.getField(valueName);
			return field.get(field);
		} catch(Exception e) {
			System.err.print("Error instantiating " + className);
		}
		return null;
	}
}
