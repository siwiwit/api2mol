
class ::String

  # From an identifeir, it tries to generate a suitable representation
  # string to be shown in a label.
  # 
  # == Example
  # 
  #   * this-is-the-name    =>    This is the name
  #   * this_is_the_name    =>    This is the name
  #     
  def labelize_id
    self.gsub(/(-|_)+/, ' ').gsub(/^\w/) { |s| s.capitalize }
  end
  
  # It quotes a string
  # 
  # == Example
  # 
  #    'a string'.quote  =>  "a string"
  #    
  def quote()
    '"' + self + '"'
  end  
end