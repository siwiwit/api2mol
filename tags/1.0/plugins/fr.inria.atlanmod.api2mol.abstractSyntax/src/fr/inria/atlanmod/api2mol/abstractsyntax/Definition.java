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
 * A representation of the model object '<em><b>Definition</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link fr.inria.atlanmod.api2mol.abstractsyntax.Definition#getContext <em>Context</em>}</li>
 *   <li>{@link fr.inria.atlanmod.api2mol.abstractsyntax.Definition#getDefaultMetaclass <em>Default Metaclass</em>}</li>
 *   <li>{@link fr.inria.atlanmod.api2mol.abstractsyntax.Definition#getMappings <em>Mappings</em>}</li>
 * </ul>
 * </p>
 *
 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage#getDefinition()
 * @model
 * @generated
 */
public interface Definition extends EObject {
	/**
	 * Returns the value of the '<em><b>Context</b></em>' attribute list.
	 * The list contents are of type {@link java.lang.String}.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Context</em>' attribute list isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Context</em>' attribute list.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage#getDefinition_Context()
	 * @model
	 * @generated
	 */
	EList<String> getContext();

	/**
	 * Returns the value of the '<em><b>Default Metaclass</b></em>' containment reference.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Default Metaclass</em>' containment reference isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Default Metaclass</em>' containment reference.
	 * @see #setDefaultMetaclass(DefaultMetaclassSection)
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage#getDefinition_DefaultMetaclass()
	 * @model containment="true" required="true"
	 * @generated
	 */
	DefaultMetaclassSection getDefaultMetaclass();

	/**
	 * Sets the value of the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.Definition#getDefaultMetaclass <em>Default Metaclass</em>}' containment reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Default Metaclass</em>' containment reference.
	 * @see #getDefaultMetaclass()
	 * @generated
	 */
	void setDefaultMetaclass(DefaultMetaclassSection value);

	/**
	 * Returns the value of the '<em><b>Mappings</b></em>' containment reference list.
	 * The list contents are of type {@link fr.inria.atlanmod.api2mol.abstractsyntax.Mapping}.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Mappings</em>' containment reference list isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Mappings</em>' containment reference list.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage#getDefinition_Mappings()
	 * @model containment="true"
	 * @generated
	 */
	EList<Mapping> getMappings();

} // Definition
