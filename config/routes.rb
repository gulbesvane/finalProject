Rails.application.routes.draw do
  get 'tags/:tag', to: 'posts#index', as: :tag
  resources :posts
  #pages controller action home
  root 'pages#home'
  # signup get request sned to users controlled action new
  get 'signup', to: 'users#new'
  # create all routes for users except nes as it is defined already
  resources :users, except: [:new]
  #showcase get request send to pages controller action showcase
  get 'showcase', to: 'pages#showcase'
  #colab get request send to pages controller colab action
  get 'colab', to: 'pages#colab'

  #login/logout routes
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
