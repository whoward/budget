# frozen_string_literal: true

module Budget
  class TransferizePolicy
    Invalid = Class.new(ArgumentError)

    def initialize(from, to)
      @from = from
      @to = to
    end

    def validate
      from_is_expense
      to_is_income
      amount_is_equal
      account_is_different
    end

    private

    attr_reader :from, :to

    def invalid(reason)
      raise Invalid, reason
    end

    def from_is_expense
      [Expense, ExpenseRecord].include?(from.class) || invalid(:from_isnt_expense)
    end

    def to_is_income
      [Income, IncomeRecord].include?(to.class) || invalid(:to_isnt_income)
    end

    def amount_is_equal
      from.cents == to.cents || invalid(:amount_isnt_equal)
    end

    def account_is_different
      from.account_id != to.account_id || invalid(:account_isnt_different)
    end
  end
end
