module Budget
  class Account < ActiveRecord::Base
    has_many :importable_accounts, foreign_key: 'imported_id'

    has_many :transactions, dependent: :restrict_with_exception

    scope :debt, -> { where(debt: true) }

    delegate :count, to: :transactions, prefix: true
  end
end
