require 'notification_center/core_ext/module'
require 'notification_center/configuration'
require 'notification_center/cache'

module NotificationCenter
  extend Configuration
  class << self
    def events; @@events end
    def events= hash; @@events = hash end

    def _initialize_event_store
      @@events = Hash.new Array.new
    end
    alias :forget_observers! :_initialize_event_store

    def post_notification *args
      event = args.shift
      if enable_notifications
        enable_cache ? _with_cache(event){ _notify! event, *args } : _notify!(event, *args)
      end
    end

    def _notify! event, *args
      event_handler = "#{event}_#{method_suffix}"
      receivers = @@events[event]
      for receiver in receivers
        receiver.send event_handler, *args
      end
    end

    def _with_cache event
      unless NotificationCenter::Cache.include? event
        yield
        NotificationCenter::Cache << event
      end
    end
  end
  self._initialize_event_store
end
