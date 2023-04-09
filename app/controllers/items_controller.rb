class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:product_name, :category_id, :price, :product_description, :product_status_id, :shopping_fee_id, :prefecture_id, :schedule_date_id, :image).merge(user_id: current_user.id)
  end

end
