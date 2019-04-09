module Populator
  module Orders
    def create_orders_for(customers)
      all_items = Item.all

      customers.each do |customer|
        c_address_ids = customer.addresses.map(&:id)
        customer_selections = all_items.shuffle
        [1,1,1,2,2,2,2,3,3,3,3,4,4,5,6,7,9,10,12].sample.times do |i|
        # (1..12).to_a.sample.times do |i|
          order = Order.new
          order.credit_card_number = '4123456789012'
          order.expiration_year = Date.current.year
          order.expiration_month = Date.current.month
          order.customer_id = customer.id
          order.address_id = c_address_ids.sample
          order.date = (5.months.ago.to_date..2.days.ago.to_date).to_a.sample
          order.save!
          total = 0
          [1,1,2,2,2,3,3,4,5,6].sample.times do |j|
            this_item = customer_selections.pop
            oi = OrderItem.new
            oi.item_id = this_item.id
            oi.order_id = order.id
            oi.quantity = [1,2,3,4].sample
            oi.save!
            total += oi.subtotal(order.date)
          end
          # record total and payment
          total += order.shipping_costs
          order.update_attribute(:grand_total, total)
          order.pay
          # ship the items
          order.order_items.each{|oi2| oi2.shipped_on = order.date + 1; oi2.save! }
          # reset the selection options
          customer_selections = all_items.shuffle
        end
      end

    end
  end
end