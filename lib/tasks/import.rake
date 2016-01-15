require 'logger'

namespace :import do
  def import_from_active_services!(options)
    Budget::ImportService.active.each { |service| service.call(options) }
  end

  def import!(options)
    options[:logger] = Logger.new($stdout)

    if ENV['XVFB'].present?
      Headless.ly(display: '99') { import_from_active_services!(options) }
    else
      import_from_active_services!(options)
    end

    return unless [Budget::ImportableAccount, Budget::ImportableTransaction].any? { |model| model.not_imported.any? }

    Budget::ApplicationMailer.review_reminder.deliver
  end

  desc 'import from all sources since the earliest point in time'
  task all: :environment do
    import! force_refresh: true
  end

  desc 'import from all sources since 1 week prior to the most recent transaction in the system'
  task recent: :environment do
    max = [Budget::Transaction.maximum(:date), Budget::ImportableTransaction.maximum(:date)].max

    import! since: max.at_beginning_of_day - 1.week
  end

  desc 'import from all sources since the value in the SINCE environment variable'
  task since: :environment do
    since = Chronic.parse(ENV.fetch('SINCE'))

    print "Did you mean #{since.strftime('%b %d %Y')}? <Y/N>"

    exit unless $stdin.readline.strip.downcase == 'y'

    import! since: since
  end
end
