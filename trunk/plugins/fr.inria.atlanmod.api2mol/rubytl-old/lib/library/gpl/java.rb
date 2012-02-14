
class ::String
  def quote()
    '"' + self + '"'
  end

  def to_class_naming_convention
    str = self
    # TODO: Improve, including all possible cases...
    str.gsub(/(\s+\w?)/)  { |s| s.strip.upcase }.
        gsub(/^\w/)       { |s| s.upcase }.
        gsub(/(\w)(-|_)+(.)/) { |s| $1 + $3.capitalize } # Handle case: my-file -> myFile
  end

  def to_var_naming_convention
    str = self
    self.to_class_naming_convention.gsub(/^\w/) { |s| s.downcase }
  end
      
  def to_method_naming_convention
    to_var_naming_convention
  end

  def postfix(str)
    return self if self =~ Regexp.new("#{str}$", Regexp::IGNORECASE)
    self + str
  end  
end

module JavaLib
    
  # Convert a name to the Java constant convention, that is
  def self.to_constant_convention(*names)
    raise "At least one name required" if names.size == 0
    names.map { |n| n.strip }.reject { |n| n.empty? }.
          map do |str| 
            str.gsub(/([a_z])([A_Z])/, "\1_\2").
                gsub(/(\s+)/, "_").
                upcase          
          end.join("_")
  end
  
  # Given a package string in the form +pkg1.pkg2.pgk3+,
  def self.to_package_path(packagestr, klassname = nil)
    result = packagestr.gsub('.', '/')
    if klassname
      klassname += '.java' unless klassname =~ /\.java$/
      result = result + '/' + klassname
    end
    result
  end
  
  # Adds a postfix to a class name, keeping the naming convention.
  # If the classname does not follow the Java naming convention, it is
  # converted.
  # Additionally, if the classname ends with the same postfix, it is not added.
  #
  # == Arguments
  # * <tt>classname</tt>. The class name
  # * <tt>postfix</tt>. A string to be added at the end of the classname
  def self.postfix(classname, postfix)
    classname.to_class_naming_convention.postfix(postfix.to_class_naming_convention)
    #return classname.to_class_naming_convention if classname =~ Regexp.new("#{postfix}$", Regexp::IGNORECASE)
    #classname.to_class_naming_convention + postfix.to_class_naming_convention
  end
  
  # Adds a prefix to a var or class name, keeping the naming convention.
  # On the contrary to postfix, no check is done...
  def self.prefix(prefix, str)
    prefix + str.to_class_naming_convention #sub(/^./) { |s| s.capitalize } 
  end  
end