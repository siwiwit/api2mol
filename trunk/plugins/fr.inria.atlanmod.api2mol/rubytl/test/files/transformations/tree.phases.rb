
transformation 'tree'

phase 'root_node' do
  top_rule 'root' do
    from STree::Tree
    to   TTree::Tree
    mapping do |source, target|
      # Ok. Nothing else
    end
  end
end

phase 'more_nodes' do
  refinement_rule 'ref_root' do
    from STree::Tree
    to   TTree::Tree
    mapping do |source, target|
      puts "==========> paso1"
      anode = TTree::Node.new
    end    
  end
end

phase 'last_phase' do
  refinement_rule 'ref_root' do
    from STree::Tree
    to   TTree::Tree
    mapping do |source, target|
      puts "==========> paso2"
      anode = TTree::Node.new
    end    
  end
end