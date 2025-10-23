class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.references :travel_record, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :quantity, default: 1
      t.text :memo
      t.boolean :is_checked, default: false
      t.timestamps
    end
    add_index :items, :name
    add_index :items, [:travel_record_id, :created_at]
  end
end