# frozen_string_literal: true

module Budget
  class CategoryRecord < Sequel::Model(:budget_categories)
    plugin :rcte_tree

    def_dataset_method(:budgeted) { exclude(budgeted_cents: nil) }

    def_dataset_method(:non_fixture) do
      exclude(parent_id: nil).exclude(parent_id: CategoryRecord.transfers.id)
    end

    class << self
      def income
        @income ||= first(name: 'Income', parent_id: nil)
      end

      def expense
        @expense ||= first(name: 'Expense', parent_id: nil)
      end

      def transfers
        @transfers ||= first(name: 'Transfers', parent_id: nil)
      end

      def transfer_from
        @transfer_from ||= first(parent_id: transfers.id, name: 'Transfer From')
      end

      def transfer_to
        @transfer_to ||= first(parent_id: transfers.id, name: 'Transfer To')
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
