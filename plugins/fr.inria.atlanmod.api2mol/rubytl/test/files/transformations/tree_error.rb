
#module TreeError

rule 'STree' do
  from STree::Tree
  to   TTree::Tree
  mapping do |x, y|
    var_that_doesnt_exist
  end
end

#end