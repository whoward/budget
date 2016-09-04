# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :budget_accounts do
      primary_key :id
      String :name, null: false
      boolean :debt, null: false, default: false
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end
