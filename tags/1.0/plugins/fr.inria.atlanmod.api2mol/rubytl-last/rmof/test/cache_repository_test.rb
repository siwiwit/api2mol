require 'base_unit'

class AdapterTest < Test::Unit::TestCase

  def setup
    @repository = RMOF::CacheRepository.new
  end
  attr_reader :repository

  def test_default_metamodels
    assert_equal({ 'ECore' => 'http://www.eclipse.org/emf/2002/Ecore', 'Uml2' => 'http://www.eclipse.org/uml2/1.0.0/UML' }, repository.metamodels)
  end

  def test_default_parameter
    assert !repository.metamodels.empty?
  end

  def test_load_metamodel
    metamodel = repository.load_metamodel('http://www.eclipse.org/emf/2002/Ecore')
    assert_kind_of RMOF::Model, metamodel
    assert_equal [ECore], metamodel.root_elements
  end

end
