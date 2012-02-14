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
 * This class is used to make easier the access to direct fields
 * 
 * @author <a href="mailto:jlcanovas@um.es">Javier Canovas</a>
 *
 */
public class PublicField extends Statement {
	public enum Action { GET, SET }
	
	private Object value;
	private Action action;
	
	public PublicField(String name) {
		super();
		this.name = name;
		this.action = Action.GET;
	}
	
	public PublicField(String name, Object value) {
		super();
		this.value = value;
		this.name = name;
		this.action = Action.SET;
	}
	
	public PublicField(String name, Object value, Action action) {
		super();
		this.value = value;
		this.name = name;
		this.action = action;
	}

	public Object getValue() {
		return value;
	}

	public void setValue(Object value) {
		this.value = value;
	}

	public Action getAction() {
		return action;
	}

	public void setAction(Action action) {
		this.action = action;
	}

}
