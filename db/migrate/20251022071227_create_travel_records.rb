class CreateTravelRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :travel_records do |t|
      t.references :user, null: false, foreign_key: true
      t.text :memo
      t.integer :amount_used, default: 0
      t.string :title, null: false
      t.date :travel_date, null: false
      t.boolean :want_to_visit_again, default: false
      t.timestamps
    end
    add_index :travel_records, :travel_date
    add_index :travel_records, [ :user_id, :travel_date ]
    add_index :travel_records, [ :user_id, :want_to_visit_again ]
  end
end
