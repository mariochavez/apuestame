Rails.application.routes.draw do

  resources :campaigns

  resource :sessions, only: [:create, :new]
  resource :identity, only: [:create, :new, :edit, :update, :show]
  delete 'log_out' => 'sessions#destroy', as: :log_out
  get 'log_in' => 'sessions#new', as: :log_in
  get 'sign_up' => 'identities#new', as: :sign_up

  get 'pages/home' => 'high_voltage/pages#show', id: 'home'
end
