## Notification/listener solution for ruby

## Features

* any number of listners
* only one event of one kind can be fired per request (cache)
* disable/enable events (nice feature for tests)

## Configuration for rails

In your Gemfile

```ruby
gem 'notification_center'
```

# Cache

To enable cache, in your:

config/initializers/notification_center.rb

```ruby
NotificationCenter.enable_cache = true # only one event fired in one request scope, default is false
```
Dont forget to flush cache wach request, for this in your config/application.rb in config section:
```ruby
config.middleware.use NotificationCenter::Cache
```

## Use

In any class or multiple classes:

```ruby
class SomeClass
  observe :some_event

  def some_event_handler # any number of args are possible
  end
end
```

Anywhere in code:

```ruby
NotificationCenter.post_notification :some_event
```

## Common practice

Create directory app/listeners and put listeners there, like user_listener.rb

```ruby
class UserListener
  observe :user_did_some_action
  
  def user_did_some_action_handler
    # some complex logic
  end
end
```

## Important

Make sure, that your classes are preloaded!
So for app/listeners, put this code to your application.rb

```ruby
Dir[Rails.root.join + 'app/listeners/*.rb'].map{|f| require f}
```

## For rspec

In your spec_helper.rb

```ruby
require 'notification_center/rspec_helpers'
```

Then you can use notifications: false in describe, context, it. Like:

```ruby
describe User, notifications: false do

it "should do smth", notifications: false do
```