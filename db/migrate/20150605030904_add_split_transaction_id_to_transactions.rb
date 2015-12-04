class AddSplitTransactionIdToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :split_transaction_id, :integer
  end
end
