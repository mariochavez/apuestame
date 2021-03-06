Rails.application.routes.draw do
  root to: 'main#index'
  resources :campaigns
  resources :rewards, only: [:show]
  resources :payments do
      match :show, :via => [:get], :on => :collection
      match :success, :via => [:get], :on => :collection
   end

  resources :main do
    match :getGeolocatedCampaigns, :via => [:post], :on => :collection
  end


  resource :sessions, only: [:create, :new]
  resource :identity, only: [:create, :new, :edit, :update, :show]
  delete 'log_out' => 'sessions#destroy', as: :log_out
  get 'log_in' => 'sessions#new', as: :log_in
  get 'sign_up' => 'identities#new', as: :sign_up

  #get 'pages/home' => 'main#index', id: 'home'
  #get 'pages/home' => 'high_voltage/pages#show', id: 'home'
end
