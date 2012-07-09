module NotificationCenter
  module CoreExt
    module Module
      def observe *events
        stored_events = NotificationCenter.events.dup
        for event in events
          next if stored_events.has_key? event
          stored_events[event] += Array self
          stored_events[event] = stored_events[event].uniq
        end
        NotificationCenter.events = stored_events
      end
    end
  end
end

::Module.__send__ :include, NotificationCenter::CoreExt::Module
