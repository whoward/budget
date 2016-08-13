
# frozen_string_literal: true
module Budget
  class Category < ActiveRecord::Base
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

    # Fixtures concern here on
    # --------------------------------------------------------------------------
    scope :not_fixture, -> { where.not(parent_id: [nil, transfers.id]) }
    after_create { Budget::Category.invalidate_cache! }

    def income?
      root == Budget::Category.income
    end

    def expense?
      root == Budget::Category.expense
    end

    def transfer?
      root == Budget::Category.transfers
    end

    class << self
      def income
        @income ||= roots.find_by(name: 'Income')
      end

      def expense
        @expense ||= roots.find_by(name: 'Expense')
      end

      def transfers
        @transfers ||= roots.find_by(name: 'Transfers')
      end

      def transfer_from
        @transfer_from ||= find_by(parent_id: transfers, name: 'Transfer From')
      end

      def transfer_to
        @transfer_to ||= find_by(parent_id: transfers, name: 'Transfer To')
      end

      def invalidate_cache!
        @income = nil
        @expense = nil
        @transfers = nil
        @transfer_from = nil
        @transfer_to = nil
      end
    end
  end
end
