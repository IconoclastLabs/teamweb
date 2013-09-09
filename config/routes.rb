Teamweb::Application.routes.draw do
  
  mount Peek::Railtie => '/peek'

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks"}

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :tokens,:only => [:create, :destroy]
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
    resources :seasons do 
      resources :events do
        get 'add_user', on: :member
      end
      resources :teams do
        get 'add_user', on: :member
      end
    end
  end


# Special sans-organization event data
  match "new_event", to: "events#new_event", via: :all
  match "events", to: "events#create_event", via: :all
  match "all_events", to: "events#list", via: :all

  get "home/index"

  root :to => 'home#index'
end
