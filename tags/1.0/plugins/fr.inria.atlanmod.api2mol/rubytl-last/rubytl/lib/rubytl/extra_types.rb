#
# This file contains the definition of non-model types that can
# be used within a transformation as if they were normal
# model types.
#
module RubyTL
  module Rtl
    module Types
    
      # A module containing factory methods to create
      # collections of a specific type.
      # 
      # == Example
      # 
      #   RubyTL::Types::CollectionFactory.create_sequence(MyMetaclass)
      # 
      module CollectionFactory
        def self.create_sequence(klass, transformation = nil)
          CollectionProxy.new(klass, Sequence, transformation)
        end
      end
      
      class CollectionProxy
        def initialize(metaclass, collection_klass, transformation = nil)
          @metaclass = metaclass
          @collection_klass = collection_klass
          @transformation = transformation
        end
        
        def new(linking_callback = nil)
          @collection_klass.new(@metaclass, @transformation, linking_callback)
        end

        def rumi_conforms_to?(klass)
          @metaclass.rumi_conforms_to?(klass)
        end
        
        def metaclass; @metaclass; end
      end
      
      class Sequence < Array
        attr_reader :metaclass
        
        def initialize(metaclass, transformation = nil, linking_callback = nil)
          super()
          @metaclass = CollectionMetaclass.new(metaclass)
          @transformation = transformation
          @linking_callback = linking_callback
        end

        def rumi_model_id
          @metaclass.rumi_model_id
        end        

        alias_method :old_add, :<<         
        def <<(value)
          old_add(value)
          @linking_callback.call(value) if @linking_callback
        end
        
        def values=(array)
          raise "No transformation set" unless @transformation
          [*array].each do |instance|
            #if instance.rumi_kind_of?(@metaclass.instance_variable_get("@metaclass"))
            #  self << instance 
            #else
              binding = RubyTL::Rtl::BindingAssignment.new(instance, self, 'add_value')       
              @transformation.resolve_binding(binding)
            #end
          end
        end        
        
        def rumi_reference_value_set(feature, instance)
          #if instance.kind_of?(Array)
          #  puts instance.first.metaclass.name
          #  xxx
          #end
          # TODO: Por qu� pasa esto en RubyTL2ATC  
          [*instance].flatten.each { |i| self << i }        
          #self << instance
        end
      end
  
      class CollectionMetaclass
        Feature = Struct.new(:rumi_type, :name)
        
        attr_reader :metaclass
        
        def initialize(metaclass)
          @metaclass = metaclass
        end
        
        def name
          "Collection[#{@metaclass.name}]"
        end
        
        def rumi_model_id
          @metaclass.rumi_model_id
        end
        
        def rumi_property_by_name(name)
          return Feature.new(@metaclass, 'add') if name == 'add_value'
        end
      end
  
    end
  end
end