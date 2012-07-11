require 'set'

module NotificationCenter
  class Cache
    class << self
      def flush_cache!
        @cache = nil
      end

      def open_cache
        @cache ||= Set.new
      end

      def include? key
        open_cache.include? key
      end

      def << key
        open_cache << key
      end
    end

    def initialize app
      @app = app
    end

    def call env
      @app.call env
    ensure
      self.class.flush_cache!
    end
  end
end
