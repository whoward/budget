class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.integer :owner_id
      t.string :owner_type
      t.string :key
      t.text :value

      t.timestamps
    end
  end
end
