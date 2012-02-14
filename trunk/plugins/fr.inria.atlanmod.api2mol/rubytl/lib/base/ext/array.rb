class Array

  # Returns a hash containing arrays as values
  #
  def group_by
    result = {}
    self.each do |value|
      group = yield(value)
      result[group] ||= []
      result[group] << value
    end
    result
  end

  def stringify
    self.map { |v| v.to_s }
  end

  def find_zero_or_one(&block) 
    result = self.select(&block)
    raise ExtArrayException.new("To many elements found") if result.size > 1
    result.first
  end
    
  def find_one(&block) 
    result = self.select(&block)
    raise ExtArrayException.new("No elements found") if result.size == 0
    raise ExtArrayException.new("To many elements found") if result.size > 1
    result.first
  end
  
  class ExtArrayException < Exception; end
end

# Solve hang problem...
class ::Hash
  def inspect    
    "{...}"
  end
end


class Hash

  def unique_pair
    key, value = nil, nil
    self.each_pair { |key, value| }
    return key, value
  end

end