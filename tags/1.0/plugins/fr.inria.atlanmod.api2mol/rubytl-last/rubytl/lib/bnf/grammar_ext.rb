
module RubyTL
  module BNF
    class Grammar
      include QueryFunctions
      include FunctionsLL
    end

    module SymbolStruct
      def ==(x)
        self.class == x.class && self.name == x.name
      end
    end
  end

end