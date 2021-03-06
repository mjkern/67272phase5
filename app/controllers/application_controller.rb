class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You are not authorized to take that action"
    redirect_to home_path
  end

	# reused from lab10
	private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    current_user
  end
  helper_method :logged_in?

  def check_login
    redirect_to login_url, alert: "You need to log in to view this page." if current_user.nil?
  end

  def current_customer
    @current_customer ||= current_user.customer
  end
  helper_method :current_customer

  def logout
    @current_customer = nil
    @current_user = nil
    session[:user_id] = nil
  end

  def login(user)
    session[:user_id] = user.id
    create_cart
  end

end
