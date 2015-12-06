class AddForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key :budget_categories, :budget_categories, column: :parent_id

    add_foreign_key :budget_importable_accounts, :budget_accounts, column: :imported_id

    add_foreign_key :budget_importable_categories, :budget_categories, column: :imported_id

    add_foreign_key :budget_importable_transactions, :budget_transactions, column: :imported_id
    add_foreign_key :budget_importable_transactions, :budget_importable_accounts, column: :account_id

    add_foreign_key :budget_transactions, :budget_accounts, column: :account_id
    add_foreign_key :budget_transactions, :budget_categories, column: :category_id
    add_foreign_key :budget_transactions, :budget_transactions, column: :transfer_id
    add_foreign_key :budget_transactions, :budget_transactions, column: :split_transaction_id
  end
end
