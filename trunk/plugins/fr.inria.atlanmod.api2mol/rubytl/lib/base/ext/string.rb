class String    
  def underscore
    # From ActiveRecord
    self.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').downcase
  end
  
  def windoze_uri
    string = self.gsub("\\", "/").gsub(" ", "%20")
    if string =~ /^\w:/ && RUBY_PLATFORM.include?('win32')
      string = '/' + string
    end
    string
  end
  
  def to_ruby_constant_name(prefix = "C")
    result = self.gsub(/(\s+\w?)/) { |s| s.strip.upcase }.
             gsub(/^\w/) { |s| s.upcase }
    result = prefix + result unless result =~ /^[A-Z]/
#    [%w{Á A}, %w{É E}, %w{Í I}, %w{Ó O}, %w{Ú U},
#     %w{á a}, %w{é e}, %w{í i}, %w{ó o}, %w{ú u}].each { |v| result.gsub!(*v) }
    result    
  end
  
  def to_ruby_method_name
    self.gsub(/(-|\.)/, '_')
  end
  
  def substitute(*args)
    msg = self.dup
    args.each_with_index { |str, idx| msg.sub!("{#{idx + 1}}", str.to_s) }
    msg      
  end
end

# Modified Symbol for yarv-compatibility
#
class Symbol
  def to_a
    [self]
  end
end

class Hash
  def stringify_keys
    inject({}) do |options, (key, value)|
      options[key.to_s] = value
      options
    end
  end  
end