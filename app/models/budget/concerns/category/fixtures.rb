
module Budget
  class Category < ActiveRecord::Base
    module Fixtures
      extend ActiveSupport::Concern

      included do
        scope :not_fixture, -> { where.not(parent_id: [nil, transfers.id]) }
        after_create { Category.invalidate_cache! }
      end

      def income?
        root == Category.income
      end

      def expense?
        root == Category.expense
      end

      def transfer?
        root == Category.transfers
      end

      module ClassMethods
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
end
