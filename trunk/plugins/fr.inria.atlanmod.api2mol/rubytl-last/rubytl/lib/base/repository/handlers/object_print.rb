
module RubyTL
  module Base
  
    # This mix-in allow information about an object to printed.
    # The object should provide the following methods:
    # 
    #  * <tt>metaclass</tt>.
    #  * <tt>metaclass#rumi_all_properties</tt>
    #  
    # It implementes simple heuristics to decide what properties
    # are best suited to be printed.
    # 
    module ObjectPrint    
    
      # It returns a list of relevant properties for the object, from
      # the point of view of the user that need to recognize the object.
      # Properties are ordered by relevance.
      def relevant_properties
        properties = self.metaclass.rumi_all_properties
        relevant   = properties.select { |p| p.name =~ /name/i || p.name =~ /id/i }
        relevant   # This is a first, very simple approach. 
      end
      
      def with_format(separator)
        relevant_properties.map { |p| p.name + ' = ' + formatv(self.get(p.name)) }.join(separator)
      end
      
      def to_s
        return self.custom_str if self.methods.include?('custom_str')
        return self.with_format(', ')
      end
      
    protected
      # Formats a value according to its type.
      def formatv(value)
        return 'null'         if value.nil?
        return "'#{value}'"   if value.kind_of?(String)
        return value.to_s         
      end      
    end
  
  end
end
