
phase 'default' do
  top_rule 'klass2table' do 
    from  ClassM::Class
    to    TableM::Table
    
    mapping do |klass, table|
      table.name = klass.name
      table.cols = klass.attrs.select { |a| a.type.is_a? ClassM::PrimitiveType }
    end
  end
    
  rule 'property2column' do 
    from    ClassM::Attribute
    to      TableM::Column
    
    mapping do |attr, column|
      column.name = attr.name
      column.type = attr.type.name
    end
  end
end

phase 'primary_keys' do 
  refinement_rule 'property2column_second_phase' do 
    from    ClassM::Attribute
    to      TableM::Column
    filter  do |attr, column|
      attr.type.kind_of? ClassM::PrimitiveType
    end
    
    mapping do |attr, column|      
      column.owner.pkeys << column if attr.is_primary
    end
  end
end

phase 'foreign_keys' do
  refinement_rule 'klass2table_phase3' do
    from  ClassM::Class
    to    TableM::Table    
    mapping do |klass, table|
      table.cols = klass.attrs.select { |a| ! a.type.is_a?(ClassM::PrimitiveType) }
    end    
  end
  
  rule 'reference2column' do 
    from    ClassM::Attribute
    to      Set(TableM::Column)   
    mapping do |attr, set|
      table = klass2table(attr.type).first # Hay un error en el plugin 'explicit_calls'

      set.values = table.pkeys.map do |col| 
        TableM::Column.new(:name => attr.name + '_' + table.name + "_" + col.name,
                           :type => col.type,
                           :owner => klass2table(attr.owner))
      end
      # puts "#{table.name} #{table.cols.size} new fk2y"
      table.fkeys = TableM::FKey.new(:cols => set)
    end
  end
end    

# ========== Repeat ?? ==========
=begin
    rule 'reference2column' do 
      from    ClassM::Attribute
      to      Set(TableM::Column)   
      repeated_mapping
      
      mapping do |attr, set|
        table = klass2table(attr.type).first # Hay un error en el plugin 'explicit_calls'
        repeat do 
          
        end
        set.values = table.pkeys.map do |col| 
          TableM::Column.new(:name => attr.name + '_' + table.name + "_" + col.name,
                             :type => col.type,
                             :owner => klass2table(attr.owner))
        end
        table.fkeys = TableM::FKey.new(:cols => set)
      end
    end
=end