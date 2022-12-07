class MainController < ApplicationController
	def login
		session[:authen] = false
	end

	def main
		user_type = User.find(session[:userid].to_i).user_type
		@id = session[:userid].to_i
		@index=0
		if(user_type == 0) # admin
			@page_list = ["profile","my_market","purchase_history","sale_history","my_inventory","top_seller","user_control","item_control"]
			@page_link = ["/main/profile","my_market","purchase_history","sale_history","my_inventory","top_seller","/admin/user","item_control"]
		elsif(user_type == 1) # seller
			@page_list = ["profile","sale_history","my_inventory","top_seller"]
			@page_link = ["/main/profile","sale_history","my_inventory","top_seller"]
		else # buyer
			@page_list = ["profile","my_market","purchase_history"]
			@page_link = ["/main/profile","my_market","purchase_history"]
		end
	end

	def top_seller
		indexs = Struct.new(:qty, :id)
		all_seller = User.where(user_type: 1)
		seller_sale = []
		all_seller.each do |seller|
			count = 0
			all_inven = Inventory.where(seller_id: seller.id)
			all_inven.each do |inven|
				count = count + inven.qty
			end
			seller_sale.append( indexs.new(count,seller.id) )
		end
		@sorted_seller = seller_sale.sort_by { |p| [p.qty,p.id]}
	end

	def profile
		@user = User.find(session[:userid].to_i)
	end

	def relay
		username = params[:userid]
		pass = params[:password]
		#users = User.find(1)
		users = User.where(email: username)[0]
		if(users != nil and users.authenticate(pass))
			session[:userid] = users.id
			session[:authen] = true
			redirect_to :controller=>'main',:action=>'main'
		else
			redirect_to :controller=>'main',:action=>'login'
		end
	end

end
