module NotificationCenter
  module Configuration
    VALID_OPTIONS_KEYS = [:enable_cache, :enable_notifications, :method_suffix]

    DEFAULT_ENABLE_CACHE = false
    DEFAULT_ENABLE_NOTIFICATIONS = true
    DEFAULT_METHOD_SUFFIX = 'handler'

    attr_accessor *VALID_OPTIONS_KEYS

    def self.extended base
      base.reset
    end

    def reset
      self.enable_cache = DEFAULT_ENABLE_CACHE
      self.enable_notifications = DEFAULT_ENABLE_NOTIFICATIONS
      self.method_suffix = DEFAULT_METHOD_SUFFIX
      self
    end
  end
end
