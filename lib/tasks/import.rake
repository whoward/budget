# frozen_string_literal: true

namespace :import do
  def service(options)
    headless = ENV.fetch('XVFB', 'false') == 'true'

    Budget::Service::ImportAll.new(headless: headless, options: options)
  end

  desc 'import from all sources since the earliest point in time'
  task all: :environment do
    service(force_refresh: true).call
  end

  desc 'import from all sources since 1 week prior to the most recent transaction in the system'
  task recent: :environment do
    max = [Budget::Transaction.maximum(:date), Budget::ImportableTransaction.maximum(:date)].max

    service(since: max.at_beginning_of_day - 1.week).call
  end

  desc 'import from all sources since the value in the SINCE environment variable'
  task since: :environment do
    since = Chronic.parse(ENV.fetch('SINCE'))

    print "Did you mean #{since.strftime('%b %d %Y')}? <Y/N>"

    exit unless $stdin.readline.strip.casecmp('y').zero?

    service(since: since).call
  end
end
