
# 40 letras
#    10 -> A
#    10 -> B
#    10 -> C
#    10 -> O
Words::Word.new do |word|
  1.upto(20) { word.letters << Words::A.new }
  1.upto(20) { word.letters << Words::B.new }
  1.upto(20) { word.letters << Words::C.new }
  1.upto(20) { word.letters << Words::O.new }
end
