class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :authenticate_user!, only: :google_oauth2
  skip_before_action :verify_authenticity_token, only: :google_oauth2

  # コールバック処理
  def google_oauth2
    # request.env["omniauth.auth"]でGoogleから取得した情報を取得
    @user = User.from_omniauth(request.env["omniauth.auth"])
    # DBに保存されているものか確認
    if @user.persisted?
      # ＠userをログイン状態にし、リダイレクトを行う。
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    else
      # 保存できなかった時、sessionに判断前にrequest.env["omniauth.auth"]で取得した情報を一時保管。
      session["devise.google_oauth2_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
