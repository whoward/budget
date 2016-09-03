# frozen_string_literal: true

namespace :import do
  def service(klass, options)
    klass.new(options.merge(logger: logger))
  end

  def all(options)
    service(Budget::Command::ImportService::All, options)
  end

  def since(options)
    service(Budget::Command::ImportService::Recent, options)
  end

  def logger
    Budget::Logger.console
  end

  desc 'import from all sources since the earliest point in time'
  task(all: :environment) { all.call }

  desc 'import from all sources since 1 week prior to the most recent transaction in the system'
  task(recent: :environment) { recent.call }

  desc 'import from all sources since the passed date'
  task :since, [:year, :month, :day] => :environment do |_task, args|
    date = Date.new(args[:year].to_i, args[:month].to_i, args[:day].to_i)

    logger.info "importing from #{date}"

    all(since: date).call
  end
end
