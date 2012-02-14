
rule 'klass2javaclass' do
    from    ClassM::Class
    to      JavaM::Class
    mapping do |klass, javaclass|
        javaclass.name = klass.name
        javaclass.features = klass.attrs
   end
end

rule 'attribute2features' do 
    from    ClassM::Attribute
    to      JavaM::Field, JavaM::Method, JavaM::Method
    filter  do |attr|
        attr.visibility == 'public'
    end
    
    mapping do |attr, field, get, set|
        field.name = attr.name
        field.type = attr.type
        field.visibility = 'private'
        get.name = 'get'  + attr.name.capitalize
        get.type = attr.type
        get.visibility = 'public'
        set.name = 'set' + attr.name.capitalize
        set.visibility = 'public'
        set.params = attr.type
    end
end       


rule 'attribute2field' do 
    from    ClassM::Attribute
    to      JavaM::Field
    filter  do |attribute|  
        attribute.visibility == 'private' 
    end        
    mapping do |attr, field|
        field.name = attr.name
        field.type = attr.type
        field.visibility = 'private'
    end                
end   

rule 'type2parameter' do
    from    ClassM::Classifier
    to      JavaM::Parameter
    mapping do |classifier, parameter|
        parameter.name = 'value'
        parameter.type = classifier
    end
end

rule 'datatype2primitive' do
    from    ClassM::PrimitiveType
    to      JavaM::PrimitiveType
    mapping do |src, target| 
        target.name = src.name 
    end
end
