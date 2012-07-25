require 'spec_helper'

describe NotificationCenter do
  describe '.post_notification' do
    before { NotificationCenter::Cache.flush_cache! }

    it "should fire event handler" do
      EventListener = Class.new { observe :event }
      EventListener.should_receive(:event_handler)
      NotificationCenter.post_notification :event
    end

    it "should not raise any exception when no event" do
      NotificationCenter.post_notification :imaginary_event
    end

    context 'when cache disabled' do
      before { NotificationCenter.enable_cache = false }

      it "should not fire event twice" do
        EventListener = Class.new { observe :event }
        EventListener.should_receive(:event_handler).twice

        NotificationCenter.post_notification :event
        NotificationCenter.post_notification :event
      end

      it "should return result" do
        EventListener = Class.new { observe :event }
        EventListener.should_receive(:event_handler).and_return(:result)
        NotificationCenter.post_notification(:event).should eql(:result)
      end
    end

    context 'when cache enabled' do
      before { NotificationCenter.enable_cache = true }

      it "should not fire event twice" do
        EventListener = Class.new { observe :event }
        EventListener.should_receive :event_handler

        NotificationCenter.post_notification :event
        NotificationCenter.post_notification :event
      end

      it "should return result" do
        EventListener = Class.new { observe :event }
        EventListener.should_receive(:event_handler).and_return(:result)
        NotificationCenter.post_notification(:event).should eql(:result)
      end
    end
  end
end
