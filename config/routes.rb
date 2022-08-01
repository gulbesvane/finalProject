Rails.application.routes.draw do
  resources :collabs do
    member do
      get 'join'
      get 'leave'
    end
  end
  # route post/nr/comments nested route
  resources :posts do
    resources :comments
  end
  # route collab/nr/message/nr
  resources :collabs do
    resources :messages
  end
  # route posts/tag/....
  get 'tags/:tag', to: 'posts#index', as: :tag
  # route collabs/skill/....
  get 'skill/:skill', to: 'collabs#index', as: :skill

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
