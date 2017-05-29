# frozen_string_literal: true

module Budget
  module Command
    module Account
      class Create
        def initialize(params)
          @params = params
        end

        def call
          AccountRecord.new(params).save
        end

        private

        attr_reader :params
      end
    end
  end
end
