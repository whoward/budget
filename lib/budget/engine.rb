require 'haml'
require 'twitter-bootstrap-rails'
require 'bootstrap_form'

require 'jquery-turbolinks'
require 'turbolinks'

require 'kaminari'
require 'bootstrap-kaminari-views'

%w(bootstrap select2 highcharts papaparse handlebars accountingjs).each do |asset|
  require "rails-assets-#{asset}"
end

module Budget
  class Engine < ::Rails::Engine
    isolate_namespace Budget
  end
end
