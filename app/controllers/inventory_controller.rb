class InventoryController < ApplicationController
  before_action :check_permission

  def my_inventory
    @markets = Market.where(:user_id => session[:userid])
  end

  def add_inventory
    item_id = params[:item_id]
    stock = params[:stock]
    price = params[:price]

    market = Market.new
    market.user_id = session[:userid]
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

  def edit_item_inventory
    @market = Market.find(params[:market_id])
  end

  def update_item_inventory
    market_id = params[:market_id]

    market = Market.find(market_id)

    market.stock = params[:stock]

    market.price = params[:price]

    begin
      if market.save
        redirect_to my_inventory_path
      end
    rescue
      redirect_to my_inventory_path
    end
  end

  private

  def check_permission
    if (is_authen? && (is_admin? || is_seller?))
      session[:authen] = session[:authen]
    else
      flash[:notice] = "ไม่มีสิทธิเข้าถึง"
      redirect_to :controller => "main", :action => "main"
    end
  end
end
