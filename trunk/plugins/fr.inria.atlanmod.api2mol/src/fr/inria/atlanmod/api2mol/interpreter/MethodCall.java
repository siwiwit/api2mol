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

/**
 * This class is an auxiliar class to make easier the management of method calls
 * @author jlcanovas
 *
 */
public class MethodCall extends Statement {
	private Object[] args;
	
	// Atributtes associated to params in a methods Call
	private Object value;
	
	public MethodCall(String methodName) {
		this.name = methodName;
		this.args = null;
	}
	
	public MethodCall(String methodName, Object[] args) {
		this.name = methodName;
		this.args = args;
	}
	
	
	// Getters and setters
	public Object[] getArgs() {
		return args;
	}

	public void setArgs(Object[] args) {
		this.args = args;
	}
	
	public String toString() {
		String result =  "Method name: ["+ this.name + "] Params : ";
		return result;
	}
}
