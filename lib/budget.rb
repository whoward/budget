# frozen_string_literal: true
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

require 'budget/awesome_nested_set_tree'
require 'budget/casts'
require 'budget/engine'
require 'budget/month_enumerator'
require 'budget/null_logger'
require 'budget/preferable'
require 'budget/report'
require 'budget/service'
require 'budget/service_response'
require 'budget/transaction_factory'
require 'budget/transaction_similarity_analyzer'
require 'budget/transferize_policy'

require 'budget/models/account'
require 'budget/models/category'
require 'budget/models/import_service'
require 'budget/models/importable_account'
require 'budget/models/importable_category'
require 'budget/models/importable_transaction'
require 'budget/models/preference'
require 'budget/models/transaction'

require 'budget/decorators/paging_decorator'
require 'budget/decorators/application_decorator'
require 'budget/decorators/transaction_decorator'
require 'budget/decorators/account_decorator'

module Budget
  def self.configure
    yield self
  end

  mattr_accessor :mail_recipient
end
