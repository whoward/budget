# frozen_string_literal: true

def load_directory(path)
  Pathname(path).find.select { |p| p.extname == '.rb' }.each { |f| require f }
end

def load_app_directory(name)
  load_directory Pathname(__dir__).join('..', 'app', name)
end

module Budget
  def self.configure
    yield self
  end

  # the default error handler just swallows it
  DEFAULT_ERROR_HANDLER = -> (_) {}

  mattr_accessor :mail_recipient

  mattr_accessor(:error_handler) { DEFAULT_ERROR_HANDLER }
end

require 'haml'
require 'twitter-bootstrap-rails'
require 'bootstrap_form'

require 'jquery-turbolinks'
require 'turbolinks'

require 'kaminari'
require 'bootstrap-kaminari-views'

require 'ransack'

require 'awesome_nested_set'

require 'draper'

require 'csv'

%w(bootstrap select2 highcharts papaparse handlebars accountingjs).each do |asset|
  require "rails-assets-#{asset}"
end

require 'budget/engine'

require 'budget/awesome_nested_set_tree'
require 'budget/cast'
require 'budget/db'
require 'budget/month_enumerator'
require 'budget/logger'
require 'budget/preferable'
require 'budget/service_response'
require 'budget/transaction_factory'
require 'budget/transaction_similarity_analyzer'
require 'budget/transferize_policy'
require 'budget/time_period'

require 'budget/refinements/statistics'

load_app_directory 'calculators'
load_app_directory 'casts'
load_app_directory 'commands'
load_app_directory 'models'
load_app_directory 'decorators'
load_app_directory 'reports'
load_app_directory 'view_models'
