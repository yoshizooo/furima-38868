class PurchaseHistoriesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :outUser, only:[:index]

  def index
      @item = Item.find(params[:item_id])
      @purchase_history_shopping_address = PurchaseHistoryShoppingAddress.new
  end

  def create
    @purchase_history_shopping_address = PurchaseHistoryShoppingAddress.new(purchase_history_params)
    @item = Item.find(params[:item_id])
    if @purchase_history_shopping_address.valid?
      pay_item
      @purchase_history_shopping_address.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_history_params
    params.require(:purchase_history_shopping_address).permit(:post_code, :municipalities, :address,
                                                     :building_name, :telephone_number, :prefecture_id).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def outUser
    @item = Item.find(params[:item_id])
    unless @item.purchase_history == nil && current_user.id != @item.user.id 
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_history_params[:token],
      currency: "jpy"
    )
  end
end
