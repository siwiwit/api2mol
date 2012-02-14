dt_string  = ClassM::PrimitiveType.new(:name => 'String')
dt_integer = ClassM::PrimitiveType.new(:name => 'Integer')
dt_boolean = ClassM::PrimitiveType.new(:name => 'Boolean')

base1 = ClassM::Class.new(:name => 'base1') 
base2 = ClassM::Class.new(:name => 'base2') do |klass|
  klass.features << ClassM::Operation.new(:name => 'operation1_for_base2',  :type => dt_string, :visibility => 'public')  
  klass.features << ClassM::Operation.new(:name => 'operation2_for_base2',  :type => dt_integer, :visibility => 'public')    
end

base3 = ClassM::Class.new(:name => 'base3') do |klass|
  klass.features << ClassM::Attribute.new(:name => 'attribute_for_base3',  :type => dt_string, :visibility => 'public')  
  klass.features << ClassM::Operation.new(:name => 'operation1_for_base3',  :type => dt_string, :visibility => 'public')  
end

child = ClassM::Class.new(:name => 'child')
child.parents << base1
child.parents << base2
child.parents << base3


