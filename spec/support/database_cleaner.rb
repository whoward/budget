# frozen_string_literal: true

RSpec.configure do |config|
  config.around(:each) do |example|
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.cleaning { example.run }
  end
end
