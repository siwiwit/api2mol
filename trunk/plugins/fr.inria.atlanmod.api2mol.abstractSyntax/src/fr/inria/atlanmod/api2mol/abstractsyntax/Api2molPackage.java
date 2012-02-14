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

import org.eclipse.emf.ecore.EAttribute;
import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.EEnum;
import org.eclipse.emf.ecore.EPackage;
import org.eclipse.emf.ecore.EReference;

/**
 * <!-- begin-user-doc -->
 * The <b>Package</b> for the model.
 * It contains accessors for the meta objects to represent
 * <ul>
 *   <li>each class,</li>
 *   <li>each feature of each class,</li>
 *   <li>each enum,</li>
 *   <li>and each data type</li>
 * </ul>
 * <!-- end-user-doc -->
 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Api2molFactory
 * @model kind="package"
 * @generated
 */
public interface Api2molPackage extends EPackage {
	/**
	 * The package name.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	String eNAME = "api2mol";

	/**
	 * The package namespace URI.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	String eNS_URI = "http://modelum.es/atlanmod/api2mol";

	/**
	 * The package namespace name.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	String eNS_PREFIX = "api2mol";

	/**
	 * The singleton instance of the package.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	Api2molPackage eINSTANCE = fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl.init();

	/**
	 * The meta object id for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.DefinitionImpl <em>Definition</em>}' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.DefinitionImpl
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getDefinition()
	 * @generated
	 */
	int DEFINITION = 0;

	/**
	 * The feature id for the '<em><b>Context</b></em>' attribute list.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int DEFINITION__CONTEXT = 0;

	/**
	 * The feature id for the '<em><b>Default Metaclass</b></em>' containment reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int DEFINITION__DEFAULT_METACLASS = 1;

	/**
	 * The feature id for the '<em><b>Mappings</b></em>' containment reference list.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int DEFINITION__MAPPINGS = 2;

	/**
	 * The number of structural features of the '<em>Definition</em>' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int DEFINITION_FEATURE_COUNT = 3;

	/**
	 * The meta object id for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.MappingImpl <em>Mapping</em>}' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.MappingImpl
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getMapping()
	 * @generated
	 */
	int MAPPING = 2;

	/**
	 * The meta object id for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.SectionImpl <em>Section</em>}' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.SectionImpl
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getSection()
	 * @generated
	 */
	int SECTION = 3;

	/**
	 * The number of structural features of the '<em>Section</em>' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int SECTION_FEATURE_COUNT = 0;

	/**
	 * The meta object id for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.DefaultMetaclassSectionImpl <em>Default Metaclass Section</em>}' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.DefaultMetaclassSectionImpl
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getDefaultMetaclassSection()
	 * @generated
	 */
	int DEFAULT_METACLASS_SECTION = 1;

	/**
	 * The feature id for the '<em><b>Metaclass Name</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int DEFAULT_METACLASS_SECTION__METACLASS_NAME = SECTION_FEATURE_COUNT + 0;

	/**
	 * The feature id for the '<em><b>Attribute</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int DEFAULT_METACLASS_SECTION__ATTRIBUTE = SECTION_FEATURE_COUNT + 1;

	/**
	 * The number of structural features of the '<em>Default Metaclass Section</em>' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int DEFAULT_METACLASS_SECTION_FEATURE_COUNT = SECTION_FEATURE_COUNT + 2;

	/**
	 * The feature id for the '<em><b>Metaclass</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int MAPPING__METACLASS = 0;

	/**
	 * The feature id for the '<em><b>Instance Class</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int MAPPING__INSTANCE_CLASS = 1;

	/**
	 * The feature id for the '<em><b>Sections</b></em>' containment reference list.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int MAPPING__SECTIONS = 2;

	/**
	 * The number of structural features of the '<em>Mapping</em>' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int MAPPING_FEATURE_COUNT = 3;

	/**
	 * The meta object id for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.PropertySectionImpl <em>Property Section</em>}' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.PropertySectionImpl
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getPropertySection()
	 * @generated
	 */
	int PROPERTY_SECTION = 4;

	/**
	 * The feature id for the '<em><b>Property</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int PROPERTY_SECTION__PROPERTY = SECTION_FEATURE_COUNT + 0;

	/**
	 * The feature id for the '<em><b>Statements</b></em>' containment reference list.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int PROPERTY_SECTION__STATEMENTS = SECTION_FEATURE_COUNT + 1;

	/**
	 * The number of structural features of the '<em>Property Section</em>' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int PROPERTY_SECTION_FEATURE_COUNT = SECTION_FEATURE_COUNT + 2;

	/**
	 * The meta object id for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.NewSectionImpl <em>New Section</em>}' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.NewSectionImpl
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getNewSection()
	 * @generated
	 */
	int NEW_SECTION = 5;

	/**
	 * The feature id for the '<em><b>Constructors</b></em>' containment reference list.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int NEW_SECTION__CONSTRUCTORS = SECTION_FEATURE_COUNT + 0;

	/**
	 * The number of structural features of the '<em>New Section</em>' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int NEW_SECTION_FEATURE_COUNT = SECTION_FEATURE_COUNT + 1;

	/**
	 * The meta object id for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.MultipleSectionImpl <em>Multiple Section</em>}' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.MultipleSectionImpl
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getMultipleSection()
	 * @generated
	 */
	int MULTIPLE_SECTION = 6;

	/**
	 * The feature id for the '<em><b>Statements</b></em>' containment reference list.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int MULTIPLE_SECTION__STATEMENTS = SECTION_FEATURE_COUNT + 0;

	/**
	 * The number of structural features of the '<em>Multiple Section</em>' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int MULTIPLE_SECTION_FEATURE_COUNT = SECTION_FEATURE_COUNT + 1;

	/**
	 * The meta object id for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.ValueSectionImpl <em>Value Section</em>}' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.ValueSectionImpl
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getValueSection()
	 * @generated
	 */
	int VALUE_SECTION = 7;

	/**
	 * The feature id for the '<em><b>Meta Value</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int VALUE_SECTION__META_VALUE = SECTION_FEATURE_COUNT + 0;

	/**
	 * The feature id for the '<em><b>Instance Value</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int VALUE_SECTION__INSTANCE_VALUE = SECTION_FEATURE_COUNT + 1;

	/**
	 * The number of structural features of the '<em>Value Section</em>' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int VALUE_SECTION_FEATURE_COUNT = SECTION_FEATURE_COUNT + 2;

	/**
	 * The meta object id for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.StatementImpl <em>Statement</em>}' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.StatementImpl
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getStatement()
	 * @generated
	 */
	int STATEMENT = 8;

	/**
	 * The feature id for the '<em><b>Type</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int STATEMENT__TYPE = 0;

	/**
	 * The feature id for the '<em><b>Variables</b></em>' attribute list.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int STATEMENT__VARIABLES = 1;

	/**
	 * The feature id for the '<em><b>Calls</b></em>' containment reference list.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int STATEMENT__CALLS = 2;

	/**
	 * The number of structural features of the '<em>Statement</em>' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int STATEMENT_FEATURE_COUNT = 3;

	/**
	 * The meta object id for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.NamedElementImpl <em>Named Element</em>}' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.NamedElementImpl
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getNamedElement()
	 * @generated
	 */
	int NAMED_ELEMENT = 9;

	/**
	 * The feature id for the '<em><b>Name</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int NAMED_ELEMENT__NAME = 0;

	/**
	 * The number of structural features of the '<em>Named Element</em>' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int NAMED_ELEMENT_FEATURE_COUNT = 1;

	/**
	 * The meta object id for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.MethodCallImpl <em>Method Call</em>}' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.MethodCallImpl
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getMethodCall()
	 * @generated
	 */
	int METHOD_CALL = 10;

	/**
	 * The feature id for the '<em><b>Name</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int METHOD_CALL__NAME = NAMED_ELEMENT__NAME;

	/**
	 * The feature id for the '<em><b>Params</b></em>' containment reference list.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int METHOD_CALL__PARAMS = NAMED_ELEMENT_FEATURE_COUNT + 0;

	/**
	 * The number of structural features of the '<em>Method Call</em>' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int METHOD_CALL_FEATURE_COUNT = NAMED_ELEMENT_FEATURE_COUNT + 1;

	/**
	 * The meta object id for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.ParameterImpl <em>Parameter</em>}' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.ParameterImpl
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getParameter()
	 * @generated
	 */
	int PARAMETER = 11;

	/**
	 * The feature id for the '<em><b>Name</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int PARAMETER__NAME = NAMED_ELEMENT__NAME;

	/**
	 * The number of structural features of the '<em>Parameter</em>' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int PARAMETER_FEATURE_COUNT = NAMED_ELEMENT_FEATURE_COUNT + 0;

	/**
	 * The meta object id for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.ConstructorImpl <em>Constructor</em>}' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.ConstructorImpl
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getConstructor()
	 * @generated
	 */
	int CONSTRUCTOR = 12;

	/**
	 * The feature id for the '<em><b>Name</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int CONSTRUCTOR__NAME = METHOD_CALL__NAME;

	/**
	 * The feature id for the '<em><b>Params</b></em>' containment reference list.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int CONSTRUCTOR__PARAMS = METHOD_CALL__PARAMS;

	/**
	 * The number of structural features of the '<em>Constructor</em>' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int CONSTRUCTOR_FEATURE_COUNT = METHOD_CALL_FEATURE_COUNT + 0;

	/**
	 * The meta object id for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.StatementType <em>Statement Type</em>}' enum.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.StatementType
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getStatementType()
	 * @generated
	 */
	int STATEMENT_TYPE = 13;


	/**
	 * Returns the meta object for class '{@link fr.inria.atlanmod.api2mol.abstractsyntax.Definition <em>Definition</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for class '<em>Definition</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Definition
	 * @generated
	 */
	EClass getDefinition();

	/**
	 * Returns the meta object for the attribute list '{@link fr.inria.atlanmod.api2mol.abstractsyntax.Definition#getContext <em>Context</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the attribute list '<em>Context</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Definition#getContext()
	 * @see #getDefinition()
	 * @generated
	 */
	EAttribute getDefinition_Context();

	/**
	 * Returns the meta object for the containment reference '{@link fr.inria.atlanmod.api2mol.abstractsyntax.Definition#getDefaultMetaclass <em>Default Metaclass</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the containment reference '<em>Default Metaclass</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Definition#getDefaultMetaclass()
	 * @see #getDefinition()
	 * @generated
	 */
	EReference getDefinition_DefaultMetaclass();

	/**
	 * Returns the meta object for the containment reference list '{@link fr.inria.atlanmod.api2mol.abstractsyntax.Definition#getMappings <em>Mappings</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the containment reference list '<em>Mappings</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Definition#getMappings()
	 * @see #getDefinition()
	 * @generated
	 */
	EReference getDefinition_Mappings();

	/**
	 * Returns the meta object for class '{@link fr.inria.atlanmod.api2mol.abstractsyntax.DefaultMetaclassSection <em>Default Metaclass Section</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for class '<em>Default Metaclass Section</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.DefaultMetaclassSection
	 * @generated
	 */
	EClass getDefaultMetaclassSection();

	/**
	 * Returns the meta object for the attribute '{@link fr.inria.atlanmod.api2mol.abstractsyntax.DefaultMetaclassSection#getMetaclassName <em>Metaclass Name</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the attribute '<em>Metaclass Name</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.DefaultMetaclassSection#getMetaclassName()
	 * @see #getDefaultMetaclassSection()
	 * @generated
	 */
	EAttribute getDefaultMetaclassSection_MetaclassName();

	/**
	 * Returns the meta object for the attribute '{@link fr.inria.atlanmod.api2mol.abstractsyntax.DefaultMetaclassSection#getAttribute <em>Attribute</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the attribute '<em>Attribute</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.DefaultMetaclassSection#getAttribute()
	 * @see #getDefaultMetaclassSection()
	 * @generated
	 */
	EAttribute getDefaultMetaclassSection_Attribute();

	/**
	 * Returns the meta object for class '{@link fr.inria.atlanmod.api2mol.abstractsyntax.Mapping <em>Mapping</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for class '<em>Mapping</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Mapping
	 * @generated
	 */
	EClass getMapping();

	/**
	 * Returns the meta object for the attribute '{@link fr.inria.atlanmod.api2mol.abstractsyntax.Mapping#getMetaclass <em>Metaclass</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the attribute '<em>Metaclass</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Mapping#getMetaclass()
	 * @see #getMapping()
	 * @generated
	 */
	EAttribute getMapping_Metaclass();

	/**
	 * Returns the meta object for the attribute '{@link fr.inria.atlanmod.api2mol.abstractsyntax.Mapping#getInstanceClass <em>Instance Class</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the attribute '<em>Instance Class</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Mapping#getInstanceClass()
	 * @see #getMapping()
	 * @generated
	 */
	EAttribute getMapping_InstanceClass();

	/**
	 * Returns the meta object for the containment reference list '{@link fr.inria.atlanmod.api2mol.abstractsyntax.Mapping#getSections <em>Sections</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the containment reference list '<em>Sections</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Mapping#getSections()
	 * @see #getMapping()
	 * @generated
	 */
	EReference getMapping_Sections();

	/**
	 * Returns the meta object for class '{@link fr.inria.atlanmod.api2mol.abstractsyntax.Section <em>Section</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for class '<em>Section</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Section
	 * @generated
	 */
	EClass getSection();

	/**
	 * Returns the meta object for class '{@link fr.inria.atlanmod.api2mol.abstractsyntax.PropertySection <em>Property Section</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for class '<em>Property Section</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.PropertySection
	 * @generated
	 */
	EClass getPropertySection();

	/**
	 * Returns the meta object for the attribute '{@link fr.inria.atlanmod.api2mol.abstractsyntax.PropertySection#getProperty <em>Property</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the attribute '<em>Property</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.PropertySection#getProperty()
	 * @see #getPropertySection()
	 * @generated
	 */
	EAttribute getPropertySection_Property();

	/**
	 * Returns the meta object for the containment reference list '{@link fr.inria.atlanmod.api2mol.abstractsyntax.PropertySection#getStatements <em>Statements</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the containment reference list '<em>Statements</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.PropertySection#getStatements()
	 * @see #getPropertySection()
	 * @generated
	 */
	EReference getPropertySection_Statements();

	/**
	 * Returns the meta object for class '{@link fr.inria.atlanmod.api2mol.abstractsyntax.NewSection <em>New Section</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for class '<em>New Section</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.NewSection
	 * @generated
	 */
	EClass getNewSection();

	/**
	 * Returns the meta object for the containment reference list '{@link fr.inria.atlanmod.api2mol.abstractsyntax.NewSection#getConstructors <em>Constructors</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the containment reference list '<em>Constructors</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.NewSection#getConstructors()
	 * @see #getNewSection()
	 * @generated
	 */
	EReference getNewSection_Constructors();

	/**
	 * Returns the meta object for class '{@link fr.inria.atlanmod.api2mol.abstractsyntax.MultipleSection <em>Multiple Section</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for class '<em>Multiple Section</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.MultipleSection
	 * @generated
	 */
	EClass getMultipleSection();

	/**
	 * Returns the meta object for the containment reference list '{@link fr.inria.atlanmod.api2mol.abstractsyntax.MultipleSection#getStatements <em>Statements</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the containment reference list '<em>Statements</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.MultipleSection#getStatements()
	 * @see #getMultipleSection()
	 * @generated
	 */
	EReference getMultipleSection_Statements();

	/**
	 * Returns the meta object for class '{@link fr.inria.atlanmod.api2mol.abstractsyntax.ValueSection <em>Value Section</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for class '<em>Value Section</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.ValueSection
	 * @generated
	 */
	EClass getValueSection();

	/**
	 * Returns the meta object for the attribute '{@link fr.inria.atlanmod.api2mol.abstractsyntax.ValueSection#getMetaValue <em>Meta Value</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the attribute '<em>Meta Value</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.ValueSection#getMetaValue()
	 * @see #getValueSection()
	 * @generated
	 */
	EAttribute getValueSection_MetaValue();

	/**
	 * Returns the meta object for the attribute '{@link fr.inria.atlanmod.api2mol.abstractsyntax.ValueSection#getInstanceValue <em>Instance Value</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the attribute '<em>Instance Value</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.ValueSection#getInstanceValue()
	 * @see #getValueSection()
	 * @generated
	 */
	EAttribute getValueSection_InstanceValue();

	/**
	 * Returns the meta object for class '{@link fr.inria.atlanmod.api2mol.abstractsyntax.Statement <em>Statement</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for class '<em>Statement</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Statement
	 * @generated
	 */
	EClass getStatement();

	/**
	 * Returns the meta object for the attribute '{@link fr.inria.atlanmod.api2mol.abstractsyntax.Statement#getType <em>Type</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the attribute '<em>Type</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Statement#getType()
	 * @see #getStatement()
	 * @generated
	 */
	EAttribute getStatement_Type();

	/**
	 * Returns the meta object for the attribute list '{@link fr.inria.atlanmod.api2mol.abstractsyntax.Statement#getVariables <em>Variables</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the attribute list '<em>Variables</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Statement#getVariables()
	 * @see #getStatement()
	 * @generated
	 */
	EAttribute getStatement_Variables();

	/**
	 * Returns the meta object for the containment reference list '{@link fr.inria.atlanmod.api2mol.abstractsyntax.Statement#getCalls <em>Calls</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the containment reference list '<em>Calls</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Statement#getCalls()
	 * @see #getStatement()
	 * @generated
	 */
	EReference getStatement_Calls();

	/**
	 * Returns the meta object for class '{@link fr.inria.atlanmod.api2mol.abstractsyntax.NamedElement <em>Named Element</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for class '<em>Named Element</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.NamedElement
	 * @generated
	 */
	EClass getNamedElement();

	/**
	 * Returns the meta object for the attribute '{@link fr.inria.atlanmod.api2mol.abstractsyntax.NamedElement#getName <em>Name</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the attribute '<em>Name</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.NamedElement#getName()
	 * @see #getNamedElement()
	 * @generated
	 */
	EAttribute getNamedElement_Name();

	/**
	 * Returns the meta object for class '{@link fr.inria.atlanmod.api2mol.abstractsyntax.MethodCall <em>Method Call</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for class '<em>Method Call</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.MethodCall
	 * @generated
	 */
	EClass getMethodCall();

	/**
	 * Returns the meta object for the containment reference list '{@link fr.inria.atlanmod.api2mol.abstractsyntax.MethodCall#getParams <em>Params</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the containment reference list '<em>Params</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.MethodCall#getParams()
	 * @see #getMethodCall()
	 * @generated
	 */
	EReference getMethodCall_Params();

	/**
	 * Returns the meta object for class '{@link fr.inria.atlanmod.api2mol.abstractsyntax.Parameter <em>Parameter</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for class '<em>Parameter</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Parameter
	 * @generated
	 */
	EClass getParameter();

	/**
	 * Returns the meta object for class '{@link fr.inria.atlanmod.api2mol.abstractsyntax.Constructor <em>Constructor</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for class '<em>Constructor</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.Constructor
	 * @generated
	 */
	EClass getConstructor();

	/**
	 * Returns the meta object for enum '{@link fr.inria.atlanmod.api2mol.abstractsyntax.StatementType <em>Statement Type</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for enum '<em>Statement Type</em>'.
	 * @see fr.inria.atlanmod.api2mol.abstractsyntax.StatementType
	 * @generated
	 */
	EEnum getStatementType();

	/**
	 * Returns the factory that creates the instances of the model.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the factory that creates the instances of the model.
	 * @generated
	 */
	Api2molFactory getApi2molFactory();

	/**
	 * <!-- begin-user-doc -->
	 * Defines literals for the meta objects that represent
	 * <ul>
	 *   <li>each class,</li>
	 *   <li>each feature of each class,</li>
	 *   <li>each enum,</li>
	 *   <li>and each data type</li>
	 * </ul>
	 * <!-- end-user-doc -->
	 * @generated
	 */
	interface Literals {
		/**
		 * The meta object literal for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.DefinitionImpl <em>Definition</em>}' class.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.DefinitionImpl
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getDefinition()
		 * @generated
		 */
		EClass DEFINITION = eINSTANCE.getDefinition();

		/**
		 * The meta object literal for the '<em><b>Context</b></em>' attribute list feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EAttribute DEFINITION__CONTEXT = eINSTANCE.getDefinition_Context();

		/**
		 * The meta object literal for the '<em><b>Default Metaclass</b></em>' containment reference feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EReference DEFINITION__DEFAULT_METACLASS = eINSTANCE.getDefinition_DefaultMetaclass();

		/**
		 * The meta object literal for the '<em><b>Mappings</b></em>' containment reference list feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EReference DEFINITION__MAPPINGS = eINSTANCE.getDefinition_Mappings();

		/**
		 * The meta object literal for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.DefaultMetaclassSectionImpl <em>Default Metaclass Section</em>}' class.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.DefaultMetaclassSectionImpl
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getDefaultMetaclassSection()
		 * @generated
		 */
		EClass DEFAULT_METACLASS_SECTION = eINSTANCE.getDefaultMetaclassSection();

		/**
		 * The meta object literal for the '<em><b>Metaclass Name</b></em>' attribute feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EAttribute DEFAULT_METACLASS_SECTION__METACLASS_NAME = eINSTANCE.getDefaultMetaclassSection_MetaclassName();

		/**
		 * The meta object literal for the '<em><b>Attribute</b></em>' attribute feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EAttribute DEFAULT_METACLASS_SECTION__ATTRIBUTE = eINSTANCE.getDefaultMetaclassSection_Attribute();

		/**
		 * The meta object literal for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.MappingImpl <em>Mapping</em>}' class.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.MappingImpl
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getMapping()
		 * @generated
		 */
		EClass MAPPING = eINSTANCE.getMapping();

		/**
		 * The meta object literal for the '<em><b>Metaclass</b></em>' attribute feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EAttribute MAPPING__METACLASS = eINSTANCE.getMapping_Metaclass();

		/**
		 * The meta object literal for the '<em><b>Instance Class</b></em>' attribute feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EAttribute MAPPING__INSTANCE_CLASS = eINSTANCE.getMapping_InstanceClass();

		/**
		 * The meta object literal for the '<em><b>Sections</b></em>' containment reference list feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EReference MAPPING__SECTIONS = eINSTANCE.getMapping_Sections();

		/**
		 * The meta object literal for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.SectionImpl <em>Section</em>}' class.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.SectionImpl
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getSection()
		 * @generated
		 */
		EClass SECTION = eINSTANCE.getSection();

		/**
		 * The meta object literal for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.PropertySectionImpl <em>Property Section</em>}' class.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.PropertySectionImpl
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getPropertySection()
		 * @generated
		 */
		EClass PROPERTY_SECTION = eINSTANCE.getPropertySection();

		/**
		 * The meta object literal for the '<em><b>Property</b></em>' attribute feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EAttribute PROPERTY_SECTION__PROPERTY = eINSTANCE.getPropertySection_Property();

		/**
		 * The meta object literal for the '<em><b>Statements</b></em>' containment reference list feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EReference PROPERTY_SECTION__STATEMENTS = eINSTANCE.getPropertySection_Statements();

		/**
		 * The meta object literal for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.NewSectionImpl <em>New Section</em>}' class.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.NewSectionImpl
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getNewSection()
		 * @generated
		 */
		EClass NEW_SECTION = eINSTANCE.getNewSection();

		/**
		 * The meta object literal for the '<em><b>Constructors</b></em>' containment reference list feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EReference NEW_SECTION__CONSTRUCTORS = eINSTANCE.getNewSection_Constructors();

		/**
		 * The meta object literal for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.MultipleSectionImpl <em>Multiple Section</em>}' class.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.MultipleSectionImpl
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getMultipleSection()
		 * @generated
		 */
		EClass MULTIPLE_SECTION = eINSTANCE.getMultipleSection();

		/**
		 * The meta object literal for the '<em><b>Statements</b></em>' containment reference list feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EReference MULTIPLE_SECTION__STATEMENTS = eINSTANCE.getMultipleSection_Statements();

		/**
		 * The meta object literal for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.ValueSectionImpl <em>Value Section</em>}' class.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.ValueSectionImpl
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getValueSection()
		 * @generated
		 */
		EClass VALUE_SECTION = eINSTANCE.getValueSection();

		/**
		 * The meta object literal for the '<em><b>Meta Value</b></em>' attribute feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EAttribute VALUE_SECTION__META_VALUE = eINSTANCE.getValueSection_MetaValue();

		/**
		 * The meta object literal for the '<em><b>Instance Value</b></em>' attribute feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EAttribute VALUE_SECTION__INSTANCE_VALUE = eINSTANCE.getValueSection_InstanceValue();

		/**
		 * The meta object literal for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.StatementImpl <em>Statement</em>}' class.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.StatementImpl
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getStatement()
		 * @generated
		 */
		EClass STATEMENT = eINSTANCE.getStatement();

		/**
		 * The meta object literal for the '<em><b>Type</b></em>' attribute feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EAttribute STATEMENT__TYPE = eINSTANCE.getStatement_Type();

		/**
		 * The meta object literal for the '<em><b>Variables</b></em>' attribute list feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EAttribute STATEMENT__VARIABLES = eINSTANCE.getStatement_Variables();

		/**
		 * The meta object literal for the '<em><b>Calls</b></em>' containment reference list feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EReference STATEMENT__CALLS = eINSTANCE.getStatement_Calls();

		/**
		 * The meta object literal for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.NamedElementImpl <em>Named Element</em>}' class.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.NamedElementImpl
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getNamedElement()
		 * @generated
		 */
		EClass NAMED_ELEMENT = eINSTANCE.getNamedElement();

		/**
		 * The meta object literal for the '<em><b>Name</b></em>' attribute feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EAttribute NAMED_ELEMENT__NAME = eINSTANCE.getNamedElement_Name();

		/**
		 * The meta object literal for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.MethodCallImpl <em>Method Call</em>}' class.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.MethodCallImpl
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getMethodCall()
		 * @generated
		 */
		EClass METHOD_CALL = eINSTANCE.getMethodCall();

		/**
		 * The meta object literal for the '<em><b>Params</b></em>' containment reference list feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EReference METHOD_CALL__PARAMS = eINSTANCE.getMethodCall_Params();

		/**
		 * The meta object literal for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.ParameterImpl <em>Parameter</em>}' class.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.ParameterImpl
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getParameter()
		 * @generated
		 */
		EClass PARAMETER = eINSTANCE.getParameter();

		/**
		 * The meta object literal for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.impl.ConstructorImpl <em>Constructor</em>}' class.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.ConstructorImpl
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getConstructor()
		 * @generated
		 */
		EClass CONSTRUCTOR = eINSTANCE.getConstructor();

		/**
		 * The meta object literal for the '{@link fr.inria.atlanmod.api2mol.abstractsyntax.StatementType <em>Statement Type</em>}' enum.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.StatementType
		 * @see fr.inria.atlanmod.api2mol.abstractsyntax.impl.Api2molPackageImpl#getStatementType()
		 * @generated
		 */
		EEnum STATEMENT_TYPE = eINSTANCE.getStatementType();

	}

} //Api2molPackage
