class CreateTravelPlaces < ActiveRecord::Migration[7.2]
  def change
    create_table :travel_places do |t|
      t.references :place, null: false, foreign_key: true
      t.references :travel_record, null: false, foreign_key: true
      t.date :visited_at
      # ↑↓追記　その下のメモも
      t.integer :cost
      t.text :memo
      t.timestamps
    end
    add_index :travel_places, :visited_at
    add_index :travel_places, [ :travel_record_id, :visited_at ]
    add_index :travel_places, [ :place_id, :visited_at ]
  end
end
