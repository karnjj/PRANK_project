class MainController < ApplicationController
	def login
		session[:authen] = false
	end

	def main
		if(!session[:authen])
			redirect_to :controller=>'main',:action=>'login'
		else
			user_type = User.find(session[:userid].to_i).user_type
			@id = session[:userid].to_i
			@index=0
			if(user_type == 0) # admin
				@page_list = ["profile","my_market","purchase_history","sale_history","my_inventory","top_seller","user_control","item_control"]
				@page_link = ["/main/profile","/my_market","/purchase_history","/main/sale_history","/my_inventory","/main/top_seller","/admin/user","item_control"]
			elsif(user_type == 1) # seller
				@page_list = ["profile","sale_history","my_inventory","top_seller"]
				@page_link = ["/main/profile","/main/sale_history","/my_inventory","/main/top_seller"]
			else # buyer
				@page_list = ["profile","my_market","purchase_history"]
				@page_link = ["/main/profile","/my_market","/purchase_history"]
			end
		end

		
	end

	def top_seller
		if(!session[:authen] || User.find(session[:userid].to_i).user_type == 2 )
			redirect_to :controller=>'main',:action=>'login'
		end

		indexs = Struct.new(:price, :qty,:date, :id, :name)
		#all_seller = User.where(user_type: 1)
		seller_sale = []
		Inventory.all.each do |invent|
			seller_sale.append( indexs.new(invent.price,invent.qty,invent.created_at,invent.seller_id,User.find(invent.seller_id).name) )
		end
		#seller_sale.append(indexs.new(10,5,User.find(2).created_at,6,"prias"))
		#seller_sale.append(indexs.new(10,5,User.find(2).created_at,6,"prias"))
		#seller_sale.append(indexs.new(10,5,User.find(2).created_at,2,"Korss"))
		#@sorted_seller = seller_sale.sort_by { |p| [p.qty,p.id]}
		# @invent = seller_sale.sort_by { |p| [p.id,]}
		 @invent = seller_sale.sort_by {|p| [p.id,p.date]}
		#@invent = [[3,2],[4,7]]
	end

	def profile
		if(!session[:authen])
			redirect_to :controller=>'main',:action=>'login'
		end
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
			flash[:notice] = 'Username / Password is wrong'
			redirect_to :controller=>'main',:action=>'login'
		end
	end

	def relay2
		if(!session[:authen])
			redirect_to :controller=>'main',:action=>'login'
		else
			npassword = params[:newpassword]
			npasswordconfirm = params[:newpasswordconfirm]
			if(npassword == npasswordconfirm)
				if(npassword.length >= 8)
					users = User.find(session[:userid].to_i)
					users.password = npassword
					if(users.save)
						flash[:notice] = 'Password change successfully'
						redirect_to :controller=>'main',:action=>'profile'
					else
						flash[:notice] = 'Password change failed'
						redirect_to :controller=>'main',:action=>'profile'
					end
				else
					flash[:notice] = 'Password length must be more than 8 character'
					redirect_to :controller=>'main',:action=>'profile'
				end
			else
				flash[:notice] = 'Newpassword and Confirmpassword is not the same'
				redirect_to :controller=>'main',:action=>'profile'
			end
		end
	end

	def sale_history
		if(!session[:authen] || User.find(session[:userid].to_i).user_type == 2 )
			redirect_to :controller=>'main',:action=>'login'
		end
		@inventories = Inventory.where(:seller_id => session[:userid])
	end

end
