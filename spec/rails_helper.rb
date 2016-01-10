# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../dummy/config/environment', __FILE__)
require 'rspec/rails'

# Checks for pending migrations before tests are run.
ActiveRecord::Migration.maintain_test_schema!

# Load seeds
require File.expand_path('../db/seeds', __dir__)

# load factory girl factories for this project
require 'budget/factory_girl'

# load all files in the support/ directory (and subdirectories thereof)
Dir[Pathname(__dir__).join('support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # automatically infers the spec type (controller, model, etc) from the directory
  config.infer_spec_type_from_file_location!

  # Include FactoryGirl helpers
  config.include FactoryGirl::Syntax::Methods

  # Before running the suite build all factory objects and ensure they are #valid?
  config.before(:suite) do
    DatabaseCleaner.cleaning { FactoryGirl.lint }
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
