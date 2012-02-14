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

package fr.inria.atlanmod.api2mol.abstractsyntax.impl;


import org.eclipse.emf.common.notify.Notification;

import org.eclipse.emf.ecore.EClass;

import org.eclipse.emf.ecore.impl.ENotificationImpl;

import fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage;
import fr.inria.atlanmod.api2mol.abstractsyntax.ValueSection;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model object '<em><b>Value Section</b></em>'.
 * <!-- end-user-doc -->
 * <p>
 * The following features are implemented:
 * <ul>
 *   <li>{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.ValueSectionImpl#getMetaValue <em>Meta Value</em>}</li>
 *   <li>{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.ValueSectionImpl#getInstanceValue <em>Instance Value</em>}</li>
 * </ul>
 * </p>
 *
 * @generated
 */
public class ValueSectionImpl extends SectionImpl implements ValueSection {
	/**
	 * The default value of the '{@link #getMetaValue() <em>Meta Value</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getMetaValue()
	 * @generated
	 * @ordered
	 */
	protected static final String META_VALUE_EDEFAULT = null;

	/**
	 * The cached value of the '{@link #getMetaValue() <em>Meta Value</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getMetaValue()
	 * @generated
	 * @ordered
	 */
	protected String metaValue = META_VALUE_EDEFAULT;

	/**
	 * The default value of the '{@link #getInstanceValue() <em>Instance Value</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getInstanceValue()
	 * @generated
	 * @ordered
	 */
	protected static final String INSTANCE_VALUE_EDEFAULT = null;

	/**
	 * The cached value of the '{@link #getInstanceValue() <em>Instance Value</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getInstanceValue()
	 * @generated
	 * @ordered
	 */
	protected String instanceValue = INSTANCE_VALUE_EDEFAULT;

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	protected ValueSectionImpl() {
		super();
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	protected EClass eStaticClass() {
		return Api2molPackage.Literals.VALUE_SECTION;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public String getMetaValue() {
		return metaValue;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void setMetaValue(String newMetaValue) {
		String oldMetaValue = metaValue;
		metaValue = newMetaValue;
		if (eNotificationRequired())
			eNotify(new ENotificationImpl(this, Notification.SET, Api2molPackage.VALUE_SECTION__META_VALUE, oldMetaValue, metaValue));
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public String getInstanceValue() {
		return instanceValue;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void setInstanceValue(String newInstanceValue) {
		String oldInstanceValue = instanceValue;
		instanceValue = newInstanceValue;
		if (eNotificationRequired())
			eNotify(new ENotificationImpl(this, Notification.SET, Api2molPackage.VALUE_SECTION__INSTANCE_VALUE, oldInstanceValue, instanceValue));
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public Object eGet(int featureID, boolean resolve, boolean coreType) {
		switch (featureID) {
			case Api2molPackage.VALUE_SECTION__META_VALUE:
				return getMetaValue();
			case Api2molPackage.VALUE_SECTION__INSTANCE_VALUE:
				return getInstanceValue();
		}
		return super.eGet(featureID, resolve, coreType);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public void eSet(int featureID, Object newValue) {
		switch (featureID) {
			case Api2molPackage.VALUE_SECTION__META_VALUE:
				setMetaValue((String)newValue);
				return;
			case Api2molPackage.VALUE_SECTION__INSTANCE_VALUE:
				setInstanceValue((String)newValue);
				return;
		}
		super.eSet(featureID, newValue);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public void eUnset(int featureID) {
		switch (featureID) {
			case Api2molPackage.VALUE_SECTION__META_VALUE:
				setMetaValue(META_VALUE_EDEFAULT);
				return;
			case Api2molPackage.VALUE_SECTION__INSTANCE_VALUE:
				setInstanceValue(INSTANCE_VALUE_EDEFAULT);
				return;
		}
		super.eUnset(featureID);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public boolean eIsSet(int featureID) {
		switch (featureID) {
			case Api2molPackage.VALUE_SECTION__META_VALUE:
				return META_VALUE_EDEFAULT == null ? metaValue != null : !META_VALUE_EDEFAULT.equals(metaValue);
			case Api2molPackage.VALUE_SECTION__INSTANCE_VALUE:
				return INSTANCE_VALUE_EDEFAULT == null ? instanceValue != null : !INSTANCE_VALUE_EDEFAULT.equals(instanceValue);
		}
		return super.eIsSet(featureID);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public String toString() {
		if (eIsProxy()) return super.toString();

		StringBuffer result = new StringBuffer(super.toString());
		result.append(" (metaValue: ");
		result.append(metaValue);
		result.append(", instanceValue: ");
		result.append(instanceValue);
		result.append(')');
		return result.toString();
	}

} //ValueSectionImpl
