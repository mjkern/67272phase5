class HomeController < ApplicationController

  def home
    if logged_in?
      if current_user.role?(:shipper)
        @orders = Order.not_shipped.chronological.paginate(page: params[:page]).per_page(6)
      end
    end
  end

  def about
  end

  def privacy
  end

  def contact
  end

end
