# frozen_string_literal: true

module Budget
  class ExpenseRecord < Sequel::Model
    set_dataset DB[:budget_transactions].where(type: 'Budget::Expense')
  end
end
