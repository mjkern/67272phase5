class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @active_admin = User.active.where('role = "admin"').alphabetical
    @active_bakers = User.active.where('role = "baker"').alphabetical
    @active_shippers = User.active.where('role = "shipper"').alphabetical
    @inactive_admin = User.inactive.where('role = "admin"').alphabetical
    @inactive_bakers = User.inactive.where('role = "baker"').alphabetical
    @inactive_shippers = User.inactive.where('role = "shipper"').alphabetical
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

  # junk
  def create
    if @customer.save
      redirect_to addresses_new_path, notice: "#{@customer.proper_name} was added to the system."
    else
      puts "it did not work..."
    end
  end

  #junk
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
