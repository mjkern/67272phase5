module ApplicationHelper

  def format_date(date)
    date.strftime("%m/%d/%y")
  end

  def get_address_options(user=current_user)
    if user.nil? || user.role?(:admin)
      addresses = Address.active.by_recipient.to_a
    else
      addresses = current_customer.addresses.by_recipient.to_a
    end
    addresses.map{|addr| ["#{addr.recipient} : #{addr.street_1}", addr.id] }
  end

  def get_pop_items(count=4)
    # highest total quantity sold
    Item.all.joins(:order_items).group("id").order("SUM(quantity)").limit(count)
  end

  def get_fav_items(count=4)
    # most ordered by this customer
    if current_customer
      #current_customer.orders.joins(:items).group("items.id").order("COUNT(orders.id)").limit(4).select("items.*")
      #Item.all.joins(:order_items).group("id").where("order_items.customer_id = ?", current_customer.id)
      Item.all.joins(:order_items).joins(:orders).where("orders.customer_id = ?", current_customer.id).group("items.id").order("SUM(order_items.quantity)").limit(count)
    else
      nil
    end
  end

  def get_recent_orders(count=7)
    if current_customer
      Order.chronological.where("customer_id = ?", current_customer.id).limit(count)
    else
      nil
    end
  end

  def cart_size
    if session[:cart]
      count = 0
      session[:cart].each do |item_id, quantity| count += quantity end
      count
    else
      0
    end
  end
end
