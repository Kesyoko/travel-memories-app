class TravelImagesController < ApplicationController
  def destroy
    # ActiveStorage::AttachmentのIDを探す
    @image = ActiveStorage::Attachment.find(params[:id])
    # ActiveStorage::Attachmentがある記録を持ってくる
    @travel_record = @image.record

    # purgeで削除する
    @image.purge
    # redirect_back(fallback_location: 〜 )で一つ前のページに戻る
    redirect_back(fallback_location: travel_records_path)
  end
end
