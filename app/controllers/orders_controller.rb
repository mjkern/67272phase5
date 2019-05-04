class OrdersController < ApplicationController
  before_action :set_order, only: [:destroy, :index]

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
    if @order.save
      @order.pay
      redirect_to @order, notice: "Thank you for ordering from the Baking Factory."
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
    params.require(:order).permit(:address_id, :customer_id, :grand_total)
  end

end
