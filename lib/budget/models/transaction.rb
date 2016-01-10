
module Budget
  class Transaction < ActiveRecord::Base
    belongs_to :account
    belongs_to :category

    scope :not_split_transactions, -> { where.not(type: [SplitIncomeTransaction, SplitExpenseTransaction]) }

    validates :account, presence: true
    validates :category, presence: true
    validates :cents, presence: true
    validates :date, presence: true
    validates :description, presence: true

    def signed_cents
      cents
    end

    def splittable?
      false
    end

    def split?
      false
    end
  end

  class Income < Transaction
    belongs_to :split_transaction, class_name: 'Budget::SplitIncomeTransaction'

    def splittable?
      true
    end
  end

  class Expense < Transaction
    belongs_to :split_transaction, class_name: 'Budget::SplitExpenseTransaction'

    def signed_cents
      -cents
    end

    def splittable?
      true
    end
  end

  class TransferFrom < Expense
    has_one :to, class_name: 'Budget::TransferTo', foreign_key: 'transfer_id'

    def from
      self
    end

    def splittable?
      false
    end
  end

  class TransferTo < Income
    has_one :from, class_name: 'Budget::TransferFrom', foreign_key: 'transfer_id'

    def to
      self
    end

    def splittable?
      false
    end
  end

  class SplitIncomeTransaction < Income
    has_many :partitions, class_name: 'Budget::Income', foreign_key: 'split_transaction_id', dependent: :destroy

    def splittable?
      true
    end

    def split?
      true
    end
  end

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
