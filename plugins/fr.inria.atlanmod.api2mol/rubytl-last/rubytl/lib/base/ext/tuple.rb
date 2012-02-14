

# A tuple is a container for a fixed number of elements. A tuple
#
# * can contain an object more than once
# * the objects appears in a certain order
# 
# It provides operations like
#
# * tuple construction
# * tuple flattening
# * cross-product
# * more?
#
#
class Tuple
  include Enumerable
  
  attr_reader :values
  
  # Creates a new tuple from a list of values. The values
  # can be of any type.
  # 
  #   tuple = Tuple.new(2, 'anything', Object.new)
  #
  def initialize(*values)
    @values = values.freeze
  end
  
  # Convenience way of creating tuples. It behaves just as +initialize+
  # 
  #   tuple = Tuple['anything', 23]
  #
  def self.[](*values)
    self.new(*values)
  end
    
  # Two tuples are equal if their flattening is the same, 
  # that is
  #    Tuple[1, Tuple[2, 3]] == Tuple[1, 2, 3] == Tuple[Tuple[1, 2], 3]
  #
  def ==(tuple)
    return false unless tuple.kind_of?(Tuple)
    self.flatten.values == tuple.flatten.values
  end
  
  # Applies the given block to each tuple value, just like if it were an array.
  def each(&block)
    @values.each(&block)
  end  
  
  # Get the nth-value of the tuple. It checks n >= 0 and n < tuple.size.
  def [](n)
    raise OutOfRange.new("n == #{n} is out-of-range") if (n < 0 || n >= self.size)
    @values[n]
  end
  
  # Return the number of elements of the tuple. This number is fixed.
  def size
    @values.size
  end
  
  # Flats the tuple, that is, if any tuple element is a tuple its elements are
  # extracted and used as the tuples values
  #
  #    Tuple[1, Tuple[2, 3], 4].flat  => Tuple[1, 2, 3, 4]
  #    Tuple[Tuple[Tuple[1, 2]]].flat => Tuple[1, 2]
  #
  def flatten
    flattened = []
    @values.each do |v|
      flattened << (v.kind_of?(Tuple) ? v.flatten.values : v)
    end
    Tuple.new(*flattened.flatten)
  end
  
  # It returns a tuple representing the types of the elements in
  # the tuple. This tuple can be considered the type of the tuple.
  # Example.
  #    Tuple[1, 2, 'b'].tuple_type => Tuple[Fixnum, Fixnum, String]
  #
  def tuple_type
    @tuple_type ||= Tuple.new(*@values.map { |v| v.class })
  end
  
  # Returns the string representation of a tuple
  def to_s
    "Tuple[#{@values.join(', ')}]"
  end
  
  # Returns the array representation of the tuple
  def to_a
    @values
  end
  
  # Returns the hash value of the tuple, which is the hash of the
  # underlying array
  def hash
    @values.hash
  end
  
  # Returns the eql? value of the underlying array
  def eql?(obj)
    @values.eql?(obj.values)
  end

  # Overrides the enumerable method so that, tupleization of a tuple
  # is the tuple itself.
  def tupleize
    self
  end
  
  class OutOfRange < Exception; end 
end