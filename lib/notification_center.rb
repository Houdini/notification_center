require 'notification_center/core_ext/module'
require 'set'

module NotificationCenter
  @@events = Hash.new Array.new
  @@enable_notifications = true

  class << self
    def events; @@events end
    def events= hash; @@events = hash end

    def enable_notifications; @@enable_notifications = true end
    def disable_notifications; @@enable_notifications = false end

    def flush_cache!; @cache = nil end

    def post_notification *args
      event = args.shift

      with_cache(event) do
        event_handler = "#{event}_handler"
        receivers = @@events[event]

        for receiver in receivers
          args.size == 0 ? receiver.send(event_handler) : receiver.send(event_handler, *args)
        end
      end if @@enable_notifications
    end

    def with_cache event
      @cache ||= Set.new
      yield unless @cache.include? event
      @cache << event
    end
  end
end
