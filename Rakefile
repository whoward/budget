# frozen_string_literal: true
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

APP_RAKEFILE = File.expand_path('dummy/Rakefile', __dir__)
load 'rails/tasks/engine.rake'

Bundler::GemHelper.install_tasks
