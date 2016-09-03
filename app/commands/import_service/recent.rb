# frozen_string_literal: true

module Budget::Command
  module ImportService
    class Recent
      def initialize(options)
        @options = options
      end

      def call
        latest = newest_imported_date

        if latest.nil?
          logger.info 'No records have ever been imported, importing everything!'
        else
          options[:since] = latest.last_week
          logger.info "importing from #{options[:since]}"
        end

        All.new(options).call
      end

      private

      attr_reader :options

      def newest_imported_date
        [
          Budget::TransactionRecord.max(:date),
          Budget::ImportableTransactionRecord.max(:date)
        ].max
      end

      def logger
        options.fetch(:logger, Logger.null)
      end
    end
  end
end
