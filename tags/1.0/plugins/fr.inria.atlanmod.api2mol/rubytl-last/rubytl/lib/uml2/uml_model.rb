# TODO: It would be a good idea to factorize RMOF parsers to allow
# the creation of an specific kind of model
=begin
module RubyTL
  module UML2

    class Model < RMOF::Model

      # Override the default RMOF::Model#fragment_as_model, so that
      # it returns an UML2::Model instead of a RMOF::Model
      def fragment_as_model(fragment_path)
        unless package = @xmi_id_map[fragment_path]
          package = lookup_object(fragment_path)
        end        
        return RubyTL::UML2::Model.new(package.name, [package]) 
      end
          
    end

  end
end
=end

# TODO: THIS IS JUST A TEMPORAL HACK
# I don't think packages are supported
module RubyTL
  class HandlerRMOF2
    alias_method :old_fill_proxy, :fill_proxy 
    def fill_proxy(proxy, model)
      old_fill_proxy(proxy, model)
      if model.referenced_models.any? { |m| m.uri == 'http://schema.omg.org/spec/UML/2.0' ||
                                            m.uri == 'http://www.eclipse.org/uml2/2.1.0/UML' }
        complete_sterotypes(proxy, model)                                   
      end                                            
    end
    
    # TODO: Identify the sterotypes by other means, probably the getting the profile and...
    def complete_sterotypes(proxy, model)
      model.objects.each { |obj| obj.extend(ModelObject_Profile_Extension) }
      
      model.root_elements.each do |element|
        attr = element.metaclass.all_attributes.find { |attr| attr.name =~ /base_(\w+)/ }
        if attr
          obj = element.send(attr.name)
          obj.add_stereotype(element.metaclass)
          element.metaclass.all_attributes.each do |a|
            obj.tags[a.name] = element.send(a.name) if a != attr               
          end
        end
      end
    end
  end
  
  module ModelObject_Profile_Extension
    def appliedSterotypes
      @appliedSterotypes ||= Set.new
    end
    
    def add_stereotype(sterotype)
      self.appliedSterotypes << sterotype
    end
    
    def sterotyped?(name)
      self.appliedSterotypes.any? { |s| s.name == name }
    end
    
    def tags
      @tagValues ||= {}
    end

  end
  
end    