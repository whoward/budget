# frozen_string_literal: true

module Budget
  class IncomeRecord < Sequel::Model
    set_dataset DB[:budget_transactions].where(type: 'Budget::Income')
  end
end
