
module Budget
  class TransferTo < Income
    has_one :from, class_name: 'Budget::TransferFrom', foreign_key: 'transfer_id'

    def to
      self
    end

    def splittable?
      false
    end
  end
end
