Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      namespace 'auth' do
        post '/register', to: "register#create"
        post '/authenticate', to: "authenticate#create"
        delete '/logout', to: "authenticate#destroy"
        get '/me', to: "me#show"
        post '/refresh-token', to: "refresh_token#create"
      end

      resources :users, only: [:create, :index, :show, :update]
      # get '/users', to: "users#index"
      # get '/users/', to: "users#show"

      get '/programs', to: "programs#index"
      post '/programs', to: "programs#create"
      get '/programs/:id', to: "programs#show"
      put '/programs/:id', to: "programs#update"
      delete '/programs/:id', to: "programs#destroy"

      resources :sessions, only: [:index, :create, :show, :update, :destroy]
      resources :categories, only: [:index, :create, :show, :update, :destroy]

      get '/private/hello', to: "private#hello"
      get '/private-scoped', to: "private#private_scoped"
      get '/public/hello', to: "public#hello"
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
