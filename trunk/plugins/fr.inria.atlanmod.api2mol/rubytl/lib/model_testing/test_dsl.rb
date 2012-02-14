module RubyTL
  module ModelTesting
    class LanguageDefinition < RubyTL::LowLevelDSL::DslDefinition
      keyword('models_root') { param :dir, :string, :one }
      keyword('load_path_add') { param :dir, :string, :one }
      
      keyword 'transformation', :abstract => true
      
      keyword 'rubytl_transformation', :extends => 'transformation'
      keyword 'walk_transformation', :extends => 'transformation'
      keyword('source') { param :hash, :hash, :one }
      keyword('target') { param :hash, :hash, :one }
      keyword('file') { param :filename, :string, :one }
      
      composition_for 'transformation' do
        contain_keyword 'source'
        contain_keyword 'target'
        contain_keyword 'file'
      end
    
      keyword('test_case') { param :name, :id, :one }
      keyword('input')     { param :hash, :hash, :one }
      keyword('expected')  { param :hash, :hash, :one }
      keyword('sentences') { catch_block }  

      keyword 'comparison' 
      keyword 'key' do
        param :class_name, :id
        catch_block
      end
      composition_for 'comparison' do
        contain_keyword 'key'
      end

      composition_for 'test_case' do
        contain_keyword 'input'
        #contain_keyword 'expected'
        contain_keyword 'sentences'
      end      
      
    
      visitor_semantics do
        def start
          @test_class = @syntax_context
          @load_path_add = []
        end 
        
        def finish
          current_node.child_nodes.select { |n| n.keyword_name == 'test_case' }.each do |n|
            @test_class.tested_transformation.add_test retrieve(n)
          end
          @load_path_add.each { |p| config.workspace.load_path << p }
        end
        
        def in_models_root
          @model_root = current_node.attributes['dir']
          raise "Too early model_root" if @config
        end
        
        def in_load_path_add
          @load_path_add << current_node.attributes['dir']          
        end
        
        def out_test_case
          name = current_node.attributes['name']
          @test_class.module_eval %{
            def test_#{name}
              self.class.tested_transformation.do_test('#{name}')
            end
          }
          test = create_test(name)
          test.sentences_block = current_node.child_nodes.select { |n| n.keyword_name == 'sentences' }.first.catched_block
        end
        
        def in_source;   collect_model(RubyTL::ModelTesting::MetamodelInformation) end
        def in_target;   collect_model(RubyTL::ModelTesting::MetamodelInformation) end        
        def in_input;    collect_model(RubyTL::ModelTesting::ModelInformation) end
        def in_expected; collect_model(RubyTL::ModelTesting::ModelInformation) end        
        
        def in_file
          resource = config.workspace.create_resource(current_node.attributes['filename'])
          associate current_node, resource
        end
      
        def out_rubytl_transformation
          @test_class.tested_transformation = create_test_transformation(RubyTLTestedTransformation)
        end
        
        def out_walk_transformation
          @test_class.tested_transformation = create_test_transformation(WalkTestedTransformation)
        end
        
       
      private
        def create_test_transformation(klass)
          sources = current_node.child_nodes.select { |n| n.keyword_name == 'source' }.map { |n| retrieve(n) }
          targets = current_node.child_nodes.select { |n| n.keyword_name == 'target' }.map { |n| retrieve(n) }
          filename = current_node.child_nodes.select { |n| n.keyword_name == 'file' }.map { |n| retrieve(n) }.first        
          klass.new(config, sources, targets, filename)
        end
      
        def create_test(name)
          input    = current_node.child_nodes.select { |n| n.keyword_name == 'input' }.map { |n| retrieve(n) }
          expected = current_node.child_nodes.select { |n| n.keyword_name == 'expected' }.map { |n| retrieve(n) }        
          test = SingleTestCase.new(name, input, expected)
          associate current_node, test
          test
        end
      
        def collect_model(klass)
          namespace, file = current_node.attributes['hash'].unique_pair
          resource = if file.kind_of?(Array)
              file.map { |f| config.workspace.create_resource(f) }
            else
              config.workspace.create_resource(file)
            end
          associate current_node, klass.new(namespace, resource)
        end

        def config
          # TODO: Get the base_dir in other way...
          base = @model_root || Dir.pwd
          @config ||= RubyTL::Base::Configuration.new(RubyTL::Base::Workspace.new(base))
        end
      
      end    
    end
  end
end
