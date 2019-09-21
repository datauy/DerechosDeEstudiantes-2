Rails.application.routes.draw do

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :complains
  get 'static_pages/about_us'
  root to: 'static_pages#index'

end
