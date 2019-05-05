class CustomersController < ApplicationController
  include AppHelpers::Cart
  include ActionView::Helpers::NumberHelper
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @active_customers = Customer.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_customers = Customer.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    #@previous_orders = @customer.orders.chronological
  end

  def new
    @customer = Customer.new
    @customer.user = User.new
  end

  def edit
    # reformat phone w/ dashes when displayed for editing (preference; not required)
    @customer.phone = number_to_phone(@customer.phone)
  end

  def create
    """
    user_only_params = customer_params[:user]
    user_only_params[:active] = true
    user_only_params[:role] = 'customer'
    puts user_only_params
    @user = User.new(user_only_params)
    @user.save!
    @user.reload

    customer_only_params = { first_name: customer_params[:first_name], last_name: customer_params[:last_name], email: customer_params[:email], phone: customer_params[:phone], active: customer_params[:active] }
    customer_only_params[:user_id] = @user.id
    customer_only_params[:active] = true
    @customer = Customer.new(customer_only_params)
    @customer.save!

    address_only_params[:

    @address = Address.new(customer_params[:address])
    """
    @customer = Customer.new(customer_params)
    if !(logged_in? and current_user.role?(:admin))
      @customer.active = true
      @customer.user.active = true
      @customer.user.role = 'customer'
    end

    if @customer.save
      if !logged_in?
        login(@customer.user)
      end
      redirect_to new_address_path, notice: "#{@customer.proper_name} was added to the system. Now please create a billing address."
    else
      render action: 'new'
    end

  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: "#{@customer.proper_name} was revised in the system."
    else
      render action: 'edit'
    end
  end


  private
  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    #params.require(:customer).permit(:first_name, :last_name, :email, :phone, :active, address: [:customer_id, :recipient, :street_1, :street_2, :city, :state, :zip, :active, :is_billing, :customer_id], user: [ :username, :password, :password_confirmation, :active ])
    params.require(:customer).permit(:first_name, :last_name, :email, :phone, :active, user_attributes: [ :username, :role, :password, :password_confirmation, :active ])
  end

end
