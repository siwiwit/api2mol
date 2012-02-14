
Words::Language.new do |language|
  language.words << Words::Word.new do |word|
    word.letters << Words::O.new
    word.letters << Words::C.new  
    word.letters << Words::A.new    
  end

  language.words << Words::Word.new do |word|
    word.letters << Words::C.new  
    word.letters << Words::A.new    
    word.letters << Words::C.new  
    word.letters << Words::A.new    
  end

  language.words << Words::Word.new do |word|
    word.letters << Words::C.new  
    word.letters << Words::O.new    
    word.letters << Words::C.new  
    word.letters << Words::A.new    
  end
end

Words::Language.new do |language|
  language.words << Words::Word.new do |word|
    word.letters << Words::B.new
    word.letters << Words::O.new
    word.letters << Words::C.new  
    word.letters << Words::A.new    
  end

  language.words << Words::Word.new do |word|
    word.letters << Words::B.new  
    word.letters << Words::A.new    
    word.letters << Words::B.new  
    word.letters << Words::A.new    
  end

  language.words << Words::Word.new do |word|
    word.letters << Words::C.new  
    word.letters << Words::A.new    
    word.letters << Words::B.new  
    word.letters << Words::O.new    
  end
end
