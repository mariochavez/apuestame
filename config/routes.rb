Rails.application.routes.draw do
  resource :sessions, only: [:create, :new]
  resource :organization, only: [:create, :new]
  delete 'log_out' => 'sessions#destroy', as: :log_out
  get 'log_in' => 'sessions#new', as: :log_in
  get 'sign_up' => 'organizations#new', as: :sign_up

  get 'pages/home' => 'high_voltage/pages#show', id: 'home'
end
