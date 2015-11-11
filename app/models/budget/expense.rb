
module Budget
  class Expense < Transaction
    belongs_to :split_transaction, class_name: 'Budget::SplitExpenseTransaction'

    def signed_cents
      -cents
    end

    def splittable?
      true
    end
  end
end
