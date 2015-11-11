
module Budget
  class SplitExpenseTransaction < Expense
    has_many :partitions, class_name: 'Budget::Expense',
                          foreign_key: 'split_transaction_id',
                          dependent: :destroy

    def splittable?
      true
    end

    def split?
      true
    end
  end
end
