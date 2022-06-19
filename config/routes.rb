Rails.application.routes.draw do
  get 'tags/:tag', to: 'posts#index', as: :tag
  resources :posts
  #pages controller action home
  root 'pages#home'
  #showcase get request send to pages controller action showcase
  get 'showcase', to: 'pages#showcase'
  #colab get request send to pages controller colab action
  get 'colab', to: 'pages#colab'
end
