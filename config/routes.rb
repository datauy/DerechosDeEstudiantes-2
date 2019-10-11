Rails.application.routes.draw do

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :complains
  resources :questions
  resources :answers
  resources :rights
  resources :doubts
  get 'static_pages/about_us'
  root to: 'static_pages#index'
end
