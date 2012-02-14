require 'test/unit'

module RubyTL
  module ModelTesting
    
    class TestCase < Test::Unit::TestCase
      
      def self.inherited(subclass)
        LanguageDefinition.info.create_dsl_in_context(subclass)
      end
      
      def self.run
        visitor = self.execute_visitor_semantics
        #@transformation_object = visitor.transformation 
      end
    
      def self.tested_transformation=(transformation)
        @tested_transformation = transformation
      end
      
      def self.tested_transformation
        @tested_transformation
      end
    end    

  end
end

module Test
  module Unit
    class AutoRunner
      def self.run(force_standalone=false, default_dir=nil, argv=ARGV, &block)
        r = new(force_standalone || standalone?, &block)
        if((!r.process_args(argv)) && default_dir)
          r.to_run << default_dir
        end
        r.run
      end
      
      def self.standalone?
        return false unless("-e" == $0)
        ObjectSpace.each_object(Class) do |klass|
          return false if(klass < TestCase && klass < RubyTL::ModelTesting::TestCase)
        end
        true
      end

      def run
        @suite = @collector[self]
        result = @runner[self] or return false
        result.run(@suite, @output_level).passed?
      end
      
    end
  end
end

module Test
  module Unit
    module Collector
      class Dir
         def collect(*from)
           #puts "kkkkkkkkkkkkkkkkkk"
         end
      
        def find_test_cases(ignore=[RubyTL::ModelTesting::TestCase])
          cases = []
          @object_space.each_object(Class) do |c|
            cases << c if(c < TestCase && !ignore.include?(c))
          end
          ignore.concat(cases)
          cases
        end
      end
    end
  end
end

require 'test/unit/collector/objectspace'

module Test
  module Unit
    module Collector
      class ObjectSpace
         def collect(name=NAME)       
          suite = TestSuite.new(name)
          sub_suites = []
          @source.each_object(Class) do |klass|
            if Test::Unit::TestCase > klass && klass != RubyTL::ModelTesting::TestCase
              #puts "no la ignoro"
              #puts klass
              add_suite(sub_suites, klass.suite)
            end
          end
          sort(sub_suites).each{|s| suite << s}
          suite
        end
      end
    end
  end
end