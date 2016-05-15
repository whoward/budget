# frozen_string_literal: true
class CreateBudgetImportServices < ActiveRecord::Migration
  def change
    create_table :budget_import_services do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.boolean :active, default: false, null: false

      t.timestamps null: false
    end
  end
end
