class Item < ApplicationRecord
  belongs_to :travel_record
  validates :name, presence: true
end
