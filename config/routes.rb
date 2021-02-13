Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        resources :find, controller: 'search', only: [:index]
        resources :find_all, controller: 'search', only: [:index]
      end

      namespace :items do
        resources :find, controller: 'search', only: [:index]
        resources :find_all, controller: 'search', only: [:index]
      end

      resources :merchants, module: :merchants, only: [:index, :show] do 
        resources :items, only: [:index]
      end
      

      resources :items, module: :items, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
        resources :merchant, only: [:index]
      end
      

      namespace :revenue do
        resources :merchants, only: [:index, :show]
        resources :items, only: [:index]
        resources :unshipped, only: [:index]
        resources :weekly, only: [:index]
      end
    end
  end
end