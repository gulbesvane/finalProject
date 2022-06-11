Rails.application.routes.draw do
  #pages controller action home
  root 'pages#home'
  #showcase get request send to pages controller action showcase
  get 'showcase', to: 'pages#showcase'
  #colab get request send to pages controller colab action
  get 'colab', to: 'pages#colab'
end
