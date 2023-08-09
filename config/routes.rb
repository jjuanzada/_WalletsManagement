Rails.application.routes.draw do
  devise_for :employees, controllers: {
    registrations: 'employees/registrations'
  }
  
  root 'home#index'
  get '/all_transactions', to: 'api/v1/transactions#all_transactions'

  resources :users do
    get 'extract', on: :member

    namespace :api do
      namespace :v1 do
        # Credit value route
        post 'credit', to: 'transactions#credit'
        # Debit value route
        post 'debit', to: 'transactions#debit'
        # Retrieve balance route
        get 'balance', to: 'transactions#balance'
        # Retrieve transactions history route
        get 'transactions', to: 'transactions#transactions'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      get 'all_transactions', to: 'transactions#all_transactions'
    end
  end
  
end
