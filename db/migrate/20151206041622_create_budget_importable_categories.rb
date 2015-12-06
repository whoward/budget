class CreateBudgetImportableCategories < ActiveRecord::Migration
  def change
    create_table :budget_importable_categories do |t|
      t.integer :imported_id, null: false
      t.string :name, null: false
      t.integer :import_count, default: 0, null: false

      t.timestamps null: false
    end
  end
end
