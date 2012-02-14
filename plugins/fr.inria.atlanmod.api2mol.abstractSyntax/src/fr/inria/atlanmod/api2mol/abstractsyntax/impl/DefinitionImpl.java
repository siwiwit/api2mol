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


import java.util.Collection;

import org.eclipse.emf.common.notify.Notification;
import org.eclipse.emf.common.notify.NotificationChain;

import org.eclipse.emf.common.util.EList;

import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.InternalEObject;

import org.eclipse.emf.ecore.impl.ENotificationImpl;
import org.eclipse.emf.ecore.impl.EObjectImpl;

import org.eclipse.emf.ecore.util.EDataTypeUniqueEList;
import org.eclipse.emf.ecore.util.EObjectContainmentEList;
import org.eclipse.emf.ecore.util.InternalEList;

import fr.inria.atlanmod.api2mol.abstractsyntax.Api2molPackage;
import fr.inria.atlanmod.api2mol.abstractsyntax.DefaultMetaclassSection;
import fr.inria.atlanmod.api2mol.abstractsyntax.Definition;
import fr.inria.atlanmod.api2mol.abstractsyntax.Mapping;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model object '<em><b>Definition</b></em>'.
 * <!-- end-user-doc -->
 * <p>
 * The following features are implemented:
 * <ul>
 *   <li>{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.DefinitionImpl#getContext <em>Context</em>}</li>
 *   <li>{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.DefinitionImpl#getDefaultMetaclass <em>Default Metaclass</em>}</li>
 *   <li>{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.DefinitionImpl#getMappings <em>Mappings</em>}</li>
 * </ul>
 * </p>
 *
 * @generated
 */
public class DefinitionImpl extends EObjectImpl implements Definition {
	/**
	 * The cached value of the '{@link #getContext() <em>Context</em>}' attribute list.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getContext()
	 * @generated
	 * @ordered
	 */
	protected EList<String> context;
	/**
	 * The cached value of the '{@link #getDefaultMetaclass() <em>Default Metaclass</em>}' containment reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getDefaultMetaclass()
	 * @generated
	 * @ordered
	 */
	protected DefaultMetaclassSection defaultMetaclass;
	/**
	 * The cached value of the '{@link #getMappings() <em>Mappings</em>}' containment reference list.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getMappings()
	 * @generated
	 * @ordered
	 */
	protected EList<Mapping> mappings;

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	protected DefinitionImpl() {
		super();
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	protected EClass eStaticClass() {
		return Api2molPackage.Literals.DEFINITION;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EList<String> getContext() {
		if (context == null) {
			context = new EDataTypeUniqueEList<String>(String.class, this, Api2molPackage.DEFINITION__CONTEXT);
		}
		return context;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public DefaultMetaclassSection getDefaultMetaclass() {
		return defaultMetaclass;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public NotificationChain basicSetDefaultMetaclass(DefaultMetaclassSection newDefaultMetaclass, NotificationChain msgs) {
		DefaultMetaclassSection oldDefaultMetaclass = defaultMetaclass;
		defaultMetaclass = newDefaultMetaclass;
		if (eNotificationRequired()) {
			ENotificationImpl notification = new ENotificationImpl(this, Notification.SET, Api2molPackage.DEFINITION__DEFAULT_METACLASS, oldDefaultMetaclass, newDefaultMetaclass);
			if (msgs == null) msgs = notification; else msgs.add(notification);
		}
		return msgs;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void setDefaultMetaclass(DefaultMetaclassSection newDefaultMetaclass) {
		if (newDefaultMetaclass != defaultMetaclass) {
			NotificationChain msgs = null;
			if (defaultMetaclass != null)
				msgs = ((InternalEObject)defaultMetaclass).eInverseRemove(this, EOPPOSITE_FEATURE_BASE - Api2molPackage.DEFINITION__DEFAULT_METACLASS, null, msgs);
			if (newDefaultMetaclass != null)
				msgs = ((InternalEObject)newDefaultMetaclass).eInverseAdd(this, EOPPOSITE_FEATURE_BASE - Api2molPackage.DEFINITION__DEFAULT_METACLASS, null, msgs);
			msgs = basicSetDefaultMetaclass(newDefaultMetaclass, msgs);
			if (msgs != null) msgs.dispatch();
		}
		else if (eNotificationRequired())
			eNotify(new ENotificationImpl(this, Notification.SET, Api2molPackage.DEFINITION__DEFAULT_METACLASS, newDefaultMetaclass, newDefaultMetaclass));
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EList<Mapping> getMappings() {
		if (mappings == null) {
			mappings = new EObjectContainmentEList<Mapping>(Mapping.class, this, Api2molPackage.DEFINITION__MAPPINGS);
		}
		return mappings;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public NotificationChain eInverseRemove(InternalEObject otherEnd, int featureID, NotificationChain msgs) {
		switch (featureID) {
			case Api2molPackage.DEFINITION__DEFAULT_METACLASS:
				return basicSetDefaultMetaclass(null, msgs);
			case Api2molPackage.DEFINITION__MAPPINGS:
				return ((InternalEList<?>)getMappings()).basicRemove(otherEnd, msgs);
		}
		return super.eInverseRemove(otherEnd, featureID, msgs);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public Object eGet(int featureID, boolean resolve, boolean coreType) {
		switch (featureID) {
			case Api2molPackage.DEFINITION__CONTEXT:
				return getContext();
			case Api2molPackage.DEFINITION__DEFAULT_METACLASS:
				return getDefaultMetaclass();
			case Api2molPackage.DEFINITION__MAPPINGS:
				return getMappings();
		}
		return super.eGet(featureID, resolve, coreType);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@SuppressWarnings("unchecked")
	@Override
	public void eSet(int featureID, Object newValue) {
		switch (featureID) {
			case Api2molPackage.DEFINITION__CONTEXT:
				getContext().clear();
				getContext().addAll((Collection<? extends String>)newValue);
				return;
			case Api2molPackage.DEFINITION__DEFAULT_METACLASS:
				setDefaultMetaclass((DefaultMetaclassSection)newValue);
				return;
			case Api2molPackage.DEFINITION__MAPPINGS:
				getMappings().clear();
				getMappings().addAll((Collection<? extends Mapping>)newValue);
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
			case Api2molPackage.DEFINITION__CONTEXT:
				getContext().clear();
				return;
			case Api2molPackage.DEFINITION__DEFAULT_METACLASS:
				setDefaultMetaclass((DefaultMetaclassSection)null);
				return;
			case Api2molPackage.DEFINITION__MAPPINGS:
				getMappings().clear();
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
			case Api2molPackage.DEFINITION__CONTEXT:
				return context != null && !context.isEmpty();
			case Api2molPackage.DEFINITION__DEFAULT_METACLASS:
				return defaultMetaclass != null;
			case Api2molPackage.DEFINITION__MAPPINGS:
				return mappings != null && !mappings.isEmpty();
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
		result.append(" (context: ");
		result.append(context);
		result.append(')');
		return result.toString();
	}

} //DefinitionImpl
