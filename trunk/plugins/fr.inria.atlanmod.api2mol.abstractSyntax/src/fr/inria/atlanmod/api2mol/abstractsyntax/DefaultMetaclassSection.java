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
 * A representation of the model object '<em><b>Default Metaclass Section</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link fr.inria.atlanmod.api2mol.abstractsyntax.DefaultMetaclassSection#getMetaclassName <em>Metaclass Name</em>}</li>
 *   <li>{@link fr.inria.atlanmod.api2mol.abstractsyntax.DefaultMetaclassSection#getAttribute <em>Attribute</em>}</li>
 * </ul>
 * </p>
 *
 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage#getDefaultMetaclassSection()
 * @model
 * @generated
 */
public interface DefaultMetaclassSection extends Section {
	/**
	 * Returns the value of the '<em><b>Metaclass Name</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Metaclass Name</em>' attribute isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Metaclass Name</em>' attribute.
	 * @see #setMetaclassName(String)
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage#getDefaultMetaclassSection_MetaclassName()
	 * @model
	 * @generated
	 */
	String getMetaclassName();

	/**
	 * Sets the value of the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.DefaultMetaclassSection#getMetaclassName <em>Metaclass Name</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Metaclass Name</em>' attribute.
	 * @see #getMetaclassName()
	 * @generated
	 */
	void setMetaclassName(String value);

	/**
	 * Returns the value of the '<em><b>Attribute</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Attribute</em>' attribute isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Attribute</em>' attribute.
	 * @see #setAttribute(String)
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage#getDefaultMetaclassSection_Attribute()
	 * @model
	 * @generated
	 */
	String getAttribute();

	/**
	 * Sets the value of the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.DefaultMetaclassSection#getAttribute <em>Attribute</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Attribute</em>' attribute.
	 * @see #getAttribute()
	 * @generated
	 */
	void setAttribute(String value);

} // DefaultMetaclassSection
