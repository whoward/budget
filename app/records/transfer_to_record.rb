# frozen_string_literal: true

module Budget
  class TransferToRecord < Sequel::Model
    set_dataset DB[:budget_transactions].where(type: 'Budget::TransferTo')

    one_to_one :from, class: 'Budget::TransferFromRecord',
                      key: :transfer_id
  end
end
