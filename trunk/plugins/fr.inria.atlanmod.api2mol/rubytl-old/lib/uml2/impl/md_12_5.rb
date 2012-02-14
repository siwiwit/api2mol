
module RubyTL
  module MD_12_5
    module Uml2

      class Profile
        include RubyTL::UML2::BaseImpl::ProfileExtension
        def StereotypeClass; Stereotype; end
      end
      
      class Stereotype
        include RubyTL::UML2::BaseImpl::StereotypeExtension
      end
    
      class Property
        include RubyTL::UML2::BaseImpl::PropertyExtension
      end

      class DataType
        def self.rumi_conforms_to?(metaclass)
          metaclass = metaclass.real_klass if metaclass.respond_to? :real_klass
          self == metaclass 
        end
      end
      
      class PrimitiveType
        def self.rumi_conforms_to?(metaclass)
          metaclass = metaclass.real_klass if metaclass.respond_to? :real_klass
          self == metaclass || DataType.rumi_conforms_to?(metaclass)
        end      
      end

      [String, Integer].each do |m|
        m.module_eval %{
          def self.metaclass
            PrimitiveType
          end
          
          def self.rumi_kind_of?(metaclass)
            return true if metaclass == DataType ||
                           metaclass == PrimitiveType
          end 
          
          def self.name
            self.non_qualified_name
          end
        }
      end
    
    end
  end
end
