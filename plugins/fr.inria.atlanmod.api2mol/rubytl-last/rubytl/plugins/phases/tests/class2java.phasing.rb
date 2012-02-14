

phase 'classes_and_attributes' do
  rule 'class2javaclass' do
    from UML::Class
    to   Java::Class
    mapping do |klass, javaclass|
      javaclass.name       = klass.name
#      javaclass.attributes = klass.attributes
      javaclass.methods    = klass.attributes
    end
  end
  
  rule 'attribute2get' do
    from 
  end

end