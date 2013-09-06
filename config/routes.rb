PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: :destroy do

    member do
      post 'vote'
    end


    resources :comments do
      member do
        post 'vote'
      end
    end

  end

  resources :categories

  get '/register', to: 'users#new'
  resources :users, :formats => [:html]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  match '/pin', to: 'sessions#pin', via:[:post,:get]

end
