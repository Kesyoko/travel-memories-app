class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: :devise_controller?
  # もしかしたらonly: [:index]?
  allow_browser versions: :modern
  # 以下を入れることによりログイン後に相応しい移動先を自動で判断してくれる。 どのアプリにも基本必要
  def after_sign_in_path_for(resource)
    travel_records_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :email, :password ])
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :email, :password ])
  end
end
