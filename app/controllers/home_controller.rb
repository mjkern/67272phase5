class HomeController < ApplicationController

  # for authorization
  #authorize_resource

  def home
    if logged_in?
      if current_user.role?(:shipper)
        redirect_to shipping_path
      elsif current_user.role?(:baker)
        redirect_to baking_path
      end
    else
      redirect_to items_path
    end
  end

  def about
  end

  def privacy
  end

  def contact
  end

  def shipping
    @orders = Order.not_shipped.chronological.paginate(page: params[:page]).per_page(6)
  end

  def baking
  end

end
