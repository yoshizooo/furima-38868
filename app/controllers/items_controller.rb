class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  

  def index
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

  private

  def item_params
    params.require(:item).permit(:product_name, :category_id, :price, :product_description, :product_status_id, :shopping_fee_id, :prefecture_id, :schedule_date_id, :image).merge(user_id: current_user.id)
  end

end
