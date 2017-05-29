# frozen_string_literal: true

module Budget
  module Command
    module Transaction
      class Split
        Invalid = Class.new(ArgumentError)

        def initialize(transaction, partitions)
          @transaction = Cast::TransactionRecord(transaction)
          @partitions = partitions.map { |params| build_partition(params) }
        end

        def call
          validate!

          ActiveRecord::Base.transaction do
            transaction.partitions_dataset.delete
            transaction.update(type: parent_type)
            partitions.each(&:save)
          end
        end

        private

        # TODO: these types really need to be turned into value objects
        SPLITTABLE_TYPES = %w(
          Budget::Income
          Budget::SplitIncome
          Budget::Expense
          Budget::SplitExpense
        ).freeze

        attr_reader :transaction, :partitions

        def parent_type
          expense? ? 'Budget::SplitExpenseTransaction' : 'Budget::SplitIncomeTransaction'
        end

        def partition_type
          expense? ? 'Budget::Expense' : 'Budget::Income'
        end

        def expense?
          %w(Budget::Expense Budget::SplitExpense).include?(transaction.type)
        end

        # the values copied over to the partition, these can all be overridden
        def cloned_attributes
          transaction.values
                     .slice(:account_id, :category_id, :date, :description)
                     .merge(type: partition_type)
        end

        def build_partition(params)
          TransactionRecord.new(cloned_attributes).set(params)
        end

        def validate!
          ensure_parts_sum_to_total
          ensure_parts_are_consistent
          ensure_transaction_is_expense_or_income
        end

        def invalid(reason)
          raise Invalid, reason
        end

        def ensure_parts_sum_to_total
          txn.cents == partitions.map(&:cents).sum ||
            invalid(:sum_of_parts_doesnt_equal_total)
        end

        def ensure_parts_are_consistent
          partitions.all? { |p| p.class == valid_partitions_class } ||
            invalid(:partitions_inconsistent_type)
        end

        def ensure_transaction_is_expense_or_income
          SPLITTABLE_TYPES.include?(transaction.type) ||
            invalid(:transaction_must_be_income_or_expense)
        end
      end
    end
  end
end
