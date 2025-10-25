class TravelRecordsController < ApplicationController
  def index
    @travel_records = TravelRecord.includes(:user)
  end

  def new
    @travel_record = TravelRecord.new
  end

  def create
    @travel_record = current_user.travel_records.build(travel_record_params)
    @travel_record.save
    redirect_to travel_records_path
  end

  def destroy
    @travel_record = TravelRecord.find(params[:id])
    @travel_record.destroy
    redirect_to travel_records_path
  end

  private
  def travel_record_params
    params.require(:travel_record).permit(:title, :memo, :travel_date, :want_to_visit_again)
  end
end
