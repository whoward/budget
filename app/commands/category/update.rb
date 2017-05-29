# frozen_string_literal: true

module Budget
  module Command
    module Category
      class Update
        def initialize(category, params)
          @category = Cast::CategoryRecord(category)
          @params = params
        end

        def call
          category.update(params)
        end

        private

        attr_reader :category, :params
      end
    end
  end
end
