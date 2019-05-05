class OrderItemsController < ApplicationController
  before_action :check_login
  before_action :set_order_item
  authorize_resource

  def toggle
    if @order_item.shipped_on.nil?
      @order_item.shipped_on = Date.today.to_date
    else
      @order_item.shipped_on = nil
    end
    @order_item.save!
    redirect_back fallback_location: root_path
  end

  private
  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:id)
  end

end
