class OrdersController < ApplicationController
  # for cart functionality
  include AppHelpers::Cart

  before_action :set_order, only: [:destroy, :index]

  # for authorization
  before_action :check_login
  authorize_resource

  def index
    orders = Order.chronological
    if @order
      page = (orders.index(@order) / 6) + 1
    end
    page ||= params[:page]
    @all_orders = orders.paginate(page: page,).per_page(6)
    #@all_orders = Order.chronological.paginate(:page => params[:page]).per_page(10)
  end

 # def show
 #   #@previous_orders = @order.customer.orders.chronological.to_a
 #   redirect_to controller: 'orders', action: 'index', id: "#{params[:id]}"
 # end

  def new
    @order = Order.new
    @months = (1..12).map {|n| [n.to_s, n]}
    @years = (0..5).map {|y| [y.years.from_now.year.to_s, y.years.from_now.year]}
  end

  def create
    @order = Order.new(order_params)
    @order.date = Date.current
    @order.customer ||= current_customer
    @order.expiration_year = @order.expiration_year.to_i
    @order.expiration_month = @order.expiration_month.to_i
    @order.grand_total = calculate_cart_items_cost + calculate_cart_shipping_cost
    if @order.save
      @order.pay
      @order.reload
      save_each_item_in_cart(@order)
      clear_cart
      redirect_to home_path, notice: "Thank you for ordering from the Baking Factory."
    else
      render action: 'new'
    end
  end


  private
  def set_order
    if not params[:id].nil?
      @order = Order.find(params[:id])
    else
      @order = nil
    end
  end

  def order_params
    params.require(:order).permit(:address_id, :customer_id, :expiration_month, :expiration_year, :credit_card_number)
  end

end
