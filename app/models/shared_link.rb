class SharedLink < ApplicationRecord
  belongs_to :travel_record
  # アクセス期限は設定しない ガイドに載ってる記述（:password_reset）はリセット用
  generates_token_for :token
end
