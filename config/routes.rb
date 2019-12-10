Rails.application.routes.draw do
  localized do
    get 'about_us', to: 'static_pages#about_us'
    ActiveAdmin.routes(self)
    devise_for :users, ActiveAdmin::Devise.config
    namespace :admin do
      resources :questions do
        resources :answers
      end
    end

    namespace :admin do
      resources :rights do
        resources :doubts
      end
    end
    resources :complains
    resources :questions
    resources :answers
    resources :rights
    resources :doubts
    root to: 'static_pages#index'
  end
  match '/404' => 'errors#not_found', :via => :all
  match '/500' => 'errors#internal_server_error', :via => :all

end
