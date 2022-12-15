Rails.application.routes.draw do
  get "my_market", to: "market#my_market", as: "my_market"
  post "buy_item_market", to: "market#buy_item_market", as: "buy_item_market"
  get "purchase_history", to: "market#purchase_history", as: "purchase_history"
  get "my_inventory", to: "inventory#my_inventory", as: "my_inventory"
  get "add_item_to_sell", to: "inventory#add_item_to_sell", as: "add_item_to_sell"
  post "add_inventory", to: "inventory#add_inventory", as: "add_inventory"
  get "edit_item_inventory/:market_id", to: "inventory#edit_item_inventory", as: "edit_item_inventory"
  post "update_item_inventory/:market_id", to: "inventory#update_item_inventory", as: "update_item_inventory"
  delete "delete_inventory/:market_id", to: "inventory#delete_inventory", as: "delete_inventory"
  resources :items
  resources :users
  get 'login' => 'main#login'
  post '/main/relay'
  get 'main' => 'main#main'
  get 'profile' => 'main#profile'
  get 'user' => 'admin#user'
  get 'user/:id' => 'admin#user_show'
  get 'user/edit/:id' => 'admin#user_edit'
  post 'user/destroy/:id' => 'admin#user_destroy'
  get 'top_seller' => 'main#top_seller'
  get 'sale_history' => 'main#sale_history'
  post '/main/relay2'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
