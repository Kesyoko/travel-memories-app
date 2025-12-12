class AddTransportationToTravelRecords < ActiveRecord::Migration[7.2]
  def change
    add_column :travel_records, :transportation, :integer
  end
end
