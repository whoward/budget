# frozen_string_literal: true

module Budget
  module Command
    module ImportService
      class Create
        def initialize(params)
          @params = params
        end

        def call
          ImportServiceRecord.new(params).save
        end

        private

        attr_reader :params
      end
    end
  end
end
