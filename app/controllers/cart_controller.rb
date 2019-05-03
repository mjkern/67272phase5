class CartController < ApplicationController

  include AppHelpers::Cart

  def add()
    add_item_to_cart(params[:item_id])
    redirect_back fallback_location: root_path
  end

  private
  def cart_params
    params.permit(:item_id)
  end

end
