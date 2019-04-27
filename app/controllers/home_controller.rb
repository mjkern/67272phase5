class HomeController < ApplicationController

  def home
    if logged_in?
      puts "logged in"
    end
  end

  def about
  end

  def privacy
  end

  def contact
  end

end
