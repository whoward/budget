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

    def total_spending
      @total_spending ||= ExpenseRecord.where(date: budget.period).sum(:cents)
    end

    def average_recent_income
      @average_recent_income ||= Budget::Calculator::AverageMonthlyTotals.new(
        Budget::IncomeRecord.where(date: previous_6_months),
        trim: 20
      ).result
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

    private

    def previous_6_months
      last_month = date.last_month

      (last_month - 5.months).at_beginning_of_month..last_month.at_end_of_month
    end
  end
end
