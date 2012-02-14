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

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>New Section</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link fr.inria.atlanmod.api2mol.abstractsyntax.NewSection#getConstructors <em>Constructors</em>}</li>
 * </ul>
 * </p>
 *
 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage#getNewSection()
 * @model
 * @generated
 */
public interface NewSection extends Section {
	/**
	 * Returns the value of the '<em><b>Constructors</b></em>' containment reference list.
	 * The list contents are of type {@link fr.inria.atlanmod.api2mol.abstractsyntax.Constructor}.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Constructors</em>' containment reference list isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Constructors</em>' containment reference list.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage#getNewSection_Constructors()
	 * @model containment="true"
	 * @generated
	 */
	EList<Constructor> getConstructors();

} // NewSection
