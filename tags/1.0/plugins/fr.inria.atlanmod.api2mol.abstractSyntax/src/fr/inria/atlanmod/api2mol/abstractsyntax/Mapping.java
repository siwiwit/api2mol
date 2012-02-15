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
 * A representation of the model object '<em><b>Mapping</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link fr.inria.atlanmod.api2mol.abstractsyntax.Mapping#getMetaclass <em>Metaclass</em>}</li>
 *   <li>{@link fr.inria.atlanmod.api2mol.abstractsyntax.Mapping#getInstanceClass <em>Instance Class</em>}</li>
 *   <li>{@link fr.inria.atlanmod.api2mol.abstractsyntax.Mapping#getSections <em>Sections</em>}</li>
 * </ul>
 * </p>
 *
 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage#getMapping()
 * @model
 * @generated
 */
public interface Mapping extends EObject {
	/**
	 * Returns the value of the '<em><b>Metaclass</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Metaclass</em>' attribute isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Metaclass</em>' attribute.
	 * @see #setMetaclass(String)
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage#getMapping_Metaclass()
	 * @model required="true"
	 * @generated
	 */
	String getMetaclass();

	/**
	 * Sets the value of the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.Mapping#getMetaclass <em>Metaclass</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Metaclass</em>' attribute.
	 * @see #getMetaclass()
	 * @generated
	 */
	void setMetaclass(String value);

	/**
	 * Returns the value of the '<em><b>Instance Class</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Instance Class</em>' attribute isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Instance Class</em>' attribute.
	 * @see #setInstanceClass(String)
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage#getMapping_InstanceClass()
	 * @model required="true"
	 * @generated
	 */
	String getInstanceClass();

	/**
	 * Sets the value of the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.Mapping#getInstanceClass <em>Instance Class</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Instance Class</em>' attribute.
	 * @see #getInstanceClass()
	 * @generated
	 */
	void setInstanceClass(String value);

	/**
	 * Returns the value of the '<em><b>Sections</b></em>' containment reference list.
	 * The list contents are of type {@link fr.inria.atlanmod.api2mol.abstractsyntax.Section}.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Sections</em>' containment reference list isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Sections</em>' containment reference list.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage#getMapping_Sections()
	 * @model containment="true"
	 * @generated
	 */
	EList<Section> getSections();

} // Mapping
