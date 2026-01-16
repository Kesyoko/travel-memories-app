class User < ApplicationRecord
  has_many :travel_records, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :omniauthable, omniauth_providers: %i[google_oauth2]
  validates :uid, uniqueness: { scope: :provider }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

def self.from_omniauth(auth)
  find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
  end
end
end
