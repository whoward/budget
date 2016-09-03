# frozen_string_literal: true

module Budget
  class SplitIncomeRecord < Sequel::Model(:budget_transactions)
    set_dataset DB[:budget_transactions].where(type: 'Budget::SplitIncomeTransaction')

    one_to_many :partitions, class: 'Budget::IncomeRecord',
                             key: :split_transaction_id
  end
end
