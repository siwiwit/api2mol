
# Definition of which parameters may be
# set to the plugin
parameter do
  description 'Phases to be switched off'
  name :switched_off_phases
  type :off_elements # on_elements / on_off_elements
  datatype :id_list
  retrieve_elements do
    puts self.transformation_filename
    parse_tree(self.transformation_filename).lookup_keyword('phase').map do |keyword|
      if name = keyword.arguments.first
        [name, false] 
      end
    end.compact
  end
end

