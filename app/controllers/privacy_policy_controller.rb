class PrivacyPolicyController < ApplicationController
  # ログインしなくてもプライバシーポリシーを確認できるように
  skip_before_action :authenticate_user!, raise: false

  def show
  end
end