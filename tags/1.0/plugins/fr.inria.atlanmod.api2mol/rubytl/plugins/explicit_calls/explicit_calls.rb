
class Rule
  def after_definition
    method = <<-END_OF_CODE
              #def self.#{name}(instance)
                  rule = transformation_.rule_by_name("#{name}")
                  tuple_instance = Tuple.new(instance)
                  result = rule.create_and_link(tuple_instance)
                  rule.apply(tuple_instance, result)
                  result
              #end         
    END_OF_CODE
    syntax.create_method(self.name, :instance, method)
  end
end
