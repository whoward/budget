class CreateBudgetCategories < ActiveRecord::Migration
  def change
    create_table :budget_categories do |t|
      t.integer :parent_id
      t.string :name, null: false
      t.integer :lft, null: false
      t.integer :rgt, null: false
      t.integer :depth, null: false
      t.integer :budgeted_cents

      t.timestamps null: false

      t.index :parent_id
      t.index :depth
      t.index :lft
      t.index :rgt
    end
  end
end
