class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  # for authorization
  #before_action :check_login
  #authorize_resource


  def index
    @active_addresses = Address.active.by_customer.by_recipient.paginate(:page => params[:page]).per_page(10)
    @inactive_addresses = Address.inactive.by_customer.by_recipient.paginate(:page => params[:page]).per_page(10)
  end

  def show
  end

  def new
    @address = Address.new
  end

  def edit
  end

  def create
    @address = Address.new(address_params)
    if current_user.role?(:customer)
      @address.customer = current_customer
      @address.active = true
    end
    if @address.customer.addresses.count == 0
      @address.is_billing = true
    end
    if @address.save
      redirect_to customer_path(@address.customer), notice: "The address was added to #{@address.customer.proper_name}."
    else
      render action: 'new'
    end
  end

  def update
    if @address.update(address_params)
      redirect_to customer_path(@address.customer), notice: "The address was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    if @address.destroy
      redirect_back fallback_location: customer_path(@address.customer), notice: "Address deleted"
    else
      redirect_back fallback_location: customer_path(@address.customer), notice: "Address could not be deleted"
    end
  end

  private
  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:customer_id, :recipient, :street_1, :street_2, :city, :state, :zip, :active, :is_billing, :customer_id)
  end

end
