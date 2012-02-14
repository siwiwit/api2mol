$stdout.sync = true

class ManyToOneTest < Test::Unit::TestCase  
  include TestHelper

  def setup
    set_plugin_path(__FILE__)
  end
   
  def teardown
    (@constants || []).each { |c| self.class.send(:remove_const, c) }
    @constants = []
  end
   
  def test_permutations_based_on_types
    load_plugin_for_test :many_to_one
    proxy = load_model_for_test(plugin_file('Words.emof'), plugin_file('source_small.rb'))   
    put_model_in_context('Words', proxy)
    alg = RubyTL::Plugins::Algorithm.new
    
    types = [Words::A, Words::B, Words::O]
    instances_by_type = [Words::A, Words::O, Words::B].map(&:new).group_by { |o| o.class }    
    assert_equal 1, count_permutations(alg, types, instances_by_type)

    types = [Words::A, Words::B, Words::A, Words::O]
    instances_by_type = [Words::A, Words::O, Words::B].map(&:new).group_by { |o| o.class }    
    assert_equal 0, count_permutations(alg, types, instances_by_type)

    types = [Words::A, Words::B, Words::A, Words::O]
    instances_by_type = [Words::A, Words::A, Words::A, Words::A,
                         Words::B, Words::B, Words::B,
                         Words::O, Words::O].map(&:new).group_by { |o| o.class }
    assert_equal number_of_permutations(4, 2) * number_of_permutations(3, 1) * number_of_permutations(2, 1),
                 count_permutations(alg, types, instances_by_type)
   
  end
  
  
  def test_many_to_one
      rubytl = RubyTL::Launcher.new(:source_metamodel => plugin_file('Words.emof'),
                                  :target_metamodel => plugin_file('Strings.emof'),
                                  :source_model     => plugin_file('source_small.rb'),
                                  :module => 'ManyToOneWords', :serialize => false,
                                  :transformation   => many_to_one)

    rubytl.selected_plugins = [:default, :many_to_one]
    rubytl.evaluate
  
    source, target = packages(rubytl)

    words        = source.all_objects_of(source::Word)
    dictionaries = target.all_objects_of(target::Dictionary)
    dictionary   = dictionaries.first

    assert_equal 3, words.size
    assert_equal 1, dictionaries.size    
    assert_not_nil  dictionary
  
    # Since the source model has the following elements:
    #   Word -> O C A
    #   Word -> C A C A O
    #   Word -> C A O B A
    # The rule LettersX3 will match OCA seven times and
    # the rule LettersX4 will match BOCA two times
    assert_equal 7 + 2, dictionary.strings.size
    assert_equal 7    , dictionary.strings.select { |string| string.value == 'oca'}.size
    assert_equal 2    , dictionary.strings.select { |string| string.value == 'boca'}.size
  end

  def test_many_to_one_filters
      rubytl = RubyTL::Launcher.new(:source_metamodel => plugin_file('Words.emof'),
                                  :target_metamodel => plugin_file('Strings.emof'),
                                  :source_model     => plugin_file('source_small.rb'),
                                  :module => 'ManyToOneWordsWithFilters', :serialize => false,
                                  :transformation   => many_to_one_with_filters)

    rubytl.selected_plugins = [:default, :many_to_one]
    rubytl.evaluate

    source, target = packages(rubytl)

    words        = source.all_objects_of(source::Word)
    dictionaries = target.all_objects_of(target::Dictionary)
    dictionary   = dictionaries.first

    assert_equal 3, words.size
    assert_equal 1, dictionaries.size    
    assert_not_nil  dictionary
  
    # Since the source model has the following elements:
    #   Word -> O C A
    #   Word -> C A C A O
    #   Word -> C A O B A
    # and the restrictions are:
    #   Make words with three elements starting with 'O'
    #   Make words with four elements without any restriction
    assert_equal number_of_permutations(2, 2) + number_of_permutations(4, 2) * 2 +
                 number_of_permutations(5, 4) * 2, dictionary.strings.size
  end


  def test_many_to_one_too_many_elements
      rubytl = RubyTL::Launcher.new(:source_metamodel => plugin_file('Words.emof'),
                                  :target_metamodel => plugin_file('Strings.emof'),
                                  :source_model     => plugin_file('source_big.rb'),
                                  :module => 'ManyToOneWordsWithALotOfElements', :serialize => false,
                                  :transformation   => many_to_one_a_lot_of_elements)

    rubytl.selected_plugins = [:default, :many_to_one]
    rubytl.evaluate

    source, target = packages(rubytl)

    words        = source.all_objects_of(source::Word)
    dictionaries = target.all_objects_of(target::Dictionary)
    dictionary   = dictionaries.first

    assert_equal 1, words.size
    assert_equal 1, dictionaries.size    
    assert_not_nil  dictionary
  
    assert_equal 100, dictionary.strings.size
  end

  def test_many_to_one_mixing
    rubytl = RubyTL::Launcher.new(:source_metamodel => plugin_file('Words.emof'),
                                  :target_metamodel => plugin_file('Strings.emof'),
                                  :source_model     => plugin_file('source_languages.rb'),
                                  :module => 'ManyToOneWordsMixingThings', :serialize => false,
                                  :transformation   => many_to_one_mixing_things)

    rubytl.selected_plugins = [:default, :many_to_one]
    rubytl.evaluate

    source, target = packages(rubytl)

    words        = source.all_objects_of(source::Word)
    dictionaries = target.all_objects_of(target::Dictionary)
    dictionary   = dictionaries.first

    assert_equal 6, words.size
    assert_equal 1, dictionaries.size    
    assert_not_nil  dictionary

    assert_equal  7, dictionary.strings.select { |s| s.value == 'ac'}.size
    assert_equal  2, dictionary.strings.select { |s| s.value == 'abc'}.size
  end

  def test_no_rule_found_in_crossed_product
    rubytl = RubyTL::Launcher.new(:source_metamodel => plugin_file('Words.emof'),
                                  :target_metamodel => plugin_file('Strings.emof'),
                                  :source_model     => plugin_file('source_languages.rb'),
                                  :module => 'CrossProductWithFault', :serialize => false,
                                  :transformation   => cross_product_with_fault)

    rubytl.selected_plugins = [:default, :many_to_one]

  
    assert_raise(RuntimeError) {
      rubytl.evaluate
    }
  end

  # Test that a NoRuleFoundError is raised.
  def test_no_rule_found
    # TODO: "Todo. Two tests"
  end

protected
  def put_model_in_context(name, obj)
    @constants ||= []
    self.class.const_set(name, obj)
    @constants << name
  end
   
  def number_of_permutations(n, k)
    minor = n - k + 1
    (minor..n).inject(1) { |x, y| x * y }
  end

  def count_permutations(alg, types, instances_by_type)
    counter = 0
    alg.send(:make_type_permutations, types, instances_by_type) do |values|
      counter += 1
    end
    counter 
  end

end

def many_to_one
<<-END_OF
    DICTIONARY = Strings::Dictionary.new
    
    rule 'Words2Something' do
      from    Words::Word
      to      Strings::String #should be avoided          
      mapping do |word, s|
        DICTIONARY.strings = word.letters
      end
    end

    rule 'LettersX3' do            
      from    Words::O, Words::C, Words::Letter
      to      Strings::String
      filter  { |o, c, letter| letter.class.name == 'A' }
      mapping do |o, c, a, string|
        string.value = [o, c, a].map { |l| l.class.name.downcase }.join('') 
      end
    end

    rule 'LettersX4' do 
      from    Words::B, Words::O, Words::C, Words::A
      to      Strings::String
      mapping do |b, o, c, a, string|
        string.value = [b, o, c, a].map { |l| l.class.name.downcase }.join('') 
      end
    end
END_OF
end


def many_to_one_with_filters
<<-END_OF
    DICTIONARY = Strings::Dictionary.new
    rule 'Words2Something' do
      from    Words::Word
      to      Strings::String #should be avoided          
      mapping do |word, s|
        DICTIONARY.strings = word.letters
      end
    end
  
    # It should has an 'O' in first place

    rule 'LettersX3' do            
      from    Words::Letter, Words::Letter, Words::Letter
      to      Strings::String
      filter  { |l1, l2, l3| l1.class.name == 'O' }      
      mapping do |o, c, a, string|
        string.value = [o, c, a].map { |l| l.class.name.downcase }.join('') 
      end
    end

    # It should include an 'O'
    rule 'LettersX4' do 
      from    Words::Letter, Words::Letter, Words::Letter, Words::Letter
      to      Strings::String
      mapping do |l1, l2, l3, l4, string|      
        string.value = [l1, l2, l3, l4].map { |l| l.class.name.downcase }.join('') 
      end
    end
END_OF
end

def many_to_one_a_lot_of_elements
<<-END_OF
    DICTIONARY = Strings::Dictionary.new
    rule 'Words2Something' do
      from    Words::Word
      to      Strings::String #should be avoided          
      mapping do |word, s|
        DICTIONARY.strings = word.letters
      end
    end

    rule 'LettersX4' do 
      from    Words::A, Words::B, Words::C, Words::O
      to      Strings::String
      # filter  { DICTIONARY.strings.size < 100 }
      filter { $count ||= 0; $count += 1; $count <= 100 }
      mapping do |l1, l2, l3, l4, string|      
        string.value = [l1, l2, l3, l4].map { |l| l.class.name.downcase }.join('') 
      end
    end
END_OF
end

def many_to_one_mixing_things
<<-END_OF
    DICTIONARY = Strings::Dictionary.new
    rule 'Words2Something' do
      from    Words::Language, Words::Word
      to      Strings::String #should be avoided          
      filter  { |l, w| w.owner == l }
      mapping do |language, word, s|              
        DICTIONARY.strings = word.letters.select { |l| l.class.name == 'A' } ** 
                             word.letters.select { |l| l.class.name == 'B' } **
                             word.letters.select { |l| l.class.name == 'C' }                             
      end
    end

    rule 'LettersX2' do 
      from    Words::A, Words::C
      to      Strings::String
      mapping do |l1, l2, string|      
        string.value = [l1, l2].map { |l| l.class.name.downcase }.join('') 
      end
    end

    rule 'LettersX3' do 
      from    Words::A, Words::B, Words::C
      to      Strings::String
      filter  { |l1, l2, l3| not l1.owner.letters.select { |l| l.class.name == 'O'}.empty? }
      mapping do |l1, l2, l3, string|      
        string.value = [l1, l2, l3].map { |l| l.class.name.downcase }.join('') 
      end
    end
END_OF
end

def cross_product_with_fault
<<-END_OF
  DICTIONARY = Strings::Dictionary.new
  rule 'Words2Something' do
    from    Words::Language, Words::Word
    to      Strings::String #should be avoided          
    filter  { |l, w| w.owner == l }
    mapping do |language, word, s|              
      DICTIONARY.strings = word.letters.select { |l| l.class.name == 'A' } ** 
                           word.letters.select { |l| l.class.name == 'C' }                             
    end
  end
END_OF
end