
rule 'base' do
  from    ClassM::Class
  to      TableM::Table
  mapping do |klass, table|
    table.cols = klass.attrs
    raise "Expected #{klass.attrs.size * 2 + 1} but got #{table.cols.size}" unless table.cols.size == (klass.attrs.size * 2 + 1)
  end  
end

rule 'duplicate' do 
  from    ClassM::Attribute
  to      Set(TableM::Column)
  
  mapping do |attr, set|
    set.values = attr.owner
    set << TableM::Column.new(:name => attr.name + '1')
    set << TableM::Column.new(:name => attr.name + '2')
    
    #puts set.size
  end
end
      
rule 'klass2column' do
  from    ClassM::Class
  to      TableM::Column
  mapping do |klass, column|
    column.name = 'created from ' + klass.name
  end
end 
