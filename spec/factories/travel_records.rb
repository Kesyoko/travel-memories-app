FactoryBot.define do
  factory :travel_record do
    title {"タイトルテスト"}
    memo {"メモテスト"}
    travel_date{Date.today}
    want_to_visit_again {true}
    transportation {:bus}
  end
end
