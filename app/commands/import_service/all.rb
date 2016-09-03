# frozen_string_literal: true

module Budget
  module Command
    module ImportService
      class All
        def initialize(options)
          @options = options
        end

        def call
          services.each { |service| Execute.new(service, options).call }
          deliver_notification if notify?
        end

        private

        attr_reader :options

        def services
          @services ||= ImportServiceRecord.to_a
        end

        def deliver_notification
          logger.info 'delivering notification'
          ApplicationMailer.review_reminder.deliver
        end

        def notify?
          [
            ImportableAccountRecord,
            ImportableTransactionRecord
          ].any? { |model| model.not_imported.count > 0 }
        end

        def logger
          options.fetch(:logger, Logger.null)
        end
      end
    end
  end
end
