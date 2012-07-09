$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require 'pry'
require 'notification_center'

RSpec.configure do |config|
  config.before do
    NotificationCenter.forget_observers!
    NotificationCenter.reset
  end
end
