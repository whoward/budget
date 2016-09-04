# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :budget_categories do
      primary_key :id

      foreign_key :parent_id, :budget_categories, null: false

      String :name, null: false

      integer :budgeted_cents

      boolean :watched, null: false, default: false

      DateTime :created_at, null: false

      DateTime :updated_at, null: false

      index :parent_id
    end
  end
end
