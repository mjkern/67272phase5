class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # for authorization
  before_action :check_login
  authorize_resource

  def index
    @active_admin = User.active.where('role = "admin"').alphabetical
    @active_bakers = User.active.where('role = "baker"').alphabetical
    @active_shippers = User.active.where('role = "shipper"').alphabetical
    @inactive_admin = User.where('active = "f" OR active ISNULL').where('role = "admin"').alphabetical
    @inactive_bakers = User.where('active = "f" OR active ISNULL').where('role = "baker"').alphabetical
    @inactive_shippers = User.where('active = "f" OR active ISNULL').where('role = "shipper"').alphabetical
  end

  def show
    if @user.role?(:customer)
      redirect_to customer_path(@user.customer)
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "#{@user.username} was added to the system."
    else
      render action: 'edit', notice: "Please properly fill in all fields"
    end
  end

  #junk
  def update
    if @user.update(user_params)
      redirect_to @user, notice: "#{@user.username} was revised in the system."
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
