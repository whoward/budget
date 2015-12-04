class RenameTables < ActiveRecord::Migration
  def change
    rename_table :accounts, :budget_accounts
    rename_table :categories, :budget_categories
    rename_table :import_services, :budget_import_services
    rename_table :importable_accounts, :budget_importable_accounts
    rename_table :importable_categories, :budget_importable_categories
    rename_table :importable_transactions, :budget_importable_transactions
    rename_table :preferences, :budget_preferences
    rename_table :transactions, :budget_transactions
  end
end
