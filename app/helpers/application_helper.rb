module ApplicationHelper

  def get_top_customers(days_back)
    Order.where("date > ?", (days_back+1).days.ago)
      .group(:customer_id)
      .select("customer_id, SUM(grand_total) AS s")
      .order("s desc").limit(6)
      .map {|o| [Customer.find(o.customer_id).name, o.s] }
  end

  def format_date(date)
    date.strftime("%m/%d/%y")
  end

  def get_address_options(user=current_user)
    if user.nil? || user.role?(:admin)
      addresses = Address.active.by_recipient.to_a
    else
      addresses = current_customer.addresses.by_recipient.to_a
      #addresses -= [current_customer.billing_address]
      #addresses.unshift(current_customer.billing_address)
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

  def get_recent_orders(customer=current_customer, count=7)
    if customer
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

  def get_baking_list(category=nil)
    if category
      OrderItem.unshipped.joins(:item).where("items.category LIKE ?", category).group("order_items.item_id").select("order_items.id, SUM(quantity) AS count")
        .map {|r| [OrderItem.where(id: r.id).first.item, r.count]}
        .sort {|a, b| a[0].name <=> b[0].name}
    else
      OrderItem.unshipped.group("order_items.item_id").select("order_items.id, SUM(quantity) AS count")
        .map {|r| [OrderItem.where(id: r.id).first.item, r.count]}
        .sort {|a, b| a[0].name <=> b[0].name}
    end
  end
end
