PTypeInteger = ClassM::PrimitiveType.all_objects.select { |o| o.name == 'Integer' }

context ClassM::Class do 
  inv('test-name') { self.name != nil }
  inv 'test-trabajo' do
    (self.name == 'Trabajo').implies( self.attrs.any? { |a| a.name == 'nombre' } ) 
  end
  inv 'test-a-false' do
    self.attrs.any? { |a| a.name == 'test-attribute-that-does-not-exist' } 
  end
end

context ClassM::Attribute do
  inv('needs-type') do
    self.type != nil
  end
  
  inv('edad-es-entero') do
    (self.name == 'edad').implies(self.type == PTypeInteger)
  end
end

