require 'rubytl_base_unit'

=begin
# 
# family 'sanchez' do
#   man   'luis'
#   woman 'margarita'
# end
#
module TestLowDSL
  include RubyTL::LowLevelDSL
  
#  dsl_definition do
#    root 'family' # one or more roots
#  end  

  keyword 'family' do
    keyword_id 
    param :name, :id
    composed_of_sequence {  
      use 'man', 1;  
      use 'woman', 1; 
      use 'child', '*';   
    }  
  end
  
  keyword 'man' do
    param :name, :id
  end
  
  keyword 'woman' do
    param :name, :id
  end
 
end
=end


class LowLevelDSLTest < Test::Unit::TestCase
  include RubyTL::LowLevelDSL

  def test_invalid_keyword
    dsl = Evaluator.new
    assert_raise(InvalidKeywordName) { dsl.keyword('my-keyword') }
    assert_raise(InvalidKeywordName) { dsl.keyword('spaced keyword') }    
    assert_raise(InvalidKeywordName) { dsl.keyword('') }       
    assert_raise(InvalidKeywordName) { dsl.keyword(nil) }       
    
    assert_equal 0, dsl.info.keywords.size
  end

  def test_keyword_keyword
    dsl = Evaluator.new
    
    keyword = dsl.keyword 'first_keyword'
    assert_equal 'first_keyword', keyword.name
    keyword = dsl.keyword('keyword_name')
    assert_equal 'keyword_name', keyword.name
    assert_equal 2, dsl.info.keywords.size
  end

  def test_abstract_keywords_and_inherits
    dsl = Evaluator.new
    dsl.abstract_keyword 'my_abstract_keyword' do
      catch_block
      param 'param1', :id
    end
    dsl.abstract_keyword 'my_another_abstract_keyword'
    dsl.keyword 'subkeyword', :extends => 'my_abstract_keyword'
       
    assert_equal 3, dsl.info.keywords.size   
    assert_equal 2, dsl.info.abstract_keywords.size
    assert_equal 1, dsl.info.concrete_keywords.size
  
    keyword = dsl.info.keywords.first
    param1 = keyword.params[0]
    assert_equal true, keyword.catch_block
    assert_equal 'param1', param1.name
  
    assert_raise(KeywordNotExist) { dsl.keyword 'other_keyword', :extends => 'inexistent' }    
  end

  def test_keyword_params
    keyword = KeywordDSLDefinition.new('my_keyword')
    #keyword = dsl.keyword('my_keyword')
    keyword.param :name, :id
    keyword.param :description, :string

    param1 = keyword.info.params[0]
    param2 = keyword.info.params[1]
    assert_equal 'name', param1.name
    assert_equal 'id', param1.type
    assert_equal 'description', param2.name
    assert_equal 'string', param2.type
  
    assert_raise(InvalidType) { keyword.param(:name, :an_invalid_type) }
  end

  def test_composition_for
    dsl = Evaluator.new
    info = dsl.composition_for 'a_keyword' do
      contain_keyword 'referenced_keyword'
      contain_keyword 'another_keyword'
    end
    # TODO: Test cardinalities
    
    assert info.kind_of?(CompositionInfo)
    assert_equal 'a_keyword', info.keyword_name
    assert_equal 2, info.contained_keywords.size
    assert_equal 'referenced_keyword', info.contained_keywords[0].keyword_name
    assert_equal 'another_keyword', info.contained_keywords[1].keyword_name
  end
  
  def test_pack_composition
    dsl = recursive_dsl
    
    # The DSL is packed, to collect information about
    # composition
    dsl.info.pack
    
    root1_info  = dsl.info.find_keyword('root_keyword1')
    for_1a_info = dsl.info.find_keyword('contained_keyword_for_1a')
    for_1b_info = dsl.info.find_keyword('contained_keyword_for_1b')
        
    assert_equal 2, root1_info.contained_keywords.size 
    assert_not_nil  root1_info.contained_keywords.find { |c| c.keyword == for_1a_info }
    assert_not_nil  root1_info.contained_keywords.find { |c| c.keyword == for_1b_info }
    
    root2_info  = dsl.info.find_keyword('root_keyword2')
    rec_keyword = dsl.info.find_keyword('recursive_keyword')
    
    assert_equal 1, root2_info.contained_keywords.size 
    assert_not_nil  root2_info.contained_keywords.find { |c| c.keyword == rec_keyword }
    assert_equal 1, rec_keyword.contained_keywords.size 
    assert_not_nil  rec_keyword.contained_keywords.find { |c| c.keyword == rec_keyword }
  end
  
  def test_generate_keyword_method
    keyword_info = KeywordInfo.new()
    keyword_info.name = 'test_keyword'
    keyword_info.params << param1 = ParamInfo.new('name', :string, :one)
    keyword_info.params << param2 = ParamInfo.new('surname', :string, :one)
    
    method_def = keyword_info.keyword_formal_params
    assert method_def == ("name,surname,&#{KeywordInfo::BLOCK_NAME}")
  
    io_node_setter = StringIO.new
    param1.create_node_setter(io_node_setter, 'node_var')    
    assert_equal "node_var.attribute_set('name', name)",
                 io_node_setter.string.chop
  end
  
  def test_generate_code_for_dsl
    dsl = Evaluator.new
    dsl.keyword 'my_keyword' do
      param :name, :id
    end
    dsl.keyword 'another_keyword' do
      param :myparam, :string
      catch_block
    end
    dsl.keyword 'keyword_with_many_params' do
      param :many_param, :string, :many
    end
    
    io = dsl.info.create_dsl_text
    assert_equal 3, io.string.split("class " + KeywordInfo::CLASS_PREFIX).size - 1
    assert       io.string.include?("class Evaluator")

    dsl = create_dsl_evaluator(dsl.info)

    node = dsl.my_keyword('jesus')
    assert node.kind_of?(EvaluationNode)
    assert_equal 'jesus', node.attributes['name']
    assert_nil node.catched_block
    
    node = dsl.another_keyword('value') { 'result' }
    assert node.kind_of?(EvaluationNode)
    assert_equal 'value', node.attributes['myparam']    
    assert_equal 'result', node.catched_block.call 
  
    node = dsl.keyword_with_many_params 'p1', 'p2', 'p3', 'p4'
    assert node.kind_of?(EvaluationNode)
    assert_equal ['p1', 'p2', 'p3', 'p4'], node.attributes['many_param']    

  end
  
  def test_generate_code_for_dsl_with_inner_elements
    dsl = recursive_dsl    
    dsl.info.pack
  
    dsl = create_dsl_evaluator(dsl.info)

    node = dsl.root_keyword2 do
      recursive_keyword do
        recursive_keyword
      end
      recursive_keyword      
    end
    
    assert_equal 'root_keyword2', node.keyword_name
    assert_equal 2, node.child_nodes.size
    assert_equal 'recursive_keyword', node.child_nodes[0].keyword_name
    assert_equal 1, node.child_nodes[0].child_nodes.size
  end
  
  def test_abstract_keyword_composition
    dsl = Evaluator.new
    dsl.keyword 'group'
    dsl.abstract_keyword 'abstract' 
    dsl.keyword 'concrete', :extends => 'abstract' 
    dsl.keyword 'more_concrete', :extends => 'concrete' 
    
    # TODO: Mucho cuidado con las reglas de cardinalidad de composici�n
    #       puesto que incluyen las clases heredadas (hay que duplicar 
    #       comprobaciones de cardinalidad)
  
    dsl.composition_for 'group' do
      contain_keyword 'abstract'
    end
    
    dsl.info.pack
    kgroup    = dsl.info.find_keyword 'group' 
    kabstract = dsl.info.find_keyword 'abstract'
    kconcrete = dsl.info.find_keyword 'concrete'
    kmore_concrete = dsl.info.find_keyword 'more_concrete'
    
    assert_equal 2, kabstract.child_keywords.size
    assert       kabstract.child_keywords.include?(kconcrete)   
    assert       kabstract.child_keywords.include?(kmore_concrete)

    dsl = create_dsl_evaluator(dsl.info)
       
    node = dsl.group do
      concrete
      more_concrete
      more_concrete
    end
    
    assert_equal 3, node.child_nodes.size
    assert_equal 'concrete', node.child_nodes[0].keyword_name
    assert_equal 'more_concrete', node.child_nodes[1].keyword_name
    assert_equal 'more_concrete', node.child_nodes[2].keyword_name
    assert_raise(NoMethodError) { dsl.group { self.abstract} }    
  end
  
  def test_inherited_keyword_inherits_composition
    dsl = Evaluator.new
    dsl.abstract_keyword 'abstract' do
      param :name, :id
    end    
    dsl.keyword 'concrete1', :extends => 'abstract'
    dsl.keyword 'concrete2', :extends => 'concrete1'
    dsl.keyword 'contained'

    dsl.composition_for 'abstract' do
      contain_keyword 'contained'
    end    

    io = dsl.info.create_dsl_text
    assert ! io.string.include?("def abstract(name,")
    assert io.string.include?("def concrete1(name,")
    assert io.string.include?("def concrete2(name,")    
    
    dsl = create_dsl_evaluator(dsl.info)

    dsl.concrete1('value1') { contained }
    dsl.concrete2('value2') { contained }
  end
  
  def test_inheritance_cycles
    dsl = Evaluator.new
    dsl.abstract_keyword 'abstract', :extends => 'abstract'    
    assert_raise(InheritanceCycle) { dsl.info.create_dsl }

    
    dsl = Evaluator.new
    assert_raise(KeywordNotExist) {
      dsl.keyword 'concrete1', :extends => 'concrete3'
    }        
    
    # dsl.keyword 'concrete2', :extends => 'concrete1'        
    # dsl.keyword 'concrete3', :extends => 'concrete2'
    # This can't happen because 'inheritance' is "eager"
    #assert_raise(InheritanceCycle) { dsl.info.create_dsl }  
  end
  
  def test_root_composition
    dsl = Evaluator.new
    dsl.keyword 'top_level_keyword'
    dsl.keyword 'no_top_level_keyword'
    dsl.root_composition do
      contain_keyword 'top_level_keyword'
    end
    
    dsl = create_dsl_evaluator(dsl.info)

    node = dsl.top_level_keyword
    assert_equal 'top_level_keyword', node.keyword_name
    
    assert_raise(NoMethodError) { dsl.no_top_level_keyword }    
  end
  
  def test_global_keyword
    dsl = Evaluator.new
    dsl.keyword 'top'
    dsl.keyword('inner') { catch_block }
    dsl.composition_for 'top' do
      contain_keyword 'inner'
    end    
    dsl.global_context do
      def myglobal
        "result"
      end
    end 
    
    
    dsl = create_dsl_evaluator(dsl.info)
    top_node = dsl.top do
      inner do
        myglobal
      end
    end
    
    assert_equal 1, top_node.child_nodes.size
    
    block = top_node.child_nodes.first.catched_block
    assert_equal 'result', block.call
  end
  
  def test_root_composition_with_abstract_elements
    dsl = Evaluator.new
    dsl.keyword 'root1'
    dsl.abstract_keyword 'abstract_root'
    dsl.keyword 'root2', :extends => 'abstract_root'
    dsl.root_composition do
      contain_keyword 'root1'
      contain_keyword 'abstract_root'      
    end  
    
    dsl = create_dsl_evaluator(dsl.info)
    node = dsl.root1
    assert_equal 'root1', node.keyword_name

    node = dsl.root2
    assert_equal 'root2', node.keyword_name
  end
  
  def test_visitor_semantics
    dsl = Evaluator.new
    dsl.keyword 'root_keyword'
    dsl.keyword 'inner_keyword'
    dsl.keyword 'inner_inner_keyword'
    dsl.composition_for 'root_keyword' do
      contain_keyword 'inner_keyword'
    end 
    dsl.composition_for 'inner_keyword' do
      contain_keyword 'inner_inner_keyword'
    end
    dsl.composition_for 'inner_inner_keyword' do
      contain_keyword 'inner_inner_keyword'
    end
    
    dsl.visitor_semantics do
      def start
        @start_value = true
        @in_root_keyword = 0
        @in_inner_keyword = 0
        @out_inner_keyword = 0
        @in_inner_inner_keyword = 0
        @out_inner_inner_keyword = 0
      end
      
      def in_root_keyword
        @in_root_keyword += 1
      end
      
      #def out_root_keyword
      # To test inexisting method
      #end
      
      def in_inner_keyword
        @in_inner_keyword += 1
      end
      
      def out_inner_keyword
        @out_inner_keyword += 1
      end

      def in_inner_inner_keyword
        @in_inner_inner_keyword += 1      
      end
      
      def out_inner_inner_keyword
        @out_inner_inner_keyword += 1
      end
      
      def finish
        @finish_value = true
      end
    end
    
    dsl = create_dsl_evaluator(dsl.info)    
    
    dsl.root_keyword do
      inner_keyword
      inner_keyword
      inner_keyword do
        inner_inner_keyword
        inner_inner_keyword do
          inner_inner_keyword do
            inner_inner_keyword
            inner_inner_keyword
          end
        end
      end
    end
    dsl.root_keyword
    
    assert_equal 2, dsl.child_nodes.size
    
    loaded = dsl.execute_visitor_semantics
    result = loaded.visitor
    assert result.instance_variable_get("@start_value")
    assert_equal 2, result.instance_variable_get("@in_root_keyword")
    assert_equal nil, result.instance_variable_get("@out_root_keyword")
    assert_equal 3, result.instance_variable_get("@in_inner_keyword")
    assert_equal 3, result.instance_variable_get("@out_inner_keyword")
    assert_equal 5, result.instance_variable_get("@in_inner_inner_keyword")
    assert_equal 5, result.instance_variable_get("@out_inner_inner_keyword")
    assert result.instance_variable_get("@finish_value")
  end

  def test_visitor_semantics_helpers
    mock = Class.new do
      include ExecutionSemantics::VisitorHelperFunctions
      include Test::Unit::Assertions
      
      def start_test
        @dsldef_info = Struct.new(:mappings).new # Quick mock
        @total_method_calls = 0
        call_in_out(:test_in_method1, :test_out_method1, 'first') do
          call_in_out(:test_in_method2, :test_out_method2, 'second') { }
        end        
        assert_equal 4, @total_method_calls
      end
      
      def test_in_method1       
        inc_method_calls
        assert_not_nil current_node
        assert_equal 'first', current_node
        
        associate current_node, 'first_associated'
      end

      def test_out_method1
        inc_method_calls
        assert_not_nil current_node
        assert_equal 'first', current_node
        
        assert_equal 'first_associated', retrieve(current_node)
      end

      def test_in_method2
        inc_method_calls
        assert_not_nil current_node
        assert_equal 'second', current_node
      end

      def test_out_method2
        inc_method_calls
        assert_not_nil current_node
        assert_equal 'second', current_node
      end
      
    private
      def inc_method_calls; @total_method_calls += 1; end
    end
    
    mock.new.start_test
  end
  
  def test_evaluation_at_class_level
    dsl = Class.new(DslDefinition)
    dsl.class_eval do
      keyword 'hello'
      keyword 'goodbye'
    end
    
    assert_equal 2, dsl.info.keywords.size
  end

private
  def recursive_dsl
    dsl = Evaluator.new
    dsl.keyword 'root_keyword1'
    dsl.keyword 'root_keyword2'
    dsl.keyword 'contained_keyword_for_1a'
    dsl.keyword 'contained_keyword_for_1b'
    dsl.keyword 'recursive_keyword'
    
    dsl.composition_for 'root_keyword1' do
      contain_keyword 'contained_keyword_for_1a'
      contain_keyword 'contained_keyword_for_1b'      
    end
    dsl.composition_for 'root_keyword2' do
      contain_keyword 'recursive_keyword'
    end
    dsl.composition_for 'recursive_keyword' do
      contain_keyword 'recursive_keyword'
    end
    dsl
  end
  
  def create_dsl_evaluator(evaluator_info)
    evaluator_info.create_dsl
  end    
end