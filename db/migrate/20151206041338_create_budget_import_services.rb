# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :budget_import_services do
      primary_key :id
      String :name, null: false
      String :type, null: false
      boolean :active, null: false, default: false
      jsonb :preferences, null: false, default: Sequel.pg_jsonb({})
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end
