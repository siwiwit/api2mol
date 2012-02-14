require 'rubytl_base_unit'

class TestVisitorHelpers
  include RubyTL::Rtl::VisitorHelpers
end

class RubyTL_DSL_Test < Test::Unit::TestCase
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
  
  def test_rubytl_language
    dsl = load_simple_dsl
    
    assert_not_nil  dsl.child_nodes
    assert_equal 2, dsl.child_nodes.size
    assert_equal 'phase', dsl.child_nodes[0].keyword_name
    assert_equal 'phase', dsl.child_nodes[1].keyword_name
    assert_equal 'root_phase',  dsl.child_nodes[0].attributes['name']    
    assert_equal 'final_phase', dsl.child_nodes[1].attributes['name']
    
    root_phase = dsl.child_nodes[0]
    assert_equal 2, root_phase.child_nodes.size
    assert_equal 'inner_phase1',  root_phase.child_nodes[0].attributes['name']    
    assert_equal 'inner_phase2',  root_phase.child_nodes[1].attributes['name']        

    inner_phase1 = root_phase.child_nodes[0]
    assert_equal 'top_rule', inner_phase1.child_nodes[0].keyword_name
    assert_equal 'rule',     inner_phase1.child_nodes[1].keyword_name


    top_rule = inner_phase1.child_nodes[0]
    def_rule = inner_phase1.child_nodes[1]
    
    assert_equal [TestMetamodel::S::A], top_rule.child_nodes[0].attributes['metaclass']
    assert_equal [TestMetamodel::T::X], top_rule.child_nodes[1].attributes['metaclass']

    assert_equal [TestMetamodel::S::B], def_rule.child_nodes[0].attributes['metaclass']
    assert_equal [TestMetamodel::T::X, TestMetamodel::T::Y], 
                 def_rule.child_nodes[1].attributes['metaclass']

  end

  def test_rules_at_top_level
    dsl = load_only_rules_dsl
    # TODO: Test...
  end

  def test_visitor_creates_proper_structure
    dsl = load_simple_dsl
    loaded = dsl.execute_visitor_semantics
    visitor = loaded.visitor
    
    assert visitor.transformation.kind_of?(RubyTL::Rtl::Transformation)
    assert_equal 1, visitor.transformation.phases.size
    
    transformation_phases = visitor.transformation.phases.first.phases
    assert_equal 2, transformation_phases.size
    assert_equal 'root_phase', transformation_phases[0].name
    assert_equal 'final_phase', transformation_phases[1].name    
    
    root_phase = transformation_phases[0]
    assert_equal 2, root_phase.phases.size
    assert_equal 'inner_phase1', root_phase.phases[0].name
    assert_equal 'inner_phase2', root_phase.phases[1].name    
    
    inner_phase1 = root_phase.phases[0]
    assert_equal 3, inner_phase1.rules.size
    assert inner_phase1.rules[0].kind_of?(RubyTL::Rtl::TopRule)
    assert inner_phase1.rules[1].kind_of?(RubyTL::Rtl::DefaultRule)    
    assert inner_phase1.rules[2].kind_of?(RubyTL::Rtl::CopyRule)    
    
    top_rule = inner_phase1.rules[0]
    assert_not_nil top_rule.from_part
    assert_not_nil top_rule.to_part    
    assert_equal [TestMetamodel::S::A], top_rule.from_part.types
    assert_equal [TestMetamodel::T::X], top_rule.to_part.types    
    assert_not_nil top_rule.filter_part
    assert         top_rule.filter_part.code_block.kind_of?(Proc)
    assert_not_nil top_rule.mapping_part
    assert         top_rule.mapping_part.code_block.kind_of?(Proc)

    def_rule = inner_phase1.rules[1]
    assert_not_nil def_rule.from_part
    assert_not_nil def_rule.to_part    
    assert_equal [TestMetamodel::S::B], def_rule.from_part.types
    assert_equal [TestMetamodel::T::X, TestMetamodel::T::Y], def_rule.to_part.types    

    copy_rule = inner_phase1.rules[2]
    assert_not_nil copy_rule.from_part
    assert_not_nil copy_rule.to_part    
    assert_equal [TestMetamodel::S::B, TestMetamodel::S::B], copy_rule.from_part.types
    assert_equal [TestMetamodel::T::X], copy_rule.to_part.types    
  end

  def test_rubytl_create_phase_visitor_helper
    helper = TestVisitorHelpers.new
    root_phase  = EvaluationNode.new('phase')
    root_phase.attribute_set('name', 'root_phase')
    inner_phase = EvaluationNode.new('phase', root_phase)
    inner_rule = EvaluationNode.new('rule', inner_phase)

    phase_obj = helper.create_phase(root_phase, nil) 
    assert phase_obj.kind_of?(RubyTL::Rtl::CompositePhase)

    phase_obj = helper.create_phase(inner_phase, phase_obj) 
    assert phase_obj.kind_of?(RubyTL::Rtl::PrimitivePhase)

    root_rule  = EvaluationNode.new('rule', root_phase)   
    assert_raise(RubyTL::Rtl::InvalidPhase) { helper.create_phase(root_phase, nil) }
  end

  def test_visitor_with_many
    dsl = load_dsl_with_many
    loaded = dsl.execute_visitor_semantics
    
    phase = loaded.visitor.transformation.phases.first
    
    assert_equal 1, phase.rules.size
    
    rule = phase.rules.first
    assert_equal 'many_rule', rule.name
  end
  

  def test_visitor_with_scheduling
  	dsl = load_dsl_with_scheduling
    visitor = dsl.execute_visitor_semantics
		
		fail("TODO: Test scheduling properly")
  end

			
private
  
  def load_only_rules_dsl
    info = RubyTL::Rtl::LanguageDefinition.info
    dsl = create_dsl_evaluator(info)
    dsl.class_eval %{          
      include RubyTL_DSL_Test::TestMetamodel
      top_rule 'top1' do
        from S::A
        to   T::X
        filter { |a| true }
        mapping do |a, x|
           # something
        end
      end  
    }
    dsl
  end


  def load_simple_dsl
    info = RubyTL::Rtl::LanguageDefinition.info
    dsl = create_dsl_evaluator(info)
    dsl.class_eval %{          
      include RubyTL_DSL_Test::TestMetamodel
      phase 'root_phase' do
        phase 'inner_phase1' do
          top_rule 'top1' do
            from S::A
            to   T::X
            filter { |a| true }
            mapping do |a, x|
              # something
            end
          end

          rule 'second_rule' do
            from S::B
            to   T::X, T::Y
          end     
          
          copy_rule 'third_rule' do
            from S::B, S::B
            to   T::X          
          end
        end
        
        phase 'inner_phase2' do
          top_rule 'top2' do
            from S::A
            to   T::Y
          end
        end        
      end
      phase 'final_phase' do
      
      end
    }  
    dsl
  end

  def load_dsl_with_many
    info = RubyTL::Rtl::LanguageDefinition.info
    dsl = create_dsl_evaluator(info)
    dsl.class_eval %{          
      include RubyTL_DSL_Test::TestMetamodel
      rule 'many_rule' do
        from S::A
        to   many(T::X)
      end
    }
    dsl
  end
  
	def load_dsl_with_scheduling
    info = RubyTL::Rtl::LanguageDefinition.info
    dsl = create_dsl_evaluator(info)
    dsl.class_eval %{          
      include RubyTL_DSL_Test::TestMetamodel
			import 'transformation://example', :as => 'imported'
      scheduling do
				phase 'myphase'
				phase 'imported'
			end
    }
    dsl		
	end
	
  def create_dsl_evaluator(evaluator_info)
    context = Module.new
    evaluator_info.create_dsl_in_context(context)
  end    
end