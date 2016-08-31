# frozen_string_literal: true

module Budget
  module Calculator
    class MonthlyTotals
      def initialize(transactions_dataset)
        @dataset = transactions_dataset
      end

      # group and sum by year/month and return as hash
      def result
        data.map { |row| [[row[:year].to_i, row[:month].to_i], row[:cents]] }
            .to_h
      end

      private

      attr_reader :dataset

      def data
        @data ||= dataset.select(
          Sequel.extract(:year, :date).as(:year),
          Sequel.extract(:month, :date).as(:month),
          Sequel.function(:sum, :cents).as(:cents)
        ).group(:year, :month)
      end
    end
  end
end
