# frozen_string_literal: true

module Budget
  module Command
    module ImportService
      class Update
        def initialize(service, params)
          @service = Cast::ImportServiceRecord(service)
          @params = params
        end

        def call
          service.update(params)
        end

        private

        attr_reader :service, :params
      end
    end
  end
end
