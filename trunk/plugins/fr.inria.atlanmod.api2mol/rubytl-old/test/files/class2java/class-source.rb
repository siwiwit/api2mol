dt_string  = ClassM::PrimitiveType.new(:name => 'String')
dt_integer = ClassM::PrimitiveType.new(:name => 'Integer')
dt_boolean = ClassM::PrimitiveType.new(:name => 'Boolean')

#person = ClassM::Class.new(:name => 'Person')

job = ClassM::Class.new(:name => 'Trabajo') do |klass|
  klass.attrs << ClassM::Attribute.new(:name => 'nombre', :type => dt_string, :visibility => 'public')
  klass.attrs << ClassM::Attribute.new(:name => 'direccion',  :type => dt_string, :visibility => 'public')  
end

pet = ClassM::Class.new(:name => 'Mascota') do |klass|
  klass.attrs << ClassM::Attribute.new(:name => 'nombre', :type => dt_string, :visibility => 'public')
  # klass.attrs << ClassM::Attribute.new(:name => 'age',  :type => dt_integer, :visibility => 'public')  
end


#job.attrs << ClassM::Attribute.new(:name => 'pet',  :type => pet)  
#job.attrs << ClassM::Attribute.new(:name => 'job',  :type => job)  
#job.attrs << ClassM::Attribute.new(:name => 'name', :type => dt_string, :is_primary => true)
#job.attrs << ClassM::Attribute.new(:name => 'age',  :type => dt_integer)  

person = ClassM::Class.new(:name => 'Persona') do |klass|
  klass.attrs << ClassM::Attribute.new(:name => 'mascota',  :type => pet, :visibility => 'public')  
  klass.attrs << ClassM::Attribute.new(:name => 'trabajo',  :type => job, :visibility => 'public')  
  klass.attrs << ClassM::Attribute.new(:name => 'nombre', :type => dt_string, :visibility => 'public')
  klass.attrs << ClassM::Attribute.new(:name => 'edad',  :type => dt_integer, :visibility => 'private')  
end

# job.attrs << ClassM::Attribute.new(:name => 'best_employee',  :type => person, :visibility => 'public')  
