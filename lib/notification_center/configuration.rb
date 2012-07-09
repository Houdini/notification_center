module NotificationCenter
  module Configuration
    VALID_OPTIONS_KEYS = [:enable_cache, :enable_notifications]

    DEFAULT_ENABLE_CACHE = false
    DEFAULT_ENABLE_NOTIFICATIONS = true

    attr_accessor *VALID_OPTIONS_KEYS

    def configure
      yield self
    end

    def self.extended base
      base.reset
    end

    def reset
      self.enable_cache = DEFAULT_ENABLE_CACHE
      self.enable_notifications = DEFAULT_ENABLE_NOTIFICATIONS
      self
    end
  end
end
