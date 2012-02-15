

# Extensions to the enumerable module.
#
# * <tt>cross</tt>. The cross product between two enumerable objects.
#
#
module Enumerable


  # Calculates the cross product between two enumerable objects. The
  # result is a list of Tuple objects.
  #
  #   [1, 2, 3] ** [3, 4] => [Tuple[1, 3], Tuple[1, 4], Tuple[2, 3],
  #                           Tuple[2, 4], Tuple[3, 3], Tuple[3, 4]]                
  #   [Tuple[1, 2], Tuple[3, 4]] ** [5, 6] => [Tuple[1, 2, 5], Tuple[1, 2, 6],
  #                                            Tuple[3, 4, 5], Tuple[3, 4, 6]]                      
  #
  # If the parameters (i.e. the value at the left of the operator) is an Integer
  # then instead of the cross product, all permutations of +n+ elements within 
  # the enumerable are calculated
  # 
  #   [1, 2, 3, 4] ** 2 => [Tuple[1, 2], Tuple[1, 3], Tuple[1, 4], 
  #                         Tuple[2, 1], Tuple[2, 3], Tuple[2, 4],
  #                         Tuple[3, 1], Tuple[3, 2], Tuple[3, 4],
  #                         Tuple[4, 1], Tuple[4, 2], Tuple[4, 3]]
  #
  def **(enumerable_or_integer)
    if enumerable_or_integer.is_a?(Integer)
      self.permutations_of(enumerable_or_integer)
    else 
      self.cross(enumerable_or_integer) 
    end      
  end

  # Calculates all possible permutations of +n+ elements in the array.
  # If the list has n items and you want a permutation of k elements,
  # you get an array with size: n * (n - 1) * (n - 1) * ... * (n - k + 1)
  #
  def permutations_of(n_elements)
    array = self
    result = TupleArray.new(n_elements)

    used  = {}
    range = (0..array.size - 1)
    varnumbers = (1..n_elements)
    indexes = varnumbers.map { |n| "i#{n}" }    
    #inner = "result << Tuple.new(array.values_at(#{indexes.join(',')}))"
    inner = "result << Tuple.new(#{varnumbers.map { |n| 'x' + n.to_s}.join(',')})"
    for x in varnumbers.to_a.reverse
      inner = meta_loop(x, inner)
    end
    eval(inner)
    result
  end


  # Configure a permutation.
  #
  # == Custom yielding
  # The method can be invoked passing a parameter with a Hash specifiying the code
  # that should be called each time a new permutation, in a certain level, appears.
  # For instance
  #   [1, 2, 3].custom_permultations_upto(3, 
  #             { 1 => 'yield(values) #1', 2 => 'yield(values) #2', 3 => 'yield(values) #3' }) do
  #     ...
  #   end
  #
  # The following variables can be accesed.
  # * values
  #
  #
  def custom_permutations_upto(n_elements, inner_level_code = Hash.new('yield(values)'), &block)
    raise 'Permutations should be taken with at least 2 elements' if n_elements < 2

    make_varnumber = lambda { |x| "i#{x}"}
    variable_declarations = %{
      n_elements = #{n_elements}
      array = self
      result = TupleArray.new(n_elements)
  
      used  = {}
      range = (0..array.size - 1)
      indexes = (1..n_elements).map { |n| 'i' + n.to_s }        
    }    
   
    inner = inner_level_code[n_elements] + $/
    for x in (1..n_elements).to_a.reverse
      if x == 1
        inner = "values = [x#{x}]" + $/ + inner 
      else
        level_code = "values[#{x - 1}] = x#{x}" + $/ 
        inner = level_code + (x != n_elements ? inner_level_code[x] : '') + $/ + inner + 'values.pop'
      end
      #inner = level_code + inner_level_code[x - 1] + $/ + inner if (x - 1) > 1
      inner = meta_loop(x, inner)
    end    

    eval(variable_declarations + $/ + inner, binding, &block)
  end

  # Calculates the cross product between two enumerable objects.
  # The result is a list of Tuple objects. Refer to +**+ for more information.
  def cross(enumerable)          
    result = TupleArray.new(self.tuple_size + enumerable.tuple_size)
    
    if self.size == 0 || enumerable.size == 0
      self.each { |x| result << Tuple.new(x) }
      enumerable.each { |x| result << Tuple.new(x) }
    else
      self.each do |o1|
        enumerable.each do |o2|        
          result << Tuple.new(o1, o2).flatten
        end
      end
    end    
    result
  end

  # Return the size of the tuples it contains. Since an enumerable is not
  # a TupleArray, the value is always 1.
  def tuple_size
    1
  end
  
  # Return a tuple as a representation of this enumerable.
  #   [1, 2, 3].tupleize => Tuple[1, 2, 3]
  def tupleize
    Tuple.new(*self)
  end
  
private
  def meta_loop(varnumber, inner)
    "for i#{varnumber} in range " + $/ +
    "  x#{varnumber} = array[i#{varnumber}] " + $/ +
    "  unless used[i#{varnumber}]" + $/ + 
    "    used[i#{varnumber}] = true" + $/ +     
    "    #{inner} " + $/ +
    "    used[i#{varnumber}] = false" + $/ +         
    "  end" + $/ +             
    "end" + $/
  end
end

# It is an array whose elements are object of type Tuple. This
# kind of array is used within the transformation engine to 
# represent collections of objects suitable to be applied in
# n-to-1 rules.
#
# A tuple array overrides the default '<<' operator to keep track of
# which "types tuples have". For instance,
#
#       tuple_array = TupleArray.new
#       tuple_array << Tuple[1, 'a']
#       tuple_array << Tuple[2, 'b']
#       tuple_array << Tuple[2, 3]
#       tuple_array.types => Tuple[Fixnum, String], Tuple[Fixnum, Fixnum]
#
# In addition, you can get a list of tuples which share the same type. For
# instance,
#
#       tuple_array.tuples_with(Fixnum, String) => [Tuple[1, 'a'], Tuple[2, 'b']]
#       tuple_array.tuples_with(Fixnum, Fixnum) => [Tuple[2, 3]]
#
class TupleArray < Array
  attr_reader :tuple_size
  
  def initialize(tuple_size, *args)
    super(*args)
    @tuple_size = tuple_size
    @tuple_types = Hash.new([])
  end

  def <<(value)        
    @tuple_types[value.tuple_type] << value 
    super(value)
  end

  def tuples_with(*types)
    raise "Not implemented"
  end
  
  def +(other)
    raise "An crossed-product array is required" unless other.respond_to? :tuple_size
    raise "Tuple size must be same" unless other.tuple_size == self.tuple_size
    TupleArray.new(self.to_a + other.to_a)
  end
end