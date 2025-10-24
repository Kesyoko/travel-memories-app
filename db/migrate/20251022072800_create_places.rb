class CreatePlaces < ActiveRecord::Migration[7.2]
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.timestamps
    end
    add_index :places, :name
    add_index :places, :location
    add_index :places, [ :location, :name ]
  end
end
