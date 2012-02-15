


module TestMetamodels
  @@model_id = 1 
  def self.clean_all    
    metamodels = [Family, Tree]
    metamodels.each { |m| m.clean((@@model_id += 1)) }
  end
 
  class MetaFeature
    attr_reader :rumi_type
    attr_reader :name
    def initialize(feature_name, meta_type)
      @name = feature_name
      @rumi_type = meta_type 
    end
        
    def rumi_is_multivalued?
      self.name =~ /s$/ 
    end
  end
 
  module TestMetaclass
    attr_accessor :model_id
  
    def clean(id)
      self.model_id = id
      @all_objects = nil
    end
    
    # RUMI interface
    def all_objects
      @all_objects ||= []
    end

    # RUMI interface
    def rumi_conforms_to?(metaclass)
      self.new.kind_of?(metaclass)
    end
    
    def self.extended(klass)
      klass.class_eval %{
        include TestModelObject
        class << self
          alias_method :old_new, :new
          def new(*args)
            obj = old_new(*args)
            self.all_objects << obj
            obj
          end          
        end  
      }
    end
    
    def features
      @features ||= {}
    end
    
    def feature(name, type)
      self.features[name] = MetaFeature.new(name, type)
      self.send(:attr_accessor, name)
    end
    
    def rumi_property_by_name(name)
      raise "Invalid property #{name}" unless self.features[name]
      self.features[name]
    end
  end
  
  module TestModelObject
    def metaclass; self.class; end
    def rumi_kind_of?(type); self.kind_of?(type); end
    def rumi_model_id; self.metaclass.model_id; end
    def rumi_reference_value_set(feature, instances) 
      if feature.rumi_is_multivalued?
        self.send("#{feature.name}=", []) if self.send(feature.name).nil? 
        [*instances].each { |i| self.send(feature.name) << i }  
      else
        raise "Error" if instances.size > 1
        self.send("#{feature.name}=", instances[0])
      end       
    end
  end

  module Family
    def self.clean(model_id)
      [Man, Woman, Child].each { |c| c.clean(model_id) }
    end
        
    class Man
      extend TestMetaclass
      attr_accessor :name
      
      def initialize(values = {}) 
        values.each do |key, value|
          self.send("#{key}=", value)
        end
      end           
    end
    
    class Woman
      extend TestMetaclass 
    end
    
    class Child
      extend TestMetaclass    
    end 
  end
  
  module Tree
    def self.clean(model_id)
      [Root, Node, ExtendedNode].each { |c| c.clean(model_id) }
    end

    class Node
      extend TestMetaclass
      feature 'subchilds', Node 
    end
       
    class ExtendedNode < Node
    
    end
    
    class Root
      extend TestMetaclass
      
      feature 'childs', Node 
    end    
  end
  
end


module RuleCreationHelper

  def create_rule(klass, phase = @test_phase, name = 'no_name')
    rule = klass.new(phase, name)  
    rule.prepare
    rule
  end

  def create_man2nodes_rule(klass, phase = @test_phase)
    rule = create_rule(klass, phase, 'to2')
    rule.from_part = RubyTL::Rtl::FromPart.new([TestMetamodels::Family::Man])
    rule.to_part   = RubyTL::Rtl::ToPart.new([TestMetamodels::Tree::Node, TestMetamodels::Tree::ExtendedNode])  
    rule
  end

  def create_woman2single_node_rule(klass, phase = @test_phase)
    rule = create_rule(klass, phase, 'woman2single_node')
    rule.from_part = RubyTL::Rtl::FromPart.new([TestMetamodels::Family::Woman])
    rule.to_part   = RubyTL::Rtl::ToPart.new([TestMetamodels::Tree::Node])  
    rule
  end

  def create_man2single_node_rule(klass, phase = @test_phase)
    rule = create_rule(klass, phase, 'man2single_node')
    rule.from_part = RubyTL::Rtl::FromPart.new([TestMetamodels::Family::Man])
    rule.to_part   = RubyTL::Rtl::ToPart.new([TestMetamodels::Tree::Node])  
    rule
  end  
end