class User < ApplicationRecord
  has_many :travel_record_id, dependent: :destroy
end
