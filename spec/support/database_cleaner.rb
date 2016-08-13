# frozen_string_literal: true

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.around(:each) do |example|
    # load the seeds if there aren't any fixtures
    load File.expand_path('../../db/seeds.rb', __dir__) if Budget::Category.count.zero?

    # use transactions by default, unless the test specifies a custom strategy
    DatabaseCleaner.strategy = example.metadata.fetch(:database_cleaning_strategy, :transaction)

    DatabaseCleaner.cleaning { example.run }
  end
end
