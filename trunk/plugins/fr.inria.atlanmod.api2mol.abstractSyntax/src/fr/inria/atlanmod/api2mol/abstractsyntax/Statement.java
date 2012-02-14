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

import org.eclipse.emf.common.util.EList;

import org.eclipse.emf.ecore.EObject;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Statement</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link fr.inria.atlanmod.api2mol.abstractsyntax.Statement#getType <em>Type</em>}</li>
 *   <li>{@link fr.inria.atlanmod.api2mol.abstractsyntax.Statement#getVariables <em>Variables</em>}</li>
 *   <li>{@link fr.inria.atlanmod.api2mol.abstractsyntax.Statement#getCalls <em>Calls</em>}</li>
 * </ul>
 * </p>
 *
 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage#getStatement()
 * @model
 * @generated
 */
public interface Statement extends EObject {
	/**
	 * Returns the value of the '<em><b>Type</b></em>' attribute.
	 * The literals are from the enumeration {@link fr.inria.atlanmod.api2mol.abstractsyntax.StatementType}.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Type</em>' attribute isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Type</em>' attribute.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.StatementType
	 * @see #setType(StatementType)
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage#getStatement_Type()
	 * @model required="true"
	 * @generated
	 */
	StatementType getType();

	/**
	 * Sets the value of the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.Statement#getType <em>Type</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Type</em>' attribute.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.StatementType
	 * @see #getType()
	 * @generated
	 */
	void setType(StatementType value);

	/**
	 * Returns the value of the '<em><b>Variables</b></em>' attribute list.
	 * The list contents are of type {@link java.lang.String}.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Variables</em>' attribute list isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Variables</em>' attribute list.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage#getStatement_Variables()
	 * @model
	 * @generated
	 */
	EList<String> getVariables();

	/**
	 * Returns the value of the '<em><b>Calls</b></em>' containment reference list.
	 * The list contents are of type {@link fr.inria.atlanmod.api2mol.abstractsyntax.MethodCall}.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Calls</em>' containment reference list isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Calls</em>' containment reference list.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage#getStatement_Calls()
	 * @model containment="true"
	 * @generated
	 */
	EList<MethodCall> getCalls();

} // Statement
