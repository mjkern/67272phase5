class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    if @user.role?(:customer)
      redirect_to customer_path(@user.customer)
    end
  end

  def new
  end

  def edit
  end

  def create
    @customer = Customer.new(customer_params)
    p @customer.user
    if @customer.save
      puts "it worked"
      redirect_to addresses_new_path, notice: "#{@customer.proper_name} was added to the system."
    else
      puts "it did not work..."
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
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :role, :active)
  end

end
