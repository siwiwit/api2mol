

module RubyTL
  module Base  
    module ExceptionHandling

      # This method simple yields a code block that should 
      # evaluate a DSL. Then, exceptions are rescued, to 
      # raise the proper ones.
      def handle_dsl_exceptions(filenames)
        yield       
      rescue ::SyntaxError, ::NameError, ::TypeError, ::ArgumentError => e     
        raise RubyTL::RubySyntaxError.new(e, [*filenames])   
      rescue RubyTL::InvalidHelper => e
        raise RubyTL::RubySyntaxError.new(e, [*filenames])
      rescue RMOF::FeatureNotExist => e
        raise RubyTL::FeatureNotExistError.new(e, [*filenames])
      rescue RMOF::TypeCheckError => e
        raise RubyTL::EvaluationError.new(e, [*filenames])
      rescue RubyTL::ModelHandlerError => e   
        raise RubyTL::EvaluationError.new(e, [*filenames])                
      rescue RubyTL::RGenException => e  
        raise RubyTL::EvaluationError.new(e, [*filenames])                       
      end
    
      def handle_runtime_dsl_exceptions(filenames, *extra_exceptions)
        yield 
      rescue ::NameError, ::TypeError, ::ArgumentError => e
#        e.extend(BacktraceHandling)
#        e.instance_variable_set("@filenames", [*filenames])
#        raise e
        raise RubyTL::EvaluationError.new(e, [*filenames])
      rescue RMOF::FeatureNotExist => e
        raise RubyTL::FeatureNotExistError.new(e, [*filenames])
      rescue RMOF::TypeCheckError => e
        raise RubyTL::EvaluationError.new(e, [*filenames])        
      rescue RubyTL::BaseError => e
        filenames = ([*filenames] + e.filenames).uniq if e.respond_to? :filenames
        e         = e.wrapped   if e.respond_to? :wrapped
        raise RubyTL::EvaluationError.new(e, [*filenames])        
      rescue *extra_exceptions => e
        raise RubyTL::EvaluationError.new(e, [*filenames])             
      end

      def handle_repository_exceptions(model)       
        begin
          yield
        rescue => e
        puts e.backtrace
          raise RubyTL::ModelLoadingError.new(e, model)
        end
      end
    
    end    
  end
end


# TODO: Refactor and place each kind of exception in its corresponding component
module RubyTL
  
  module BacktraceHandling
    def prettify(filenames)
      hashed_filenames = {}
      filenames.each do |f| 
        hashed_filenames[File.expand_path(f)] = true
      end
      
      exception = @wrapped ? @wrapped : self
      pretty = []
      exception.backtrace.each do |element|
        split_element(element) do |file, line, function|
          next if not file
          #pretty << "#{file}:#{line}" if file == original_filename

          pretty << "#{file}:#{line}" if check_if_print(hashed_filenames, file)  
        end
      end
      pretty
    end
    
    def check_if_print(filenames, backtrace_filename)
      filenames[File.expand_path(backtrace_filename)]
    end
    
    def print_error(io, filenames)      
      exception = @wrapped ? @wrapped : self
      #io << exception.message + $/
      io << self.message + $/
      if self.class.debugging_mode
        io << exception.backtrace.join($/)
      else
        pretty_backtrace = prettify([*filenames])
        io << pretty_backtrace.join($/)
        io << $/ if pretty_backtrace.size > 0
      end      
    end
        
  private  
#    def match_filename?(original_filename, element)
  
    def split_element(element)
      element =~ /(.+):([0-9]+):?(.*)/
      file, line, function = $1, $2, $3
      #elements = element.split(':')
      #file = elements[0]
      #line = elements[1]
      #function = elements[2]
      yield(file, line, function)
    end
  end
  
  class BaseError < RuntimeError
    include BacktraceHandling  
    attr_accessor :message
    cattr_accessor :debugging_mode
    @@debugging_mode = false
    
    def initialize(msg)
      @message = msg          
    end
    
    def is_rubytl?; true; end
    def to_s
      @message
    end
    
    def to_str
      @message
    end
    
    def message
      @message || super
      #super + (@message ? ": #{@message}" : "")      
    end        
  end
  
  class ModelLoadingError < BaseError
    include BacktraceHandling
    def initialize(e, model)
      @wrapped = e
      @message = "Error while loading model called '#{model.to_s}': " + e.message
    end
  end
  
  class InvalidHelper < BaseError; end;
  class PluginNotExist < BaseError; end;
  
  class SyntaxError < BaseError
    def initialize(filename, e)       
      str = e.backtrace.first
      line = str.split(':')[1]
      
      set_backtrace([filename + ':' + line])
      self.message = "Syntax error: " + e.message
    end
  end
  
  #TODO: Arreglar RuleNotFound y TooManyRules
  #
  # Excepcion para se�alar que no se ha encontrado una regla aplicable
  # para asignar una instancia a una referencia
  #
  class RuleNotFound < BaseError
    attr_reader :reference, :instance
    
    # Crea una excepcion.
    #     +reference+:: La referencia a la que se quiere asignar la instancia.
    #     +instance+:: La instancia que se quiere asignar
    def initialize(target_type, instance)
      @target_type, @instance = target_type, instance
    end
    
    def message
      "No rules for xxxx.#{@target_type.name} = #{@instance.class.qualified_name}"        
    end
  end
  
  class InstanceNotTransformed < BaseError        
    def message
      "Instance not transformed yet"
    end
  end    
  
  class RightNilError < BaseError        
    def message
      "Nil in the right part"
    end
  end        
  
  class InvalidSyntax < BaseError
    def initialize(message)
      super(message)
    end
  end
  
  
  class URINotSupportedError < BaseError; end
  
   
  class UndefinedModel < BaseError  
    def initialize(local_name, metamodel_uri)  
      super("No model given for #{local_name} => #{metamodel_uri}")
    end
  end

  # An exception that wraps a SyntaxError ocurred when loading
  # a DSL. 
  #  
  class RubySyntaxError < BaseError
    include BacktraceHandling
    attr_accessor :filenames
    attr_reader :wrapped
    def initialize(e, filenames = nil)
      @wrapped = e
      @filenames = filenames
      super("Syntax error. " + e.message)
    end
  end   
  
  class EvaluationError < BaseError
    include BacktraceHandling  
    attr_accessor :filenames
    attr_reader :wrapped
    def initialize(e, filenames = nil, options = {})
      @wrapped = e
      @filenames = [*filenames].compact
      super("Evaluation error. " + (options[:message] || e.message))
    end

    alias_method :old_backtrace, :backtrace
    def backtrace
      return old_backtrace unless @wrapped
      # ([@wrapped.backtrace] + [old_backtrace]).flatten.compact
      # This may cause an infinite looping...
      @wrapped.backtrace
    end    
  end
  
  class FeatureNotExistError < EvaluationError
    def initialize(rmof_exception, filenames = nil)
      super(rmof_exception, filenames, :message => create_message(rmof_exception))
    end

  private
    def create_message(exception)
      pkg = construct_package(exception.klass)
      append = ''
      if exception.object
        append = $/ + "\twhere #{pkg} = { #{exception.object} }"  
      end
      "No feature '#{exception.feature_name}' found in #{pkg}" + append
    end
    
    # TODO: Factorize with rumi_rmof2#qualified_name. The problem is taht exception.klass is an EClass...
    def construct_package(klass)
      names = [klass.name]
      pkg   = klass.ePackage 
      while ( pkg != nil ); names << pkg.name; pkg = pkg.eSuperPackage; end
      names.reverse.join('::')
    end
  end
  
  class TransformationNotExist < BaseError
    include BacktraceHandling
    def initialize(filename)
      super("Transformation #{filename} not found")
    end
  end
  
  class ModelHandlerError < BaseError; end
  
  class InvalidReferencedPackage < ModelHandlerError
    def initialize(pkg_name, available_pkg_names)
      super("No package #{pkg_name} is referenced. Available packages: #{available_pkg_names}")
    end
  end
  
  class RGenException < BaseError; include BacktraceHandling; end
end