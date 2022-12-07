Rails.application.routes.draw do
  get "my_inventory", to: "inventory#my_inventory", as: "my_inventory"
  get "add_item_to_sell", to: "inventory#add_item_to_sell", as: "add_item_to_sell"
  post "add_inventory", to: "inventory#add_inventory", as: "add_inventory"
  delete "delete_inventory/:market_id", to: "inventory#delete_inventory", as: "delete_inventory"
  resources :items
  resources :users
  get '/main/login'
  post '/main/relay'
  get '/main/main'
  get '/main/profile'
  get '/admin/user'
  get '/admin/user/:id' => 'admin#user_show'
  get '/admin/user/edit/:id' => 'admin#user_edit'
  post '/admin/user/destroy/:id' => 'admin#user_destroy'
  get '/main/top_seller'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
