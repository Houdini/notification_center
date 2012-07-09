module NotificationCenter
  module RspecHelpers
    Rspec.configure do |config|
      config.around(:each) do |spec|
        NotificationCenter.enable_notifications = false if spec.metadata[:notifications] == false
        spec.call
        NotificationCenter.enable_notifications = true if spec.metadata[:notifications] == false
      end
    end
  end
end
