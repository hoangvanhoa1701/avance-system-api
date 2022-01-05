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

      # resources :roles, only: %i[index create show update]
      get '/roles/all', to: "roles#index"
      get '/roles/admin', to: "roles#index_admin"
      get '/roles/contentadmin', to: "roles#index_contentadmin"
      get '/roles/educator', to: "roles#index_educator"
      get '/roles/usernone', to: "roles#index_usernone"

      put '/roles', to: "roles#update"
      delete '/roles/:id', to: "roles#destroy"

      resources :users, only: %i[index create show update]
      resources :programs, only: %i[index create show update destroy]
      resources :sessions, only: %i[index create show update destroy]
      resources :categories, only: %i[index create show update destroy]

      get '/private/hello', to: "private#hello"
      get '/private-scoped', to: "private#private_scoped"
      get '/public/hello', to: "public#hello"
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
