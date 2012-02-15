

module URI

  def file_path
    p = self.path.gsub("%20", " ") 
    p = p[1..-1] if p =~ /^\/(\w\:)/
    return p
  end

end