class TravelRecord < ApplicationRecord
  belongs_to :user, optional: true
  has_many_attached :travel_images
  has_many :travel_places, dependent: :destroy
  has_many :places, through: :travel_places
  has_one :shared_link, dependent: :destroy
  has_many :items, dependent: :destroy

  validates :memo, length: { maximum: 500 }
  validates :title, presence: true, length: { maximum: 100 }
  validates :travel_date, presence: true
  validates :want_to_visit_again, inclusion: { in: [ true, false ] }
  # 交通手段の選択肢、ストロングパラメータにも記載
  enum transportation: {
    car: 1,
    train: 2,
    bus: 3,
    walk: 4,
    airplane: 5,
    motorcycle: 6,
    ferry: 7,
    bicycle: 8,
    other: 9
  }

  # 検索対象とするカラム指定
  #  %w　は配列を作成する。(["",""]を省略するために使用。)
  def self.ransackable_attributes(auth_object = nil)
    %w[place_name address title]
  end
  # アソシエーションがあるカラム指定
  # 今回はログイン中の〜で絞っているためユーザー必須
  def self.ransackable_associations(auth_object = nil)
    %w[user]
  end

  
  before_create :make_token

  def to_param
    url_token
  end

  # 「||=」でif,elseと同じ（もしトークンがなければ〜となる）
  # url_tokenをランダムなものに変更する
  private
  def make_token
    self.url_token ||= SecureRandom.urlsafe_base64
  end
end
