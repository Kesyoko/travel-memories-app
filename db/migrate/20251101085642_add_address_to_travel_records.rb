class AddAddressToTravelRecords < ActiveRecord::Migration[7.2]
  def change
    add_column :travel_records, :address, :string
  end
end
