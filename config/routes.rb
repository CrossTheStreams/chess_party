Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#show'

  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy'
  end

end
