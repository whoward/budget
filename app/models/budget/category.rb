require 'awesome_nested_set'

require 'budget/concerns/category/fixtures'

module Budget
  class Category < ActiveRecord::Base
    include Fixtures

    acts_as_nested_set

    has_many :transactions, dependent: :restrict_with_exception

    ALLOWED_ROOTS = %w(Income Expense Transfers).freeze

    scope :budgeted, -> { not_fixture.where('budgeted_cents > 0') }
    scope :unbudgeted, -> { not_fixture.where('budgeted_cents is null or budgeted_cents <= 0') }

    validates :name, inclusion: ALLOWED_ROOTS, if: :root?

    delegate :count, to: :transactions, prefix: true

    def can_edit?
      !root? && parent != Category.transfers
    end

    def can_destroy?
      can_edit? && transactions_count == 0
    end

    def budgeted?
      (budgeted_cents || 0) > 0
    end
  end
end
