require 'logger'

namespace :import do
  def import_from_active_services!(options)
    ImportService.active.each { |service| service.call(options) }
  end

  def import!(options)
    options[:logger] = Logger.new($stdout)

    if ENV['XVFB'].present?
      Headless.ly(display: '99') { import_from_active_services!(options) }
    else
      import_from_active_services!(options)
    end

    return unless [ImportableAccount, ImportableTransaction].any? { |model| model.not_imported.any? }

    ApplicationMailer.review_reminder.deliver
  end

  task all: :environment do
    import! force_refresh: true
  end

  task recent: :environment do
    max = [Transaction.maximum(:date), ImportableTransaction.maximum(:date)].max

    import! since: max.to_time - 1.week
  end

  task since: :environment do
    since = Chronic.parse(ENV.fetch('SINCE'))

    print "Did you mean #{since.strftime('%b %d %Y')}? <Y/N>"

    exit unless $stdin.readline.strip.downcase == 'y'

    import! since: since
  end
end
