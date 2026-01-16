class TravelRecordsController < ApplicationController
  def index
    @q = current_user.travel_records.ransack(params[:q])
    @records = @q.result(distinct: true).includes(:user).order("created_at desc")
    @day_group = @records.group_by(&:travel_date)
    end

  # page(params[:page])はページネーション 必要になったら.orderの前へつける


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

  def autocomplete
    # to_sで文字形に変更して.stripで頭とお尻の空白を無視
    keyword = params[:q].to_s.strip
    # 戻り値が空かどうか確認、空なら検索しない
    return render json: [] if keyword.blank?

    # ログイン中ユーザの記録を検索
    @q = current_user.travel_records.ransack(
      # 検索対象は場所名・住所・タイトル
      place_name_or_address_or_title_cont: keyword
    )
    # 戻り値を１０件表示、distinct: trueで重複を消す
    @response = @q.result(distinct: true).limit(10)
    # render jsonでタイトルデータを返す
    render json: @response.select(:title).distinct
  end

  private
  def travel_record_params
    params.require(:travel_record).permit(:title, :memo, :travel_place, :travel_date, :want_to_visit_again, :place_name, :address, :transportation, :amount_used,
    travel_images: [], items: [])
  end
end
