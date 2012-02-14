
class Array
  def find_by_name(value)
    self.find { |x| x.name == value }
  end
end