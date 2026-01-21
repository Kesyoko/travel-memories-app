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
    # attach_preprocessed_imagesで画像加工する
    attach_preprocessed_images(@travel_record)
    redirect_to travel_records_path
    else
    render :new, status: :unprocessable_entity
    end
  end

  def edit
    @travel_record = current_user.travel_records.find_by(url_token: params[:id])
  end

  def update
    @travel_record = current_user.travel_records.find_by(url_token: params[:id])

    if @travel_record.update(travel_record_params)
      # attach_preprocessed_imagesで画像加工する
      attach_preprocessed_images(@travel_record)
      redirect_to travel_records_path
    else
      render :edit, status: :unprocessable_entity
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
    items: [])
  end

  # ここで受け取った画像をImagePreprocessorに渡して加工、再度ここへ返し保存
  def attach_preprocessed_images(travel_record)
    # 画像が送られてなければ処理終了
    return unless params[:travel_record][:travel_images].present?
    params[:travel_record][:travel_images].each do |uploaded_file|
      # 　空ファイルがあればそれは無視（これがないとエラー）
      next if uploaded_file.blank?
      # ”保存前に”加工してIOに変換(ImagePreprocessorで加工)
      io = ImagePreprocessor.call(uploaded_file)

      # 保存する時にファイル名をUUIDに変換し保存を行う
      travel_record.travel_images.attach(
        io: io,
        filename: "#{SecureRandom.uuid}.webp",
        content_type: "image/webp"
      )
    end
  end
end
