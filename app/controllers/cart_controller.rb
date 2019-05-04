class CartController < ApplicationController

  include AppHelpers::Cart

  def index
    @order_items = get_list_of_items_in_cart
    @items_total = calculate_cart_items_cost
    @shipping_costs = calculate_cart_shipping_cost
  end

  def add()
    add_item_to_cart(params[:item_id])
    redirect_back fallback_location: root_path
  end

  private
  def cart_params
    params.permit(:item_id)
  end

end
