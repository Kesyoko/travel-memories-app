require 'rails_helper'

RSpec.describe "TravelRecords", type: :request do
  # 事前にデータ作成
  let!(:travel_record) { create(:travel_record, user: user) }
  let(:user) { create(:user) }
  before { sign_in user }

  describe "GET /index" do
    it "一覧ページ（index）を表示するか" do
      get travel_records_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /show" do
    it "詳細ページを表示できるか" do
      get travel_record_path(travel_record.url_token)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /create" do
    it "記事作成ができるか" do
      expect {
        # attributes_forでハッシュ値を使って渡す
        post travel_records_path, params: { travel_record: FactoryBot.attributes_for(:travel_record) }
      }.to change(TravelRecord, :count).by(1)

      expect(response).to have_http_status(302)
    end

    it "記事作成失敗" do
      expect {
      post travel_records_path, params: { travel_record: FactoryBot.attributes_for(:travel_record, title: "") }
      }.to change(TravelRecord, :count).by(0)

      expect(response).to have_http_status(422)
    end

    it "記事作成成功" do
      expect {
      post travel_records_path, params: { travel_record: FactoryBot.attributes_for(:travel_record) }
      }.to change(TravelRecord, :count).by(1)

      expect(response).to have_http_status(302)
    end

    it "記事作成成功後リダイレクト" do
      expect {
        post travel_records_path, params: { travel_record: FactoryBot.attributes_for(:travel_record) }
      }.to change(TravelRecord, :count).by(1)

      expect(response).to redirect_to(travel_records_path)
    end
  end


  describe "PATCH /update" do
    it "記事更新成功" do
      # 編集前データ
      travel_record = create(:travel_record, user: user, title: "編集前")
      # タイトルが「編集前」から「編集後」に変更
      patch travel_record_path(travel_record.url_token), params: { travel_record: { title: "編集後" } }
      # 再読み込みを実行
      travel_record.reload
      # タイトルが「編集後」になっていれはOK
      expect(travel_record.title).to eq("編集後")
      expect(response).to have_http_status(302)
    end
  end

  describe "PATCH /update" do
    it "記事更新失敗" do
      travel_record = create(:travel_record, user: user, title: "編集前")
      # タイトルが「編集前」から空に変更
      patch travel_record_path(travel_record.url_token), params: { travel_record: { title: "" } }

      travel_record.reload

      expect(travel_record.title).to eq("編集前")
      expect(response).to have_http_status(422)
    end
  end

  describe "DELETE /destroy" do
    it "記事削除成功" do
      travel_record = create(:travel_record, user: user, title: "編集前")
      # tokenを使って記事を特定、削除（−１）する
      expect { delete travel_record_path(travel_record.url_token) }.to change(TravelRecord, :count).by(-1)
      # 削除後一覧へ移動
      expect(response).to redirect_to(travel_records_path)
    end
  end

  describe "GET /index" do
    it "ログイン済みなら旅記録が見れる" do
      #  before { sign_in user }でログインが済になってる
      get travel_records_path
      expect(response).to have_http_status(200)
    end
  end


describe "GET /index" do
    it "ログインしていない場合ログイン画面へリダイレクト" do
      sign_out user
      get travel_records_path
      expect(response).to have_http_status(302)
    end
  end
end
