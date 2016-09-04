# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :budget_importable_transactions do
      primary_key :id
      String :source_id, null: false
      foreign_key :imported_id, :budget_transactions
      date :date, null: false
      String :description
      String :category
      integer :cents, null: false
      boolean :expense, null: false
      String :account
      foreign_key :account_id,
                  :budget_importable_accounts,
                  type: String,
                  null: false,
                  key: :source_id
      String :notes
      DateTime :created_at, null: false
      DateTime :updated_at, null: false

      index :source_id, unique: true
    end
  end
end
