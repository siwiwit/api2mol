
class TopRule < DefaultRule
  rule_keyword 'top_rule'
end


class Algorithm
  remove_entry_point_selection_filter :default_rule_selection
  append_entry_point_selection_filter :top_level_rule_selection
  
  def top_level_rule_selection(selected)
    transformation.rules.select { |r| r.kind_of?(TopRule) }.each do |r|
      selected << r
    end
    default_rule_selection(selected) if selected.empty?
  end

end
