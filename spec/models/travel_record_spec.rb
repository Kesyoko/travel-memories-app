require 'rails_helper'

RSpec.describe TravelRecord, type: :model do
describe "バリデーションチェック" do
  it "メモが500文字以内であれば有効" do
    memo = build(:travel_record, memo: "a"* 500)
    expect(memo).to be_valid
  end

  it "メモが500文字以上であれば無効" do
    memo = build(:travel_record, memo: "a"* 501)
    expect(memo).not_to be_valid
  end

  it "タイトルが入力されていれば有効" do
    title = build(:travel_record)
    expect(title).to be_valid
  end

  it "タイトルが未入力なら無効" do
    title = build(:travel_record, title: "")
    expect(title).not_to be_valid
  end

  it "タイトルが100文字以内であれば有効" do
    title = build(:travel_record, title: "a"* 100)
    expect(title).to be_valid
  end

  it "タイトルが100文字以上であれば無効" do
    title = build(:travel_record, title: "a"* 101)
    expect(title).not_to be_valid
  end

  it "日にちが入力されていれば有効" do
    travel_date = build(:travel_record)
    expect(travel_date).to be_valid
  end

  it "日にちが未入力なら無効" do
    travel_date = build(:travel_record, travel_date: nil)
    expect(travel_date).not_to be_valid
  end

  it "また行きたいの選択肢に入力されていれば有効" do
    want_to_visit_again = build(:travel_record)
    expect(want_to_visit_again).to be_valid
  end

  it "また行きたいの選択肢に入力されていなければ無効" do
    want_to_visit_again = build(:travel_record, want_to_visit_again: nil)
    expect(want_to_visit_again).not_to be_valid
  end
end


describe "enumチェック" do
  it "transportationを保存できるか" do
    transportation = build(:travel_record)
    expect(transportation).to be_valid
  end

  it "transportationに未定義の値はエラーになるか" do
    expect { build(:travel_record, transportation: :spaceship) }.to raise_error(ArgumentError)
  end
end

  describe "アソシエーションチェック" do
    it { is_expected.to belong_to(:user).optional }

    it { is_expected.to have_many(:travel_places).dependent(:destroy) }
    it { is_expected.to have_many(:items).dependent(:destroy) }
    it { is_expected.to have_one(:shared_link).dependent(:destroy) }

    it { is_expected.to have_many(:places).through(:travel_places) }
  end
end
