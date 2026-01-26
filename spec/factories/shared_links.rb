FactoryBot.define do
  factory :shared_link do
    association :travel_record
    token { SecureRandom.uuid }
  end
end
