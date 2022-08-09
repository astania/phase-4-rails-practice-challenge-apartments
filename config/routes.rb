Rails.application.routes.draw do
  resources :leases, only: [:destroy, :create]
  resources :tenants, except: [:put]
  resources :apartments, except: [:put]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
