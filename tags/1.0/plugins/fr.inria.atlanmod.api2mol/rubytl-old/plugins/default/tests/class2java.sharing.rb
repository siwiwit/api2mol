class ::String
  def to_set
    'set'  + self.capitalize  
  end
  
  def to_get
    'get'  + self.capitalize  
  end
  
  # Convert a class name to the Java naming convention
  # TODO: 
  def to_klass_convention
    self
  end
end

module ClassM
  class Class
  
    # Returns true is this is a root class, that is,
    # it does not inherit from any parent class.
    def is_root_class
      self.parents.size == 0
    end
    
    # Return the parent with more methods and attributes
    def heaviest_parent
      weight_parents[0]
    end
    
    # Returns the parents with less methods and attributes,
    # that is: all parents == [heaviest_parents] + thinest_parents
    def thinest_parents
      weight_parents[1..-1]
    end

    def weight_parents
      self.parents.sort_by { |parent| parent.features.size }.reverse
    end

    # Returns a list of operations  
    def operations
      self.features.select { |f| f.kind_of? ClassM::Operation }
    end
  
    # Checks if an attribute conflicts with an operation,
    # checking both name and operation signature against the attribute
    def get_conflicts_in(attr)
      self.operations.select { |o| (o.name == attr.name.to_get) && o.params.size == 0 }.size > 0
    end

    def set_conflicts_in(attr)
      self.operations.select { |o| (o.name == attr.name.to_set) &&
                                   (o.params.size == 1)         && 
                                   (o.params.first.type == attr.type )}.size > 0
    end
  end
end


# This is the transformation module. 
#module Class2JavaToTestCreation
    JAVA_LANG_PACKAGE = JavaM::Package.new(:name => 'java.lang')
    PACKAGE = JavaM::Package.new(:name => Parameters['package'])
        
    rule 'klass2javaclass' do
        from    ClassM::Class
        to      JavaM::Class
        mapping do |klass, javaclass|
            javaclass.name = klass.name
            javaclass.features = klass.features
            javaclass.owner = PACKAGE
            javaclass.extends = [*klass.heaviest_parent].compact
            javaclass.implements = [*klass.thinest_parents].compact

            # Transform operations to empty methods implementing the abstract methods
            # provided by the interfaces, and add a private field for each interface
#            javaclass.features = [*klass.thinest_parents].compact.map { |c| c.operations }.flatten
#            javaclass.features = [*klass.thinest_parents].compact
       end
    end

    rule 'klass2field' do 
        from    ClassM::Class
        to      JavaM::Field
        mapping do |klass, field|
            field.name = 'impl' + klass.name
            field.visibility = 'protected'
            field.type = klass2interface(klass)
      end    
    end
   
    rule 'klass2interface' do
        from    ClassM::Class
        to      JavaM::Interface
        mapping do |klass, interface|
            interface.owner = PACKAGE
            interface.name = 'I' + klass.name.to_klass_convention
            interface.extends = klass.parents      
            interface.abstractMethods = klass.operations
        end
    end
    
    rule 'attribute2get' do 
        from    ClassM::Attribute
        to      JavaM::Method
        filter  do |attr|
            (attr.visibility == 'public') && ! attr.owner.set_conflicts_in(attr)
        end
        
        mapping do |attr, get|
            get.name = attr.name.to_get
            get.type = attr.type
            get.visibility = 'public'
        end
    end       

    rule 'attribute2set' do 
        from    ClassM::Attribute
        to      JavaM::Method
        filter  do |attr|
            (attr.visibility == 'public') && ! attr.owner.get_conflicts_in(attr)
        end
        
        mapping do |attr, set|
            set.name = attr.name.to_set
            set.visibility = 'public'
            set.params = attr.type
        end
    end       

    rule 'attribute2field' do 
        from    ClassM::Attribute
        to      JavaM::Field
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

    rule 'operation2method' do
        from    ClassM::Operation
        to      JavaM::Method
        mapping do |operation, method|
            method.name = operation.name
            method.type = operation.type
        end
    end

    rule 'datatype2primitive' do
        from    ClassM::PrimitiveType
        to      JavaM::PrimitiveType
        mapping do |src, target| 
            target.name = src.name 
            target.owner = JAVA_LANG_PACKAGE
        end
    end

#end