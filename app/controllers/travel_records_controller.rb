class TravelRecordsController < ApplicationController
  def index
    # @travel_records = current_user.travel_records
    @day_group = current_user.travel_records.order(travel_date: "DESC").group_by(&:travel_date)
  end

  def show
    @travel_record =TravelRecord.find_by!(url_token: params[:id])
  end

  def new
    @travel_record = TravelRecord.new
  end

  def create
    @travel_record = current_user.travel_records.build(travel_record_params)
    @travel_record.user_id = current_user.id
    if @travel_record.save
      redirect_to travel_records_path
    else
    render :new
    end
  end

  def edit
    @travel_record = current_user.travel_records.find_by(url_token: params[:id])
  end

  def update
    @travel_record = current_user.travel_records.find_by(url_token: params[:id])
    if @travel_record.update(travel_record_params)
      redirect_to travel_records_path
    else
    render :edit
    end
  end

  def destroy
    @travel_record = current_user.travel_records.find_by(url_token: params[:id])
    @travel_record.destroy
    redirect_to travel_records_path
  end

  def by_date
    # ログイン中のユーザーの指定日(params)の全記録を取得
    @travel_records = current_user.travel_records.where(travel_date: params[:date])
    # 最初の記録を代表としトークン作成のため抽出
    @representative_date = @travel_records.first
    # 上で取得した記録を元にSharedLinksテーブルよりfind_or_create_byでリンクを取得、なければ作成。createだと毎度新しくトークンが生まれるので不使用。
    @shared_link = SharedLink.find_or_create_by(travel_record: @representative_date) do |link|
      # SecureRandomモジュールを使ってトークン作成
      link.token = SecureRandom.uuid
    end
  end

  private
  def travel_record_params
    params.require(:travel_record).permit(:title, :memo, :travel_place, :travel_date, :want_to_visit_again, :place_name, :address, :transportation,
    travel_images: [], items: [])
  end
end
