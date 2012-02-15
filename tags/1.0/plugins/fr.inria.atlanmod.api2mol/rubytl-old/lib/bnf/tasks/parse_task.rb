
def parse(name, &block)
  RubyTL::BNF::ParseTask.new(name, &block)
end

module RubyTL
  module BNF
    class ParseTask < RubyTL::Base::BaseTaskLib
      attr_accessor :name
  
      attr_reader :collected_parser
      attr_reader :collected_filename
      
      def initialize(name, &block)
        super(name, &block)  
      end
  
      def parser(filename)
        @collected_parser = as_resource(filename)
      end
  
      def parsed_file(filename)
        @collected_parsed_file = as_resource(filename)
      end
      
      def visitor(filename)
        @collected_visitor = as_resource(filename)
      end
         
      def define
        define_task(name) do
          self.evaluate_parser
        end
      end
  
      def evaluate_parser
        check_values
        additional = {
          :dsl_file     => @collected_parser,
          :parsed_file  => @collected_parsed_file,
          :visitor_file => @collected_visitor  
        } 
        launcher   = RubyTL::BNF::Launcher.new(input_values.merge(additional))
        launcher.evaluate
      end
      
      def check_values; end
    end
  
  end
end