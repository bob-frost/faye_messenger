Messenger::Application.routes.draw do
  root 'dialogs#index'
  get '/' => 'dialogs#index', as: :dialogs
  resources :dialogs, only: [:show] do
    member do
      patch 'read/:until_id', action: :read
    end
    resources :messages, only: [:create] do
      member do
        patch 'read'
      end
    end
  end
  
  devise_for :users, controllers: { sessions: 'sessions',
                                    registrations: 'registrations' }

  resources :users, only: [:index]
end
