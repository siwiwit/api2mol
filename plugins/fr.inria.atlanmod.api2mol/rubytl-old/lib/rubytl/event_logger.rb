
module RubyTL
  module Rtl
    
    class EmptyPhaseError < RubyTL::BaseError; end
    class ConflictingRulesError < RubyTL::BaseError; end
    class NoRuleFoundError < RubyTL::BaseError; end
    
    class EventKind
      attr_reader :message, :exception
      def initialize(message, exception)
        @message   = message
        @exception = exception
      end
      
      def normalize_message(*args)
        self.message.substitute(*args)
      end
    end        
        
    # This class receives events ocurred in a transformation
    # execution. The logger is configurable to decide how to
    # act before an event.
    # There are three possible decissions:
    # 
    # * Stop
    # * Warn the user 
    # * Ignore 
    # 
    class TLogger
      ACTIONS = [:stop, :warn, :ignore]
      EmptyPhase   = EventKind.new("Phase '{1}' without rules", EmptyPhaseError)       
      RuleConflict = EventKind.new("There are #{1} conflicting rules to resolve {2}", ConflictingRulesError)
      NoRuleFound  = EventKind.new("No applicable rules found to resolve {1}", NoRuleFoundError)
      
      def initialize(default_action)
        raise "Invalid action #{default_action}" unless ACTIONS.include?(default_action)
        @default_action = default_action
        @actions        = {}
      end
      
      def log_event(event, *args)        
        action = @actions[event] || @default_action
        do_according_to_action(action, event, *args)
      end
      
      def action_for_event(event_kind, action)
        raise "Invalid action #{default_action}" unless ACTIONS.include?(action)
        @actions[event_kind] = action
      end
      
    private
      def do_according_to_action(action, event, *args)
        msg = event.normalize_message(*args)
        case action
        when :stop   then raise event.exception.new(msg)
        when :warn   then $stderr << msg + $/
        #when :ignore then # do nothing 
        end
      end
    end

    # Mixin to provide easy access to a TLogger object.  
    module EventLogging
    
      # Sets the TLogger object used.
      def tlogger=(tlogger)
        @tlogger = tlogger
      end
      
      # Returns the current TLogger. If no object has been
      # set, a default TLogger is created.
      def tlogger
        @tlogger ||= TLogger.new(:stop)
      end
      
      def log_event(event, *args)
        tlogger.log_event(event, *args)
      end
    end
  
  end
end