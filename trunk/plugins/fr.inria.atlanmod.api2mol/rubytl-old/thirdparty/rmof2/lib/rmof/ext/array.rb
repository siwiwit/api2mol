class Array

  # Test #parse_ecore_test.rb#test_parse_library_model
  # discover an error, that implies using CTRL+C to make
  # the exception trace to appear in the console
  # puts library.writers.this_method_doesnt_exist
  #
  # [ ruby-Bugs-3160 ] Call to NoMethodError#message hangs ruby
  # Reproducible situation:
  # 
  # Cell = Struct.new(:row, :col)
  # n = 9 # increase this, it will take longer time
  # cols  = Array.new(n) { [] }
  # rows  = Array.new(n) { [] }
  # boxes = Array.new(n) { Array.new(n) { Cell.new } }
  #
  # n.times {|x|
  #  n.times {|y|
  #    cell = boxes[x][y]
  #    cols[x] << cell
  #    rows[y] << cell
  #    cell.col = cols[x]
  #    cell.row = rows[y]
  #  }
  # }
  #
  # boxes[0][0].dummy
  # 
  # The naive solution is to override the inspect method to avoid
  # the Ruby internal to try to traverse the array in order to show
  # the backtrace message.
  # 
  def inspect
    "[...]"
  end
end
