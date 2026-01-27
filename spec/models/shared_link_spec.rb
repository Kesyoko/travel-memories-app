require 'rails_helper'

RSpec.describe SharedLink, type: :model do
  describe "アソシエーションチェック" do
    it { is_expected.to belong_to(:travel_record) }
  end

  describe "一意性を確認" do
    let!(:existing) { create(:shared_link, travel_record: create(:travel_record, user: create(:user))) }

    it "tokenは重複しない" do
      token = build(:shared_link, token: existing.token, travel_record: create(:travel_record, user: create(:user)))
      expect(token).not_to be_valid
    end
  end
end
