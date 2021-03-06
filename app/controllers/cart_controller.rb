class CartController < ApplicationController

  include AppHelpers::Cart

  def index
    @order_items = get_list_of_items_in_cart
    @items_total = calculate_cart_items_cost
    @shipping_costs = calculate_cart_shipping_cost
  end

  def add()
    add_item_to_cart(params[:item_id])
    @item = Item.find(params[:item_id])
    redirect_back fallback_location: root_path, notice: "#{@item.name} added to cart"
  end

  def sub()
    id = params[:item_id]
    if session[:cart].keys.include?(id)
      if session[:cart][id] > 0
        session[:cart][id] -= 1
      end
    end
    @item = Item.find(params[:item_id])
    redirect_back fallback_location: cart_path, notice: "One #{@item.name} removed from your cart"
  end

  def remove()
    remove_item_from_cart(params[:item_id])
    @item = Item.find(params[:item_id])
    redirect_back fallback_location: cart_path, notice: "#{@item.name} removed from cart"
  end

  private
  def cart_params
    params.permit(:item_id)
  end

end
