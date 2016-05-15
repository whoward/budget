# frozen_string_literal: true
class CreateBudgetAccounts < ActiveRecord::Migration
  def change
    create_table :budget_accounts do |t|
      t.string :name, null: false
      t.boolean :debt, default: false, null: false

      t.timestamps null: false
    end
  end
end
