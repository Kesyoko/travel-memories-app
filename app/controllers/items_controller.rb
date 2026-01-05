class ItemsController < ApplicationController
  # ログイン中ユーザーの記録を記録IDを用いて取得
  before_action :travel_record
  def travel_record
    # ネストしているため旅記録IDを取得
    @travel_record = current_user.travel_records.find_by(url_token: params[:travel_record_id])
  end

  def index
    @items = @travel_record.items
  end

  def new
    @item = @travel_record.items.build
  end

  def edit
    @item = @travel_record.items.find(params[:id])
  end

  def create
    @item = @travel_record.items.build(item_params)
    if @item.save
      redirect_to travel_record_items_path(@travel_record)
    else
      @items = @travel_record.items
      render :index, status: :unprocessable_entity
    end
  end

  def update
    @item = @travel_record.items.find(params[:id])
    if @item.update(item_params)
      redirect_to travel_record_items_path(@travel_record)
    else
      render :edit
    end
  end



  def destroy
    @item = @travel_record.items.find(params[:id])
    @item.destroy
    redirect_to travel_record_items_path(@travel_record)
  end

  private

  def item_params
    params.require(:item).permit(:name, :memo, :is_checked)
  end
end
