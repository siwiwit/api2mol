

class CopyRule < DefaultRule
  
  def on_application(source_element, target_elements)
    if target_elements.flatten.size > 0
      @status.add_trace([*source_element], target_elements, self)  
    end

    evaluate_mapping_helper(source_element, target_elements)
    return target_elements    
  end  
 
end

