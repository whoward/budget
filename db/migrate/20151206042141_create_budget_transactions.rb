class CreateBudgetTransactions < ActiveRecord::Migration
  def change
    create_table :budget_transactions do |t|
      t.integer :account_id, null: false
      t.integer :category_id, null: false
      t.integer :transfer_id
      t.string :type, null: false
      t.date :date, null: false
      t.string :description, null: false
      t.integer :cents, null: false
      t.string :notes
      t.integer :split_transaction_id

      t.timestamps null: false

      t.index :account_id
      t.index :category_id
      t.index :transfer_id
      t.index :split_transaction_id
    end
  end
end
