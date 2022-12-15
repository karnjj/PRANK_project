class MarketController < ApplicationController
  before_action :check_permission

  def my_market
    @markets = Market.joins(:item).where("items.enable = true AND stock > 0")
  end

  def buy_item_market
    user_id = session[:userid]
    market_id = params[:market_id]
    amount = params[:amount].to_i

    market = Market.find(market_id)

    if market.stock >= amount
      market.stock = market.stock - amount

      if market.save
        inventory = Inventory.new
        inventory.item_id = market.item_id
        inventory.price = market.price
        inventory.qty = amount
        inventory.seller_id = market.user_id
        inventory.user_id = 2
        if inventory.save
          redirect_to my_market_path
        end
      end
    else
      redirect_to my_market_path, notice: "จำนวนสินค้ามีไม่พอ"
    end
  end

  def purchase_history
    @inventories = Inventory.where(:user_id => session[:userid])
  end

  private

  def check_permission
    if (is_authen? && (is_admin? || is_buyer?))
      session[:authen] = session[:authen]
    else
      flash[:notice] = "ไม่มีสิทธิเข้าถึง"
      redirect_to :controller => "main", :action => "main"
    end
  end
end
