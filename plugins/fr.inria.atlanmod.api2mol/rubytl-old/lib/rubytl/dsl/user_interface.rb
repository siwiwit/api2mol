
module RubyTL

  # This class the facade for the definition of user interfaces
  # for plugins.
  #
  # To evaluate a new DSL file,
  #
  #   context = PluginUserInterfaceDSL.evaluate_file('/tmp/ui.rb')
  #   puts context => #<PluginUserInterfaceDSL:xxxx>
  #
  class PluginUserInterfaceDSL
    attr_reader :parameters
  
    def initialize
      @parameters = []
    end
  
    # Evaluate a DSL file and return an instance of this class.
    #
    # == Arguments
    # * <tt>filename</tt>. The DSL filename.
    #
    def self.evaluate_file(filename)
      context = self.new
      File.open(filename) do |f|
        context.instance_eval(f.read, filename)
      end
      context
    end

    def self.evaluate_and_interpret(filename, context)
      self.evaluate_file(filename).interpret(context)
    end
  
    def interpret(context)
      @parameters.each do |p|
        p.interpret(context)
      end
    end

    # Keyword: parameter
    # Definition of a parameter that a plugin can take.
    # It receives a block describing parameter properties.
    def parameter(&block)
      @parameters << Parameter.new
      @parameters.last.instance_eval(&block)
    end

    class Parameter
      # Keyword: description
      # Description of the parameter, as a string
      def description(value); @description_ = value; end
    
      # Keyword: name
      # The name of the parameter, as a symbol or string.
      def name(value); @name_ = value; end
    
      # Keyword: type
      # The type of the parameter...
      def type(value); @type_ = value; end
    
      # Keyword: datatype
      # The datatype the user will use to represent the type.
      def datatype(value); @datatype_ = value; end
    
      # Keyword: retrieve_elements
      # No effect, only for gui based interfaces
      def retrieve_elements(&block); 
        # Nothing, no effect
      end

      def interpret(context)
        # Naive approach
        if @type_ == :off_elements
          context.instance_eval %{
            def #{@name_}(*values) 
              # TODO: Check parameter types according to :datatype
              # TODO: Add plugin name, to avoid naming collisions
              self.set_plugin_parameter(:#{@name_}, values)
            end
          }      
        else
          # TODO: Complete types
          raise "Unknown type"
        end
      end
    end
  end    
end