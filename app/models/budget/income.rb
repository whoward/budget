
module Budget
  class Income < Transaction
    belongs_to :split_transaction, class_name: 'Budget::SplitIncomeTransaction'

    def splittable?
      true
    end
  end
end
