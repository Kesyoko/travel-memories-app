class Place < ApplicationRecord
  has_many :travel_places, dependent: :destroy
  has_many :travel_records, through: :travel_place

  validates :name, presence: true
  validates :location, presence: true
end
