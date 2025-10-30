class TravelPlace < ApplicationRecord
  belongs_to :travel_record
  belongs_to :place


  validates :name, presence: true
  validates :location, presence: true
end
