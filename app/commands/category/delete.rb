# frozen_string_literal: true

module Budget
  module Command
    module Category
      class Delete
        def initialize(category)
          @category = Cast::CategoryRecord(category)
        end

        def call
          category.destroy
        end

        private

        attr_reader :category
      end
    end
  end
end
