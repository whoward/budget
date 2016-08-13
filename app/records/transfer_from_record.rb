# frozen_string_literal: true

module Budget
  class TransferFromRecord < Sequel::Model
    set_dataset DB[:budget_transactions].where(type: 'Budget::TransferFrom')

    one_to_one :to, class: 'Budget::TransferToRecord',
                    key: :transfer_id
  end
end
