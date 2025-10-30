class TravelRecord < ApplicationRecord
  belongs_to :user, optional: true
  has_many_attached :travel_images
  has_many :travel_places, dependent: :destroy
  has_many :places, through: :travel_places

  validates :memo, length: { maximum: 500 }
  validates :title, presence: true, length: { maximum: 100 }
  validates :travel_date, presence: true
  validates :want_to_visit_again, inclusion: { in: [ true, false ] }
end
