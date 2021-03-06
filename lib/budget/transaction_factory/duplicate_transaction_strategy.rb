
# frozen_string_literal: true
module Budget
  module TransactionFactory
    class DuplicateTransactionStrategy
      attr_reader :txn

      def initialize(txn)
        @txn = txn
      end

      def call
        scope = base_scope
        scope = scope.where(account: imported_account) if imported_account
        scope.first
      end

      private

      def imported_account
        txn.importable_account.try(:account)
      end

      def imported_type
        txn.expense ? Expense : Income
      end

      # a scope that matches all transactions on attributes which must match
      def base_scope
        Transaction.where(cents: txn.cents, type: imported_type)
                   .where('date between ? and ?', txn.date - 1.day, txn.date + 1.day)
      end
    end
  end
end
