# frozen_string_literal: true

module Budget
  module Calculator
    class BudgetCompliance
      def initialize(budget)
        @budget = budget
      end

      def result
        @result ||= totals.map { |cat_id, total| [cat_id, budget[cat_id] - total] }.to_h
      end

      def overbudget
        result.select { |_, total| total.negative? }
              .map { |cat, total| [cat, total.abs] }
              .to_h
      end

      def overbudget_total
        overbudget.values.sum
      end

      def total_budgeted_spending
        totals.sum(&:last)
      end

      private

      attr_reader :budget

      def totals
        @totals ||= Calculator::CategorizedTotals.new(
          transactions_dataset: ExpenseRecord.where(date: budget.period),
          categories_dataset: CategoryRecord.non_fixture.budgeted
        ).result
      end
    end
  end
end
