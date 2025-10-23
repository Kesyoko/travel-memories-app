class CreateTravelImages < ActiveRecord::Migration[7.2]
  def change
    create_table :travel_images do |t|
      t.references :travel_record, null: false, foreign_key: true
      t.string :image_url, null: false
      t.timestamps
    end
    add_index :travel_images, [:travel_record_id, :created_at]
  end
end