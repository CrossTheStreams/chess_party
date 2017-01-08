Rails.application.routes.draw do
  root to: 'games#index'

  resources :games

  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 
  devise_scope :user do
    get 'sign_out', to: 'users/sessions#destroy'
  end

end
