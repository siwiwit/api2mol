
def bridge_xml(name, &block)
  RubyTL::BridgeTask.new(name, &block)
end

module RubyTL
  class BridgeTask < BaseTaskLib
    attr_accessor :name
    attr_reader :collected_targets
    attr_reader :collected_input
    attr_reader :collected_bridge
    
    def initialize(name, &block)
      @collected_targets = []
      @collected_input = nil
      @collected_bridge = nil
      super(name, &block)  
    end

    # Add targets to the bridge. The target will have the form.
    #
    #     'Relational' => ['/path/to/model', '/path/to/metamodel']
    #
    # Serialization can be avoided if necessary (for instance, to save time in on-the-fly
    # transformation chains). To avoid serialization, use the the <tt>:memory</tt> symbol.
    #
    # == Examples
    #
    #    task.targets 'TableM' => [:memory, 'file:///tmp/TableM.emof']
    #
    def targets(target_hash)   
      collect_models(target_hash, @collected_targets)
    end

    # Specification of the input file to be transformed into a model. 
    #
    # == Example
    #
    #    task.input_file 'file:///tmp/state_machine.xml'
    #
    def input_xml(value)
      @collected_file = value
    end
    
    def input_bridge(value)
      @collected_bridge = value
    end
           
    def define
      define_task(name) do
        self.evaluate_bridge
      end
    end

    def evaluate_bridge
      xml_file = URI.parse(@@uri_resolver.resolve_as_local(@collected_file)).file_path
      context = Module.new do
        @@__doc__ = REXML::Document.new(File.new(xml_file))
        def self.document
          @@__doc__
        end
      end
      repository = RubyTL::Repository.new(HandlerRMOF.new, @@uri_resolver)
      self.collected_targets.each { |model| model.bind_as_target(repository, context) }

      bridge = URI.parse(@@uri_resolver.resolve_as_local(@collected_bridge)).file_path
      File.open(bridge, 'r') do |f|
        context.module_eval f.read
      end    

      collected_targets.select { |m| m.serializable? }.each do |model|
        model.serialize
      end       
    end

  end

end