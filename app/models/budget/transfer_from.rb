
module Budget
  class TransferFrom < Expense
    has_one :to, class_name: 'Budget::TransferTo', foreign_key: 'transfer_id'

    def from
      self
    end

    def splittable?
      false
    end
  end
end
