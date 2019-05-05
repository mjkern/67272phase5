class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    if user.role?(:admin)
      can :manage, :all
      can :toggle, orderitem
    elsif user.role?(:customer)
      can :read, Item
      can :show, user
      can :update, user
      can :show, user.customer
      can :update, user.customer
      can :show, user.customer.orders
      can :index, Order
      can :checkout, Order
      can :create, Order
      can :add_to_cart, Order
      can :index, Address
      can :create, Address
      can :show, user.customer.addresses
      can :update, user.customer.addresses
    elsif user.role?(:baker)
      can :read, Item
      can :index, Order
    elsif user.role?(:shipper)
      can :read, Item
      can :read, Order
      can :show, Address
      can :toggle, orderitem
    else
      #can :show, Item
      #can :index, Item
      can :read, Item
      can :create, Customer
    end

  end
end
