# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'
require File.expand_path('../../dummy/config/environment', __FILE__)

require 'rspec/rails'

# Checks for pending migrations before tests are run.
ActiveRecord::Migration.maintain_test_schema!

# Load seeds
DatabaseCleaner.clean_with(:truncation)
require File.expand_path('../db/seeds', __dir__)

# load all files in the support/ directory (and subdirectories thereof)
Dir[Pathname(__dir__).join('support/**/*.rb')].each { |f| require f }
