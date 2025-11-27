class InquiriesController < ApplicationController
  # Railsは↓がなくても読み込むが保険のため入れておく。
  require "net/http"
  require "uri"

  def create
  url = URI.parse("https://docs.google.com/forms/u/1/d/1NWtKY-j4QfXGiUFuAacfOXUXyANOyKrlUOckXd3hbuA/formResponse")
  form_data ={
    "entry.905536629" => params[:name],
    "entry.2121319022" => params[:email],
    "entry.522165293"  => params[:inquiry]
  }
  # ↓上記のURLにentryに対応するパラメータをポストする
  Net::HTTP.post_form(url, form_data)
  redirect_to travel_records_path
  end
end
