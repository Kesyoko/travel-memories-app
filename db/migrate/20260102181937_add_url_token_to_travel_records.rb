class AddUrlTokenToTravelRecords < ActiveRecord::Migration[7.2]
  def change
    add_column :travel_records, :url_token, :string

    add_index :travel_records, :url_token, unique: true
    end
end
