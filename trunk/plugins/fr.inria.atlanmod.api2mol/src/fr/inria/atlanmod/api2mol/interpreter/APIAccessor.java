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

import java.lang.reflect.Method;

/**
 * This class offers an interface to make the access to the API methods independant
 * 
 * @author <a href="mailto:jlcanovas@um.es">Javier Canovas</a>
 *
 */
public interface APIAccessor {
	
	/**
	 * Invokes a particular statement (method or public field, see hierarchy of Statement class) 
	 * @param obj The target of the invocation
	 * @param stmt The statement to be invoked
	 * @return The result of the invocation
	 */
	public Object invokeStatement(Object obj, Statement stmt);
	
	/**
	 * Invokes a java constructor 
	 * @param className Class name to be constructed
	 * @param params Parameters for the constructor
	 * @return The result of the construction
	 */
	public Object invokeConstructor(String className, Object[] params);
	
	/**
	 * Invokes the default constructor of the class whose name is className
	 * @param className The name of the class whose construcor will be executed
	 * @return The result of the construction
	 */
	public Object invokeDefaultConstructor(String className);
	
	/**
	 * Obtains the value for a enumeration value. 
	 * For now, the received string is parsed to locate the class and then the field
	 * which defines the enum value.
	 * @param instanceValue String which describes the enum value
	 * @return The enum value
	 */
	public Object locateEnumValue(String instanceValue);
	

	/**
	 * Locates a method by name (extracted from MethodCall object) in a Class
	 * @param c The class which contains the method
	 * @param methodCall The method to be found
	 * @return
	 */
	public Method locateMethod(Class c, MethodCall methodCall);
}
