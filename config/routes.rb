Teamweb::Application.routes.draw do
  
  resources :seasons

  mount Peek::Railtie => '/peek'

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks"}

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :organizations #do
        # resources :events do
        #   get 'add_user', on: :member

        #   resources :teams do
        #     get 'add_user', on: :member
        #   end
        # end
      #end
    end
  end

  resources :organizations do
    resources :events do
      get 'add_user', on: :member
      resources :teams do
        get 'add_user', on: :member
      end
    end
  end

  match "events", to: "events#list", via: :all

  get "home/index"

  root :to => 'home#index'
end
