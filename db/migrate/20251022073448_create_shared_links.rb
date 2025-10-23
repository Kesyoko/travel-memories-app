class CreateSharedLinks < ActiveRecord::Migration[7.2]
  def change
    create_table :shared_links do |t|
      t.references :travel_record, null: false, foreign_key: true
      t.string :token
      t.timestamps
    end
    add_index :shared_links, :token, unique: true
  end
end