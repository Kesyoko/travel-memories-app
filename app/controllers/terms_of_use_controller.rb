class TermsOfUseController < ApplicationController
  skip_before_action :authenticate_user!, raise: false

  def show
  end
end
