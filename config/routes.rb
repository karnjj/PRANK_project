Rails.application.routes.draw do
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
