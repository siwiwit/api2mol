$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require 'test/unit'
require File.join(File.dirname(__FILE__), 'lib', 'flexmock')
require 'rmof'
require 'helpers/metamodels'

TEST_MODELS_ROOT   = File.join(RMOF::Config::RMOF_ROOT, '..', 'test', 'models')
LIBRARY_FILE       = File.join(TEST_MODELS_ROOT, 'Library.ecore')
LIBRARY_MODEL_FILE = File.join(TEST_MODELS_ROOT, 'Library.xmi')
SCHOOL_FILE        = File.join(TEST_MODELS_ROOT, 'School.ecore')
SCHOOL_MODEL_FILE  = File.join(TEST_MODELS_ROOT, 'School.xmi')

UML_FILE        = File.join(TEST_MODELS_ROOT, 'UML2.ecore')
UML_MODEL_FILE  = File.join(TEST_MODELS_ROOT, 'uml.medium.xmi')
UML_ZOO_FILE    = File.join(TEST_MODELS_ROOT, 'UML2.zoo.ecore')
SMALL_UML_MODEL = File.join(TEST_MODELS_ROOT, 'small.uml2')


BPMN_FILE        = File.join(TEST_MODELS_ROOT, 'BPMN.ecore')

JAVAM_FILE        = File.join(TEST_MODELS_ROOT, 'JavaM.ecore')

OWL_FILE        = File.join(TEST_MODELS_ROOT, 'owl.ecore')
RDFS_FILE        = File.join(TEST_MODELS_ROOT, 'rdfs.ecore')

SUBPACKAGES_FILE        = File.join(TEST_MODELS_ROOT, 'packages.ecore')
SUBPACKAGES_MODEL       = File.join(TEST_MODELS_ROOT, 'packages.xmi')

DATATYPES_FILE        = File.join(TEST_MODELS_ROOT, 'Datatypes.ecore')
DATATYPES_MODEL       = File.join(TEST_MODELS_ROOT, 'Datatypes.xmi')

IDS_FILE        = File.join(TEST_MODELS_ROOT, 'IDs.ecore')
IDS_MODEL       = File.join(TEST_MODELS_ROOT, 'IDs.xmi')


ECORE_METAMODEL = RMOF::CacheRepository.new(RMOF::Config::CACHE_DIR).load_metamodel('http://www.eclipse.org/emf/2002/Ecore')
