
module Budget
  class SplitIncomeTransaction < Income
    has_many :partitions, class_name: 'Budget::Income', foreign_key: 'split_transaction_id', dependent: :destroy

    def splittable?
      true
    end

    def split?
      true
    end
  end
end
