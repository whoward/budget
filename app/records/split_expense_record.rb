# frozen_string_literal: true

module Budget
  class SplitExpenseRecord < Sequel::Model
    set_dataset DB[:budget_transactions].where(type: 'Budget::SplitExpenseTransaction')

    one_to_many :partitions, class: 'Budget::ExpenseRecord',
                             key: :split_transaction_id
  end
end
