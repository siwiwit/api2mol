
module RubyTL
  module UML2
    module BaseImpl
    
      module ProfileExtension
        def nsURI
          self.name
        end

        # The same as EPackage
        # TODO: put in UML::Package
        def lookup_object(path_fragment) 
  
          unless @quick_classifiers
            @quick_classifiers = {}
            ownedStereotype.each do |c|        
              @quick_classifiers[c.name] = c
            end        
          end
          @quick_classifiers[path_fragment]
        end     
        
        def ownedStereotype
          self.ownedMember.select { |m| m.kind_of?(self.StereotypeClass) }
        end
      end
      
      # TODO: Move all to Class!!
      module StereotypeExtension
        include RMOF::ObjectHelper

        def ePackage
          raise "No container" unless self.__container__
          self.__container__
        end 

        def abstract
          self.isAbstract 
        end
        
        def property(name)
          attribute = self.ownedAttribute.find { |a| a.name == name }
          raise "No attribute '#{name}'" unless attribute      
          return attribute
        end
    
        def property_exist?(name)
          attribute = self.ownedAttribute.find { |a| a.name == name }   
        end
    
        def all_attributes
          # TODO: Do it properly
          self.ownedAttribute# + self.eSuperTypes.map { |t| t.all_attributes }.flatten
        end
    
        # TODO: Remove this and fix bugs properly, the common interface should be enough
        def getEStructuralFeature(name)
          property(name)
        end
      end
   
      module PropertyExtension
        def eType
          self.type
        end
        
        def multivalued?
          if v = self.upperValue
            if v.respond_to? :value 
              return v.value > 1
            end
          end
          return false
        end
        
        def is_reference?
          self.association != nil
        end
        
        def is_attribute?
          ! is_reference?
        end
        
        def eOpposite
          self.opposite
        end
        
        def containment 
          self.isComposite
        end
      end
   
    end
  end
end