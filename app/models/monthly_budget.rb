# frozen_string_literal: true

module Budget
  class MonthlyBudget
    include Enumerable

    delegate :[], to: :data

    def initialize(year, month)
      @year = year
      @month = month
    end

    def period
      TimePeriod.month(year, month)
    end

    def total
      data.values.sum
    end

    def each(*args, &block)
      data.each(*args, &block)
    end

    private

    attr_reader :year, :month

    def data
      @data ||= DB[:budget_categories].exclude(budgeted_cents: nil)
                                      .select_hash(:id, :budgeted_cents)
    end
  end
end
