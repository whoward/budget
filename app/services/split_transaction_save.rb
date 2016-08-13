# frozen_string_literal: true

module Budget
  module Service
    class SplitTransactionSave
      def initialize(transaction:, partitions:)
        @txn = transaction
        @partitions = partitions
      end

      def validate
        catch(:invalid) do
          ensure_parts_sum_to_total
          ensure_parts_are_consistent
          ensure_transaction_is_expense_or_income
          true
        end
      end

      def call
        validation = validate

        return ServiceResponse.failure(validation) unless validation == true

        @txn = txn.becomes!(split_class) unless txn.class == split_class

        partitions.each { |p| p.split_transaction = txn }

        ActiveRecord::Base.transaction do
          txn.partitions.select(&:persisted?).each(&:destroy) if txn.persisted?
          txn.save!
          partitions.each(&:save!)
        end

        ServiceResponse.success('split transaction created')
      end

      private

      INCOME_OR_EXPENSE_CLASSES = %w(Income Expense SplitIncomeTransaction SplitExpenseTransaction).freeze

      attr_reader :txn, :partitions

      def split_class
        if txn.is_a?(Expense)
          SplitExpenseTransaction
        else
          SplitIncomeTransaction
        end
      end

      def valid_partitions_class
        if txn.is_a?(Expense)
          Expense
        else
          Income
        end
      end

      def invalid(reason)
        throw :invalid, reason
      end

      def ensure_parts_sum_to_total
        invalid(:sum_of_parts_doesnt_equal_total) unless txn.cents == partitions.map(&:cents).sum
      end

      def ensure_parts_are_consistent
        invalid(:partitions_inconsistent_type) unless partitions.all? { |p| p.class == valid_partitions_class }
      end

      def ensure_transaction_is_expense_or_income
        invalid(:transaction_must_be_income_or_expense) unless txn.class.name.demodulize.in? INCOME_OR_EXPENSE_CLASSES
      end
    end
  end
end
