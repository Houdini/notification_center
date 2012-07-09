# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "notification_center/version"

Gem::Specification.new do |s|
  s.name        = "notification_center"
  s.version     = NotificationCener::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Dmitrii Golub"]
  s.email       = ["dmitrii.golub@gmail.com"]
  s.homepage    = "http://github.com/Houdini/notification_center"
  s.summary     = %q{Observer pattern for ruby}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency("bundler")
  s.add_development_dependency("rspec", "~> 2.10.0")
  s.add_development_dependency("pry")
end
