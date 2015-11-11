
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
end
