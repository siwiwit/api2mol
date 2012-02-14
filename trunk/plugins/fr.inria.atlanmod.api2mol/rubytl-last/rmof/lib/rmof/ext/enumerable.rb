module Enumerable
  def each_pair #:yield:
    e1 = nil
    each_with_index do |e,i|
      if i % 2 == 0
        e1 = e
        next
      else
        yield(e1,e)
      end
    end
  end
  
  alias_method :lookup_first, :find
end