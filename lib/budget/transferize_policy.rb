
# frozen_string_literal: true
module Budget
  class TransferizePolicy
    def initialize(from, to)
      @from = from
      @to = to
    end

    def validate
      catch(:invalid) do
        from_is_expense &&
          to_is_income &&
          amount_is_equal &&
          account_is_different
      end
    end

    private

    attr_reader :from, :to

    def from_is_expense
      [Expense, ExpenseRecord].include?(from.class) || throw(:invalid, :from_isnt_expense)
    end

    def to_is_income
      [Income, IncomeRecord].include?(to.class) || throw(:invalid, :to_isnt_income)
    end

    def amount_is_equal
      from.cents == to.cents || throw(:invalid, :amount_isnt_equal)
    end

    def account_is_different
      from.account_id != to.account_id || throw(:invalid, :account_isnt_different)
    end
  end
end
