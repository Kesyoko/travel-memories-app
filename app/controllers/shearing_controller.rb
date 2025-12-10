class ShearingController < ApplicationController
      # 事前にユーザー認証をスキップしておく。(が、トークンを下で使うことで不正アクセスを防ぐ。)
      skip_before_action :authenticate_user!
  def index
    # ガード節を用いて条件を絞っていく(return redirect_to〜がガード節)
    # params[:token].blank?で、トークンがなければ不正となるため戻る
    return redirect_to root_path if params[:token].blank?
    # トークンがあれば合致するものを持ってくる
    @shared = SharedLink.find_by(token: params[:token])
    # 記録があるか確認　なければ戻る
    return redirect_to root_path if @shared.blank?
    # 記録を持ってくる
    @record = @shared.travel_record
    # 日にちで絞り込み
    # TravelRecordにある記録、日付で絞り込みをかけ共有した人間のデータを持ってくる
    @shared_page = TravelRecord.where(travel_date: @record.travel_date, user_id: @record.user_id)
  end
end
