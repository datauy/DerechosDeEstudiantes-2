Rails.application.routes.draw do
  default_url_options :host => "derechosdeestudiantes.edu.uy"
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

end
