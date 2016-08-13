# frozen_string_literal: true

module Budget
  class DailySummary
    attr_reader :date

    def initialize(date: Time.zone.today)
      @date = date
    end

    def budget
      @budget ||= MonthlyBudget.new(date.year, date.month)
    end

    def compliance
      @compliance ||= Calculator::BudgetCompliance.new(budget)
    end

    def day_in_month
      date.day
    end

    def days_in_month
      Time.days_in_month(date.month, date.year)
    end

    def days_remaining
      days_in_month - date.day
    end

    def overbudget?
      compliance.overbudget_total.positive?
    end
  end
end
