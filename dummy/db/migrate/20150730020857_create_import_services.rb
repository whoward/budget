class CreateImportServices < ActiveRecord::Migration
  def change
    create_table :import_services do |t|
      t.string :name
      t.string :type
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
