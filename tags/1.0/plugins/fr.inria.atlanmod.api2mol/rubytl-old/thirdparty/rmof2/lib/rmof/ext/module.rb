class Module
  def cattr_reader(*cvs)
    cvs.each do |cv|
      module_eval %Q[
          def self.#{cv}; @@#{cv} end
        ]
    end
  end    

  def cattr_writer(*cvs)
    cvs.each do |cv|
      module_eval %Q[
          def self.#{cv}=(value); @@#{cv} = value end
        ]
    end
  end    
  
  def cattr_accessor(*cvs)
    cattr_reader(*cvs)
    cattr_writer(*cvs)
  end
end