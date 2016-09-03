# frozen_string_literal: true

module Budget
  module Command
    module ImportService
      class Execute
        def initialize(service, options)
          @service = service
          @options = options
        end

        def call
          logger.info "starting import from #{service.name}"
          service.call(options)
        rescue StandardError => e
          logger.error "import failed: #{e.inspect}"
          logger.debug e.backtrace.join("\n")
          Budget.error_handler.call(e)
        end

        private

        attr_reader :service, :options

        def logger
          options.fetch(:logger, Logger.null)
        end
      end
    end
  end
end
