# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :budget_transactions do
      primary_key :id
      foreign_key :account_id, :budget_accounts, null: false
      foreign_key :category_id, :budget_categories, null: false
      foreign_key :transfer_id, :budget_transactions
      String :type, null: false
      date :date, null: false
      String :description, null: false
      integer :cents, null: false
      String :notes
      foreign_key :split_transaction_id, :budget_transactions
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end
