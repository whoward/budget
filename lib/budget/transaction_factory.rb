require 'budget/transaction_factory/new_transaction_strategy'
require 'budget/transaction_factory/duplicate_transaction_strategy'

module Budget
  module TransactionFactory
    def self.build_with_inference_from_importable_transaction(txn, duplicate: true, new_transaction: true)
      strategies = []

      strategies << DuplicateTransactionStrategy.new(txn) if duplicate
      strategies << NewTransactionStrategy.new(txn) if new_transaction

      strategies.each do |strategy|
        value = strategy.call
        break value if value
      end
    end
  end
end
