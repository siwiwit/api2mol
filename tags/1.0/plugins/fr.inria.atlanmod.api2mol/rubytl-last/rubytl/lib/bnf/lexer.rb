
module RubyTL
  module BNF    
    class TokenMatch
      attr_reader :kind
      attr_reader :match
      
      def initialize(token, match)
        @kind = token.name.to_s
        @match = match
      end
    end
    
    class EOFClass < TokenMatch; def initialize; @kind = 'EOF' end; end
    
    #
    # This lexer uses the token definition of a grammar (RubyTL::BNF::Grammar) 
    # to recognize pieces of a certain text. 
    #
    # It provides a pointer to the token input stream so
    # that it can be asked to read the next token, return a previously
    # read token...
    # 
    class Lexer
      EOF = EOFClass.new
      
      attr_reader :grammar
      attr_reader :current_text
    
      # Creates a new lexer to recognize a certain text.
      # 
      # == Arguments
      # * <tt>grammar</tt>. An object of type RubyTL::BNF::Grammar.
      # * <tt>text</tt>. The text to be recognized
      #
      def initialize(grammar, text)
        @text    = text
        @current_text = text
        @buffer = []
        @idx = 0
        create_processed_tokens(grammar)
      end

      # Returns the next token in the input stream or EOF if this is the
      # end of the stream.   
      def next_token
        if @buffer.size > @idx
          r = @buffer[@idx] 
          @idx = @idx + 1
          return r 
        end
        
        return EOF if @current_text.size == 0
        
        while try_to_ignore; end
        token_match = try_a_token
        raise NoTokenFound.new(self, "No token found") if token_match.nil?
        @buffer[@idx] = token_match
        @idx = @idx + 1
        token_match
      end
      
      # Move back the pointer, that is, the previously read token is 
      # now the current token.
      def rollback
        @idx = @idx - 1
      end
    
      def look_ahead
        result = next_token
        rollback
        result
      end
    
      def eat
        next_token
      end
      
      def match(token_string)
        if (t = next_token).kind != token_string.to_s
          raise UnexpectedToken.new(self, "No token '#{token_string}' but '#{t}'")
        end
        t
      end
      
    private
      def try_to_ignore
        match_text(@ignored)
      end
      
      def try_a_token
        # TODO: Ignore if the token is a Pair :ignore token 
        try_a_pair || match_text(@tokens)
      end

      def try_a_pair
        match_list(@paired) do |t, pre_match, match, post_match|
          if (post_match =~ t.end_regexp )
            # Matched value = pre_match + $` + $'
            @current_text = $'
            return TokenMatch.new(t, match + $` + $&)
          end        
        end
        return nil
      end

      def match_text(list)       
        match_list(list) do |t, pre_match, match, post_match|
#          puts "Matched #{t.name}"
#          puts post_match
#          puts "--"
          @current_text = post_match
          return TokenMatch.new(t, match)        
        end
        return nil
      end
    
      def match_list(list)
        list.each do |t|
          if (@current_text =~ t.regexp) == 0
            yield(t, $`, $&, $')
          end
        end        
      end
        
      RToken = Struct.new(:name, :regexp)
      PToken = Struct.new(:name, :regexp, :end_regexp)      
      def create_processed_tokens(grammar)        
        @tokens  = grammar.tokens.map { |token| RToken.new(token.name, create_regexp(token.regexp)) }
        @ignored = grammar.ignoredTokens.map { |token| RToken.new(token.name, create_regexp(token.regexp)) }
        @paired  = grammar.pairTokens.map { |token| PToken.new(token.name, create_regexp(token.regexp), create_regexp(token.endRegexp, :anchor => false)) }
      end  
      
      def create_regexp(str_regexp, options = { :anchor => true })
        anchor = options[:anchor] == false ? '' : '^'
        Regexp.new("#{anchor}#{str_regexp}")
      end
    end

    class LexerError < RubyTL::BaseError
      def initialize(lexer, message)
        super(message + $/ + more_information(lexer))
      end
    private
      def more_information(lexer)
        lexer.current_text
      end
    end 

    class NoTokenFound < LexerError; end 
    class UnexpectedToken < LexerError; end
  end  
end