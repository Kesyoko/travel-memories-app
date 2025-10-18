class User < ApplicationRecord
 has_many :travel_records, dependent: :destroy
end
