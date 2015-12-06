class CreateBudgetPreferences < ActiveRecord::Migration
  def change
    create_table :budget_preferences do |t|
      t.integer :owner_id, null: false
      t.string :owner_type, null: false
      t.string :key, null: false
      t.text :value, null: false

      t.timestamps null: false
    end
  end
end
