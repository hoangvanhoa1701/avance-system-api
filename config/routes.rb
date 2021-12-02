Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      namespace 'auth' do
        post '/register', to: "register#create"
        post '/authenticate', to: "authenticate#create"
        get '/me', to: "me#show"
      end

      get '/private/hello', to: "private#hello"
      get '/public/hello', to: "public#hello"
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
