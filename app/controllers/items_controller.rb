  class ItemsController < ApplicationController
  before_action :check_login, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy, :toggle]
  authorize_resource

  def toggle
    @item.active = !@item.active
    @item.save!
    #redirect_back fallback_location: item_path(@item)
  end

  def index
    @breads = Item.for_category('bread').alphabetical#.paginate(:page => params[:page]).per_page(10)
    @muffins = Item.for_category('muffins').alphabetical#.paginate(:page => params[:page]).per_page(10)
    @pastries = Item.for_category('pastries').alphabetical#.paginate(:page => params[:page]).per_page(10)
    @items = Item.alphabetical
    #@inactive_items = Item.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
    if !(logged_in? && current_user.role?(:admin))
      @breads = @breads.active
      @muffins = @muffins.active
      @pastries = @pastries.active
      @items = @items.active
    end
  end

  def show
    if logged_in? && current_user.role?(:admin)
      # admin gets a price history in the sidebar
      @previous_prices = @item.item_prices.chronological.to_a
      @items = Item.alphabetical
    else
      @items = Item.active.alphabetical
    end
    # everyone sees similar items in the sidebar
    @similar_items = Item.for_category(@item.category).alphabetical.to_a
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to new_price_for_item_path(@item.id), notice: "#{@item.name} was added to the system. Please give it an intial price."
    else
      render action: 'new'
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: "#{@item.name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    if !@item.destroy
      redirect_to item_url(@item), notice: "#{@item.name} could not be destroyed"
    end
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :photo, :category, :units_per_item, :weight, :active)
  end

end
