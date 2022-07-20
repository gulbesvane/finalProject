Rails.application.routes.draw do
  resources :collabs do
    member do
      get 'join'
      get 'leave'
    end
  end
  
  get 'tags/:tag', to: 'posts#index', as: :tag

  # this will create route posts/2/comments/4
  resources :posts do
    resources :comments
  end
  
  #pages controller action home
  root 'pages#home'
  # signup get request sned to users controlled action new
  get 'signup', to: 'users#new'
  # create all routes for users except nes as it is defined already
  resources :users, except: [:new]
  #showcase get request send to pages controller action showcase
  get 'showcase', to: 'pages#showcase'

  #login/logout routes
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
