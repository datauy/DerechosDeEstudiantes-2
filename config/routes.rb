Rails.application.routes.draw do
<<<<<<< Updated upstream
=======
  default_url_options :host => "derechosdeestudiantes.edu.uy"
=begin  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#not_found', :via => :all
    match '/500' => 'errors#internal_server_error', :via => :all
=end
>>>>>>> Stashed changes
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
