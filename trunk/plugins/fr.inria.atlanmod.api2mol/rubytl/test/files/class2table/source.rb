
dt_string  = ClassM::PrimitiveType.new(:name => 'String')
dt_integer = ClassM::PrimitiveType.new(:name => 'Integer')
dt_boolean = ClassM::PrimitiveType.new(:name => 'Boolean')

job = ClassM::Class.new(:name => 'Job') 
job.attrs << ClassM::Attribute.new(:name => 'name', :type => dt_string, :is_primary => true)
job.attrs << ClassM::Attribute.new(:name => 'address',  :type => dt_string, :is_primary => true)  


pet = ClassM::Class.new(:name => 'Pet') do |klass|
  klass.attrs << ClassM::Attribute.new(:name => 'name', :type => dt_string, :is_primary => true)
  klass.attrs << ClassM::Attribute.new(:name => 'age',  :type => dt_integer)  
end


person = ClassM::Class.new(:name => 'Person') do |klass|
  klass.attrs << ClassM::Attribute.new(:name => 'pet',  :type => pet)  
  klass.attrs << ClassM::Attribute.new(:name => 'job',  :type => job)  
  klass.attrs << ClassM::Attribute.new(:name => 'name', :type => dt_string, :is_primary => true)
  klass.attrs << ClassM::Attribute.new(:name => 'age',  :type => dt_integer)  
end

job.attrs << ClassM::Attribute.new(:name => 'best_employee',  :type => person)  


# The class creation ordering below doesn't not work without phasing...
=begin
person = ClassM::Class.new(:name => 'Person')

job = ClassM::Class.new(:name => 'Job') do |klass|
  klass.attrs << ClassM::Attribute.new(:name => 'name', :type => dt_string, :is_primary => true)
  klass.attrs << ClassM::Attribute.new(:name => 'address',  :type => dt_string, :is_primary => true)  
end

pet = ClassM::Class.new(:name => 'Pet') do |klass|
  klass.attrs << ClassM::Attribute.new(:name => 'name', :type => dt_string, :is_primary => true)
  klass.attrs << ClassM::Attribute.new(:name => 'age',  :type => dt_integer)  
end

person.attrs << ClassM::Attribute.new(:name => 'pet',  :type => pet)  
person.attrs << ClassM::Attribute.new(:name => 'job',  :type => job)  
person.attrs << ClassM::Attribute.new(:name => 'name', :type => dt_string, :is_primary => true)
person.attrs << ClassM::Attribute.new(:name => 'age',  :type => dt_integer)  

#person = ClassM::Class.new(:name => 'Person') do |klass|
#  klass.attrs << ClassM::Attribute.new(:name => 'pet',  :type => pet)  
#  klass.attrs << ClassM::Attribute.new(:name => 'job',  :type => job)  
#  klass.attrs << ClassM::Attribute.new(:name => 'name', :type => dt_string, :is_primary => true)
#  klass.attrs << ClassM::Attribute.new(:name => 'age',  :type => dt_integer)  
#end

job.attrs << ClassM::Attribute.new(:name => 'best_employee',  :type => person)  
=end

