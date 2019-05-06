class ItemPricesController < ApplicationController

  def new
    @item_price = ItemPrice.new
    @item_id = params[:item_id]
  end

  def create
    @item_price = ItemPrice.new(item_price_params)

    if @item_price.save
      redirect_to item_path(@item_price.item), notice: "The price of #{@item_price.item.name} has successfully been updated."
    else
      render action: 'new'
    end
  end

  private

  def item_price_params
    params.require(:item_price).permit(:item_id, :price)
  end

end
