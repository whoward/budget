# frozen_string_literal: true

module Budget
  class DailySummaryDecorator < ApplicationDecorator
    def date
      object.date.strftime("%b #{object.date.day.ordinalize}")
    end

    def summary
      if object.overbudget?
        "You are #{overbudget_total} overbudget in #{h.pluralize overbudget_categories.count, 'category'}"
      else
        "You're on track!"
      end
    end

    def total_budgeted_spending
      dollars(compliance.total_budgeted_spending)
    end

    def spending_progress_bar
      Budget::HtmlEmail::ProgressBar.new(value: compliance.total_budgeted_spending, total: budget.total)
    end

    def overbudget_total
      dollars(overbudget_cents)
    end

    def overbudget_categories
      compliance.overbudget.map { |cat_id, diff| CategoryRowDecorator.new(cat_id, diff, budget) }
    end

    def remaining_days_header
      "There #{days_remaining == 1 ? 'is' : 'are'} #{h.pluralize days_remaining, 'day'} left in the month"
    end

    def remaining_days_progress_bar
      Budget::HtmlEmail::ProgressBar.new(value: day_in_month, total: days_in_month)
    end

    private

    delegate :compliance, :budget, :days_remaining, :day_in_month, :days_in_month

    def dollars(cents)
      h.cents_to_currency(cents, precision: 0)
    end

    def overbudget_cents
      compliance.overbudget_total
    end

    class CategoryRowDecorator < ApplicationDecorator
      delegate :name, to: :cat

      def initialize(category_id, diff, budget)
        @cat = Budget::CategoryRecord[category_id]
        @diff = diff
        @budget = budget
      end

      def budget_amount
        h.cents_to_currency cat.budgeted_cents, precision: 0
      end

      def overbudget_amount
        h.cents_to_currency diff + cat.budgeted_cents, precision: 0
      end

      def transactions_url
        query = {
          date_gteq: budget.period.first.strftime('%Y-%m-%d'),
          date_lteq: budget.period.last.strftime('%Y-%m-%d'),
          category_id_eq: cat.id
        }

        h.transactions_url(q: query)
      end

      private

      attr_reader :cat, :diff, :budget
    end
  end
end
