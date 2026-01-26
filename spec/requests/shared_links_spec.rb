  require 'rails_helper'

  RSpec.describe "SharedLinks", type: :request do
    let(:user) { create(:user) }
    let(:travel_record) { create(:travel_record, user: user) }
    let(:shared_link) { create(:shared_link, travel_record: travel_record) }
  
    
    describe "GET /show" do
      it "シェアリンクが表示されるか" do
        get shearing_path(shared_link.token)
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /show" do
      it "シェアリンクが存在しない" do
      get  shearing_path("テスト")

      expect(response).to redirect_to(root_path)
    end
  end
end