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

package fr.inria.atlanmod.api2mol.abstractsyntax;


/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Value Section</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link fr.inria.atlanmod.api2mol.abstractsyntax.ValueSection#getMetaValue <em>Meta Value</em>}</li>
 *   <li>{@link fr.inria.atlanmod.api2mol.abstractsyntax.ValueSection#getInstanceValue <em>Instance Value</em>}</li>
 * </ul>
 * </p>
 *
 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage#getValueSection()
 * @model
 * @generated
 */
public interface ValueSection extends Section {
	/**
	 * Returns the value of the '<em><b>Meta Value</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Meta Value</em>' attribute isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Meta Value</em>' attribute.
	 * @see #setMetaValue(String)
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage#getValueSection_MetaValue()
	 * @model
	 * @generated
	 */
	String getMetaValue();

	/**
	 * Sets the value of the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.ValueSection#getMetaValue <em>Meta Value</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Meta Value</em>' attribute.
	 * @see #getMetaValue()
	 * @generated
	 */
	void setMetaValue(String value);

	/**
	 * Returns the value of the '<em><b>Instance Value</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Instance Value</em>' attribute isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Instance Value</em>' attribute.
	 * @see #setInstanceValue(String)
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage#getValueSection_InstanceValue()
	 * @model
	 * @generated
	 */
	String getInstanceValue();

	/**
	 * Sets the value of the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.ValueSection#getInstanceValue <em>Instance Value</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Instance Value</em>' attribute.
	 * @see #getInstanceValue()
	 * @generated
	 */
	void setInstanceValue(String value);

} // ValueSection
