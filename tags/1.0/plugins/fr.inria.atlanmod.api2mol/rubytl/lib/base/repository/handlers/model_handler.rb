module RubyTL
  module Base

    #
    # This is the base class for model handlers. 
    # 
    # A model handler is in charge of the following tasks:
    # 
    # * Determining when it can handle a certain resource. 
    # * Creating a model proxy to handle the resource.
    # 
    # == Example
    # 
    #   handler = MyModelHandler.new
    #   handler.support?(model_information)  => true or false
    #   handler.load(model_information)      => <filled:LoadedModel>
    #   handler.new_model(model_information) => <empty:LoadedModel>
    # 
    class ModelHandler   
      attr_reader :config
      
      # Create a new model handler.
      #
      # == Arguments
      # * <tt>config</tt>. Configuration information.
      #
      def initialize(config)
        @config = config
      end
    
      def support?(model_information); raise "Abstract method"; end
      def load(model_information); raise "Abstract method"; end
      def new_model(model_information); raise "Abstract method"; end
    end
  
    
    module ModelProxyMixin
      attr_accessor :model_information
    
      def package_name
        @model_information.namespace.to_ruby_constant_name  
      end
    end
  
    # TODO: Make this utility automatic for every object that is passed
    # through a model handler
    module HideUtility
      def self.hide_methods(object, exclude = {})
        object.instance_methods.each do |m|
          # TODO: Identify methods needed by rmof... such as owning_model          
          next if exclude[m] || m =~  /^(__|instance_eval|set|get|owning_model)/
          object.send(:undef_method, m)
        end
      end

      INCLUDED = [ :id, :type, :methods, :link ] # TODO: Improve locating the methods in a better way
      def self.hide_inverse(object, inc = [])
        return if object.class.name =~ /^ECore::/
        (INCLUDED + inc).each do |m|          
          (class << object; self end).send(:undef_method, m) if object.respond_to?(m)          
        end
      end
    end
    
  end
end      