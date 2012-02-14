

class String

  def to_metamodel_name
    return 'ECore' if self.upcase == 'ECORE'
    self[0..0].upcase + self[1..-1]
  end
  
  def to_class_name
    return self
  end

end