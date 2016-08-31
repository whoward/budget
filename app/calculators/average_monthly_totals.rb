# frozen_string_literal: true

module Budget
  module Calculator
    class AverageMonthlyTotals
      using Refinements::Statistics

      def initialize(transactions_dataset, trim: 0)
        @dataset = transactions_dataset
        @trim = trim
      end

      def result
        if trim.positive?
          monthly_totals.values.trimmed_mean(trim)
        else
          monthly_totals.values.mean
        end
      end

      private

      attr_reader :dataset, :trim

      def monthly_totals
        @monthly_totals ||= MonthlyTotals.new(dataset).result
      end
    end
  end
end
