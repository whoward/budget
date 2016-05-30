# frozen_string_literal: true

# load factory girl factories for this project
require 'budget/factory_girl'

RSpec.configure do |config|
  # Include FactoryGirl helpers
  config.include FactoryGirl::Syntax::Methods

  # Before running the suite build all factory objects and ensure they are #valid?
  config.before(:suite) do
    DatabaseCleaner.cleaning { FactoryGirl.lint }
  end
end
