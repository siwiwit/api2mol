
module Query
  def self.collector(obj)
    QueryPkg::QueryCollector.new(obj)
  end
  # Choose between these two styles: collector is more function-based,
  # from is more DSL based
  def self.from(obj)
    QueryPkg::FromCollector.new(obj)
  end
end

module QueryPkg
  module GenericCollector
  protected
    # TODO: Using containment, I don't need used
    def locate_type(obj, type, used, return_asap = false)
      objects = references(obj).map do |ref| 
        [*obj.get(ref)].reject { |o| used.key?(o) }
      end.flatten.compact
      objects.each { |o| used[o] = true }
      selected = objects.select { |o| o.rumi_kind_of?(type) }

      return do_asap(objects, selected, type, used) if return_asap 
      return selected + objects.map { |o| locate_type(o, type, used, return_asap) }.flatten
    end
    
    def references(obj)
      obj.metaclass.rumi_all_properties.select { |p| p.is_reference? && p.containment }
    end
    
    def do_asap(objects, selected, type, used)
      return selected.first if selected.size > 0
      objects.each do |o|
        v = locate_type(o, type, used, return_asap)
        return v if v
      end
      return nil      
    end
  end
  
  module ParentFinder
  protected
    def find_parent(obj, type)
      parent = obj.__container__      
      return nil if parent == nil
      return parent if parent.metaclass == type
      return find_parent(parent, type)
    end
  end
  
	class QueryCollector
	  include GenericCollector
    
	  def initialize(obj)
	    @obj = obj
      raise NilException.new("Null object not allowed") unless @obj      
	  end
	  
	  def all(type, &block)
	    result = locate_type(@obj, type, { @obj => true })
      result.each(&block) if block_given?
      result
	  end
	  
	  def first(type)
	    locate_type(@obj, type, { @obj => true }, true)
	  end
	end
  
  class FromCollector
    include ParentFinder
    
    def initialize(obj)
      @obj = obj
      raise NilException.new("Null object not allowed") unless @obj
    end
    
    def up_to(type)
      find_parent(@obj, type)
    end
    
    def up_to!(type)
      result = up_to(type)
      raise NoParentFound.new("No parent of type #{type.name}") unless result
      return result
    end
  end
  
  class NilException < RubyTL::BaseError; end
  class NoParentFound < RubyTL::BaseError; end
end