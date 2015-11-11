require 'budget/transaction_similarity_analyzer'

module Budget
  module TransactionFactory
    class NewTransactionStrategy
      attr_reader :txn

      def initialize(txn)
        @txn = txn
      end

      def call
        trans = txn.expense ? Expense.new : Income.new

        trans.account = txn.importable_account.try(:account)

        trans.date = txn.date

        trans.description = txn.description

        trans.cents = txn.cents

        trans.notes = txn.notes

        trans.category = Category.find_by(name: txn.category) ||
          TransactionSimilarityAnalyzer.new(trans).best_category ||
          ImportableCategory.best_match(txn.category)

        trans
      end
    end
  end
end
