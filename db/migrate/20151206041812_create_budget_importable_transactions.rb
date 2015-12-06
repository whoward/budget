class CreateBudgetImportableTransactions < ActiveRecord::Migration
  def change
    create_table :budget_importable_transactions do |t|
      t.string :source_id, null: false
      t.integer :imported_id
      t.date :date, null: false
      t.string :description
      t.string :category
      t.integer :cents, null: false
      t.boolean :expense, null: false
      t.string :account
      t.string :account_id
      t.string :notes

      t.timestamps null: false

      t.index :source_id, unique: true
    end
  end
end
