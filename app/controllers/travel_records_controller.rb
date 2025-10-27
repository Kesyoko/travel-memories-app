class TravelRecordsController < ApplicationController
  def index
    @travel_records = TravelRecord.includes(:user)
  end

  def show
    @travel_record =TravelRecord.find(params[:id])
  end

  def new
    @travel_record = TravelRecord.new
  end

  def create
    @travel_record = current_user.travel_records.build(travel_record_params)
    if @travel_record.save
      redirect_to travel_records_path
    else
    render :new
    end
  end

  def edit
    @travel_record = current_user.travel_records.find(params[:id])
  end

  def update
    @travel_record = current_user.travel_records.find(params[:id])
    if @travel_record.update(travel_record_params)
      redirect_to travel_records_path
    else
    render :edit
    end
  end

  def destroy
    @travel_record = current_user.travel_records.find(params[:id])
    @travel_record.destroy
    redirect_to travel_records_path
  end

  private
  def travel_record_params
    params.require(:travel_record).permit(:title, :memo, :travel_date, :want_to_visit_again)
  end
end
