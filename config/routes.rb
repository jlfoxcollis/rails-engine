Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, module: :merchants, only: [:index, :show] do 
        resources :items, only: [:index]
        resources :find, controller: 'search', only: [:show]
      end

      resources :items, module: :items, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
        resources :merchant, only: [:index]
        resources :find_all, controller: 'search', only: [:index]
      end

      resources :revenue, module: :revenue, only: [:index] do
        resources :merchants, only: [:index, :show]
        resources :items, only: [:index]
        resources :unshipped, only: [:index]
        resources :weekly, only: [:index]
      end
    end
  end
end