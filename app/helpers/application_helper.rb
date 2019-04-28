module ApplicationHelper
  def get_address_options(user=nil)
    if user.nil? || user.role?(:admin)
      addresses = Address.active.by_recipient.to_a
    else
      addresses = user.customer.addresses.by_recipient.to_a
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
      current_customer.orders.joins(:items).group("items.id").order("COUNT(orders.id)").limit(4).select("items.*")
    else
      nil
    end
  end
end
