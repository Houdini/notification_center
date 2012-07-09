require 'spec_helper'

describe NotificationCenter do
  describe '.post_notification' do
    before { NotificationCenter.flush_cache! }

    it "should fire event handler" do
      EventListener = Class.new { observe :event }
      EventListener.should_receive(:event_handler)
      NotificationCenter.post_notification :event
    end

    it "should not raise any exception when no event" do
      NotificationCenter.post_notification :imaginary_event
    end

    it "should not fire event twice" do
      EventListener2 = Class.new { observe :event2 }
      EventListener2.should_receive(:event2_handler)

      NotificationCenter.post_notification :event2
      NotificationCenter.post_notification :event2
    end
  end
end
