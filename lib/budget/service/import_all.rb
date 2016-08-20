# frozen_string_literal: true
require 'logger'

module Budget
  module Service
    class ImportAll
      def initialize(headless: false, logger: build_logger, options: {})
        @headless = headless
        @options = options
        options[:logger] = logger
      end

      def call
        with_headless { import_all }
        deliver_notification if notify?
      end

      private

      attr_reader :headless, :options

      IMPORTABLES = [Budget::ImportableAccount, Budget::ImportableTransaction].freeze

      def build_logger
        logger = Logger.new($stdout)
        logger.level = Logger::DEBUG
        logger
      end

      def logger
        options[:logger]
      end

      def with_headless(&block)
        if headless
          logger.info 'running headlessly'
          Headless.ly(display: '99', &block)
        else
          logger.info 'running in desktop mode'
          yield
        end
      end

      def import_all
        Budget::ImportService.active.each(&method(:import))
      end

      def import(service)
        logger.info "starting import from #{service.name}"
        service.call(options)
      rescue StandardError => e
        logger.error "import failed: #{e.inspect}"
        logger.debug e.backtrace.join("\n")
        Budget.error_handler.call(e)
      end

      def deliver_notification
        logger.info 'delivering notification'
        Budget::ApplicationMailer.review_reminder.deliver
      end

      def notify?
        IMPORTABLES.any? { |model| model.not_imported.any? }
      end
    end
  end
end
