# frozen_string_literal: true
class CreateBudgetImportableAccounts < ActiveRecord::Migration
  def change
    create_table :budget_importable_accounts do |t|
      t.string :source_id, null: false
      t.integer :imported_id
      t.string :name, null: false

      t.timestamps null: false

      t.index :source_id, unique: true
    end
  end
end
