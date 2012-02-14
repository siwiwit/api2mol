require 'rubytl_base_unit'

class TestVisitorHelpers
  include RubyTL::Rtl::VisitorHelpers
end

class RGenDSLTest < Test::Unit::TestCase
  include RubyTL::LowLevelDSL
  
  module TestMetamodel
    module S
      class A; end
      class B; end
    end
    module T
      class X; end
      class Y; end
    end
  end
  
   def test_visitor_creates_proper_structure
    dsl = load_simple_dsl
    visitor = dsl.execute_visitor_semantics.visitor
    
    assert visitor.transformation.kind_of?(RubyTL::Templating::Transformation)
    assert_equal 2, visitor.transformation.rules.size
    
    rule = visitor.transformation.rules[0]
    assert_equal 2, rule.parts.size
    assert_equal TestMetamodel::S::A, rule.parts[0].type
    assert_equal TestMetamodel::S::B, rule.parts[1].type
  end
  
private
  
  def load_simple_dsl
    info = RubyTL::Templating::LanguageDefinition.info
    dsl = create_dsl_evaluator(info)
    dsl.class_eval %{          
      rule 'classifier_declaration' do
        from TestMetamodel::S::A do
          text do
          end
        end 
      
        from TestMetamodel::S::B do
          text do
          end
        end
      end    
      
      rule 'another_rule' do
      
      end
    }  
    dsl
  end

  
  def create_dsl_evaluator(evaluator_info)
    context = Module.new
    evaluator_info.create_dsl_in_context(context)
  end    
end