Rails.application.routes.draw do
  devise_for :authors, :controllers => {registrations: 'registrations'}
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#index'
end
