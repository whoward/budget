# frozen_string_literal: true

module Budget
  module Command
    module Category
      class Create
        def initialize(params)
          @params = params
        end

        def call
          CategoryRecord.new(params).save
        end

        private

        attr_reader :params
      end
    end
  end
end
