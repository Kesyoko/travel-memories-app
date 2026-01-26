FactoryBot.define do
  factory :user do
    email { |n| "test#{n}@example.com" }
    uid  { |n| "uid#{n}" }
    password {"testpass"}
  end
end