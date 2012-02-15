module RubyTL 
  module MMDef

    class LanguageDefinition < RubyTL::LowLevelDSL::DslDefinition      
      
      keyword('rule') { param :name, :id, :one }
      keyword('from') { param 'type', :class, :one }
      keyword('text') { catch_block }
      keyword('filter') { catch_block }
      keyword('param') { param :names, :id, :many}
      keyword('ignore') { param :what, :any, :one }
      
      root_composition do
        contain_keyword 'rule'
      end

      composition_for 'rule' do
        contain_keyword 'param'
        contain_keyword 'from'
        contain_keyword 'ignore'
      end
      
      composition_for 'from' do
        contain_keyword 'filter'
        contain_keyword 'text'
      end

      visitor_semantics do
      end
    end
  end
end