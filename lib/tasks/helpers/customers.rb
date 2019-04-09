module Populator
  module Customers
    require 'faker'
    
    def create_customers
      all_customers = Array.new
      120.times do
        first_name = Faker::Name.first_name
        last_name = Faker::Name.last_name
        this_user = FactoryBot.create(:user)
        customer = FactoryBot.create(:customer, user: this_user, first_name: first_name, last_name: last_name)
        all_customers << customer
      end
      all_customers
    end
  end
end
