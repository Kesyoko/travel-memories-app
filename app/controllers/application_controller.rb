class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  allow_browser versions: :modern

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :email, :password ])
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :email, :password ])
  end
end
