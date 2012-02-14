require 'rubytl_base_unit'
require 'rgen/rgen'
require 'rgen/to_code'
include RubyTL::Templating

require 'stringio'
require 'ostruct'

# TOOD: Test error situations (unbalanced free blocks)
#
class RGenTest < Test::Unit::TestCase
  
  def test_simple_generator
    template = %q{
      <%= 1 + 2 %>
    }
    gen = TextGenerator.new('test', template)

    gen.generate
    assert_equal 3, gen.result.strip.to_i
  end	

  def test_local_vars
    template = %q{
      <%= hello %>
    }
    gen = TextGenerator.new('test', template)

    gen.generate(:hello => 'goodbye')
    assert_equal 'goodbye', gen.result.strip
  end	

  def test_free_blocks
    template = %q{
      This is protected text, which never 
      will be modified...

      <%= open_free_block('an_id') %>
      a free block
      <%= close_free_block %>

      <%= open_free_block('id2') %>
      a second free block
      <%= close_free_block %>
  
      Finally, a third block
      <%= open_free_block('id3') %>
      third
      <%= close_free_block %>
    }
    gen = TextGenerator.new('test', template, :one_line_comment => '#$')

    gen.generate
    free = gen.extract_free_blocks

    assert_equal 3, free.size
    assert_equal 'a free block', free['an_id'].strip
    assert_equal 'a second free block', free['id2'].strip
    assert_equal 'third', free['id3'].strip
  end	

  def test_free_blocks_with_multiple_line_comment
    template = %q{
      <root>
          <protected>
                This is protected text, which never 
                will be modified...
          </protected>
          <%= open_free_block('an_id') %>
          <free>a free block</free>
          <%= close_free_block %>

          <%= open_free_block('id2') %>
          <second>a second free block</second>
          <%= close_free_block %>
      </root>
    }

    gen = TextGenerator.new('test', template, :multiline_comment => ['<!--', '-->'])

    gen.generate
    free = gen.extract_free_blocks

    assert_equal 2, free.size
    assert gen.result =~ /<!--\w*an_id\w*-->/
    assert gen.result =~ /<!--\w*id2\w*-->/
    assert_equal '<free>a free block</free>', free['an_id'].strip
    assert_equal '<second>a second free block</second>', free['id2'].strip
  end	


  def test_incremental_in_java
    template = %q{
      public class <%= classname %> {
        <% for m in methods %>
          public String get<%= m.capitalize%>() {
          <%= open_free_block('get' + m) %>
            // <%= 'Implement your get' + m.capitalize %>
            return <%= m %>;
          <%= close_free_block %>
          }

          public void set<%= m.capitalize%>(String value) {
          <%= open_free_block('set' + m) %>
            // <%= 'Implement your set' + m.capitalize %>
            this.<%= m %> = value;
          <%= close_free_block %>
          }
        <% end %>
      }
    }
    gen = TextGenerator.new('test', template, :one_line_comment => '//$')

    gen.generate(:classname => 'Test', :methods => ['name', 'address'])
    gen.result.gsub!('// Implement your getName',    "System.out.println('getName')")
    gen.result.gsub!('// Implement your getAddress', "System.out.println('getAddress')")
    gen.result.gsub!('// Implement your setName',    "System.out.println('setName')")
    gen.result.gsub!('// Implement your setAddress', "System.out.println('setAddress')")
    free = gen.extract_free_blocks

    gen.generate(:classname => 'TestChanged', :methods => ['name', 'address', 'added'])
    gen.merge(free)

    # is extraction ok?    
    assert_equal 4, free.size
    assert free.key?('getname')
    assert free.key?('setname')
    assert free.key?('getaddress')
    assert free.key?('setaddress')

    # is merging ok?
    assert gen.result.include?("public String getName")
    assert gen.result.include?("public void setName(String value)")
    assert gen.result.include?("System.out.println('getName')")
    assert gen.result.include?("System.out.println('setName')")

    assert gen.result.include?("public String getAddress")
    assert gen.result.include?("public void setAddress(String value)")
    assert gen.result.include?("System.out.println('getAddress')")
    assert gen.result.include?("System.out.println('setAddress')")


    assert gen.result.include?("public String getAdded")
    assert gen.result.include?("public void setAdded")
  end

  def test_model_to_code_files
    tocode_file = %q{
    main do
      TestObject.all_objects do |object|
        template_to_file 'test-template.erb' => "file.#{object}", :obj => object
      end
    end
    }

    locator = do_model_to_code(tocode_file)
    assert_equal "generated for testobject1", locator.written_files['file.testobject1'].strip
    assert_equal "generated for testobject2", locator.written_files['file.testobject2'].strip    
  end
  
  def test_composing_files
    tocode_file = %q{
    main do
      compose_file 'test-file' do |file|        
        file.join_by ';' + $/
        TestObject.all_objects do |object|
          apply_template 'test-template.erb', :obj => object
        end
        TestClass.all_objects do |klass|
          apply_template 'test-template.erb', :obj => klass
        end
        file << ';'
      end
    end
    }

    mapper = do_model_to_code(tocode_file)
    expected_result = "generated for testobject1;" + $/ +
                      "generated for testobject2;" + $/ +
                      "generated for testclass1;" + $/ +                      
                      "generated for testclass2;"

    assert_equal 4, mapper.written_files['test-file'].split($/).size
    assert_equal expected_result, mapper.written_files['test-file']
  end

  def test_indentate_result
    tocode_file = %q{
    main do
      TestObject.all_objects do |object|
        indent 4
        template_to_file 'test-template.erb' => "file.#{object}", :obj => object
      end
      template_to_file 'template-with-carriage-return.erb' => 'carriage.test'
    end
    }

    locator = do_model_to_code(tocode_file)  
    assert_equal "    generated for testobject1", locator.written_files['file.testobject1']
    assert_equal "    generated for testobject2", locator.written_files['file.testobject2']
    
    assert_equal 4, locator.written_files['carriage.test'].count($/)
    lines = locator.written_files['carriage.test'].split($/, -1)
    assert_equal 5, lines.size
    assert_equal '', lines[0]
    assert_equal '    some-indentation', lines[1]
    assert_equal '    more-indentation', lines[2]
    assert_equal '', lines[3]    
  end
  
=begin
    def test_short_templates
    tocode_file = %q{
      short_templates 'default' do  
#        from TestObject { self.name }
#        from Core::StringConstant   %{ <%= self.owner.apply_default %> }
      #  from Core::StringConstant, :template => 'templates/xxx.rtmpl'
      end  
    
      TestObject.all_objects do |object|
        indent 4
        template 'test-template' => "file.#{object}", :obj => object
      end
      template 'template-with-carriage-return' => 'carriage.test'
    }
  end
=end
  
  def test_nested_template
    tocode_file = %q{
    main do
      compose_file 'test-file' do         
        apply_template "nested-template.erb", :count => 0 
      end
    end
    }
    

    locator = do_model_to_code(tocode_file)
    result = (0..10).map { |i| "line #{i}"}
    assert_equal result, locator.written_files['test-file'].split($/)
    
  end
  
private
  def do_model_to_code(tocode_file)
#    handler = MockHandler.new
#    locator = MockLocator.new
    workspace = RubyTL::Base::Workspace.new(File.join(TEST_ROOT, 'files', 'templates'))
    mapper    = Test::TemplateMapperMock.new(workspace)
    context = RubyTL::Templating::ModelToCode.create_dsl_module(mapper, '.')
    language_definition = RubyTL::Templating::LanguageDefinition.info 
    language_definition.create_dsl_in_context(context)
    context.instance_eval(tocode_file)
    visitor = context.execute_visitor_semantics 
    context.instance_variable_set("@transformation", visitor.visitor.transformation) # TODO: Do it in other way
    context.start_transformation('test_m2c')

    mapper
  end
end

=begin
class MockHandler
  def wrapper
    self
  end

  def name; 'Test'; end
  def bind_to_module(*args); end
  def bind_to_context(*args); end

  def all_objects_of(klass)
    (1..2).map { |i| klass.name.downcase + i.to_s }
  end
end
=end

class TestObject
  def self.all_objects
    (1..2).map { |i| yield(self.name.downcase + i.to_s) }
  end
end

class TestClass
  def self.all_objects
    (1..2).map { |i| yield(self.name.downcase + i.to_s) }
  end
end

=begin
class MockLocator
  attr_reader :written_files
  def initialize
    @written_files = {}
  end

  def read_template(logical)
    if logical == 'test-template'
      return "generated for <%= obj %>"
    elsif logical == 'template-with-carriage-return'
      return $/ + "some-indentation" + $/ + "more-indentation" + $/ + $/
    end
    raise "Unknown template #{logical}"
  end
  
  def write_file(file, str, codebase = nil)
    @written_files[file] = str
  end
end
=end