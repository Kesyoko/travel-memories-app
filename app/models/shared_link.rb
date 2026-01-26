class SharedLink < ApplicationRecord
  belongs_to :travel_record
  validates :token, presence: true, uniqueness: true
  # generates_token_for :tokenを入れてもOK 今回はコントローラーで使っているためコメントアウト
  # アクセス期限(expires_in)は設定しない ガイドに載ってる記述（:password_reset）はリセット用
end
