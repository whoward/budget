# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :budget_importable_accounts do
      primary_key :id
      String :source_id, null: false
      foreign_key :imported_id, :budget_accounts
      String :name, null: false
      DateTime :created_at, null: false
      DateTime :updated_at, null: false

      index :source_id, unique: true
    end
  end
end
