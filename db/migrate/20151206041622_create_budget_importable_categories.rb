# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :budget_importable_categories do
      primary_key :id
      foreign_key :imported_id, :budget_categories, null: false
      String :name, null: false
      integer :import_count, null: false, default: 0
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end
