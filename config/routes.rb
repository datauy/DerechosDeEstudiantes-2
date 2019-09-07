Rails.application.routes.draw do

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #devise_for :users , controllers:{passwords: 'users/passwords', sessions: 'users/sessions'}
  root to: 'static_pages#index'
end
