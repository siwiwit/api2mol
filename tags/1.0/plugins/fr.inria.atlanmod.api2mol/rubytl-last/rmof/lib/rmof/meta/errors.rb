
module RMOF
  class BaseError < RuntimeError
    def message
      super + (@message ? ": #{@message}" : "")
      
    end
  end

  class ParserError < RuntimeError; end
  class FragmentNotFound < ParserError; end

  class TypeCheckError < BaseError; end
  class UnknownFormat < BaseError; end
  class FeatureNotExist < BaseError
    attr_accessor :object
    attr_accessor :klass
    attr_accessor :feature_name
    def initialize(feature_name, klass)
      @feature_name = feature_name
      @klass        = klass
      package = klass.ePackage
      @message = "No feature '#{feature_name}' found in #{package.name}::#{klass.name}"
    end
  end

  class OperationNotExist < BaseError
    def initialize(operation_name, klass)
      package = klass.ePackage
      @message = "No operation '#{operation_name}' found in #{package.name}::#{klass.name}"
    end
  end
  
  class AbstractClassCannotBeInstantiated < BaseError
    def initialize(metaclass)
      @message = "Metaclass '#{metaclass.name}' is abstract"
    end
  end
  
  class CachedMetamodelNotExist < BaseError; end

end