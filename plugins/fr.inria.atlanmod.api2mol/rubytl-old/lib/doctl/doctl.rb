
module Rtl 
  class Transformation
    
  end
  
  class Phase
    
  end
  
  class Rule
    
  end
  
  class DocProcessor
    INIT    = "init"
    COMMENT = "comment"
    KEYWORD = "keyword" 
    
    def initialize(ruby_code)
      @ruby_code = ruby_code
      #@state = nil
      
      @transformation_comment = nil
    end
    
    def process
      state         = INIT
      comment_chunk = []
      
      @ruby_code.each_line do |line|
        if line =~ /\s*#(.+)$/
          comment_chunk << line.chop
        elsif line =~ /\s*transformation(.+)$/
          @transformation_comment = comment_chunk.join($/)
        elsif line =~ /\s*phase(.+)$/
          
        elsif line =~ /\s*rule(.+)$/                    
        
        end
        
        
      end
      
      puts "Transformation"
      puts @transformation_comment
    end
  end  
end


file_name = '/home/jesus/usr/dltk/workspace/formol.migration.layout/transformations/forms2rectangle.rb'
ruby_code = nil
File.open(file_name) do |f|
  ruby_code = f.read
end 

Rtl::DocProcessor.new(ruby_code).process