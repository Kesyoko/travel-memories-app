class AddPlaceNameToTravelRecords < ActiveRecord::Migration[7.2]
  def change
    add_column :travel_records, :place_name, :text
  end
end
