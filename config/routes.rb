Rails.application.routes.draw do
  Rails.application.routes.draw do
    devise_for :users , controllers:{passwords: 'users/passwords', sessions: 'users/sessions'}
    root to: 'static_pages#index'
  end
end
