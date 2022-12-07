class InventoryController < ApplicationController
  def my_inventory
    @markets = Market.where(:user_id => 2) # mock
  end

  def add_inventory
    item_id = params[:item_id]
    stock = params[:stock]
    price = params[:price]

    market = Market.new
    market.user_id = 2 # mock
    market.item_id = item_id
    market.stock = stock
    market.price = price

    if market.save
      redirect_to my_inventory_path
    end
  end

  def delete_inventory
    market_id = params[:market_id]

    market = Market.find(market_id)

    market.destroy

    redirect_to my_inventory_path
  end

  def add_item_to_sell
    @items = Item.where(:enable => true)
  end
end
