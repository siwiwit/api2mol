
# This file contains classes with facilities to generate
# identifiers.

class IdSequentialGenerator
  def initialize(prefix = nil, initial = 0)
    @prefix  = prefix
    @next_id = initial - 1
  end
 
  # Returns a new id, as string. The prefix given
  # in the constructor is prepended.
  def next
    "#{@prefix}#{self.next_int}"
  end

  # Returns a new id, as an integer.
  def next_int
    @next_id += 1    
  end
end

