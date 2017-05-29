# frozen_string_literal: true

module Budget
  module Command
    module ImportService
      class Delete
        def initialize(service)
          @service = Cast::ImportServiceRecord(service)
        end

        def call
          service.destroy
        end

        private

        attr_reader :service
      end
    end
  end
end
