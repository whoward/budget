# frozen_string_literal: true

module Budget
  module Calculator
    class CategorizedTotals
      def initialize(transactions_dataset:, categories_dataset:)
        @transactions_dataset = transactions_dataset
        @categories_dataset = categories_dataset
      end

      def result
        @result ||= fetch_data
      end

      private

      attr_reader :transactions_dataset, :categories_dataset

      def fetch_data
        categories.join_table(:left, transactions, [id: :category_id])
                  .select_hash(
                    :id,
                    Sequel.function(:coalesce, :total, 0).as(:total)
                  )
      end

      def transactions
        transactions_dataset.select_group(:category_id)
                            .select_more { Sequel.function(:sum, :cents).as(:total) }
      end

      def categories
        categories_dataset.select(:id)
      end
    end
  end
end
