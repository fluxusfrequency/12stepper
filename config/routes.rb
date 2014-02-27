TwelveStepper::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  scope "(:locale)", locale: /en|es|fr/ do

    get '/profile/edit', to: 'users#edit', as: "edit_profile"
    get '/profile/:username', to: 'users#show', as: :user_show
    resources :users, only: [:index, :new, :create, :update]
    patch '/entries/share/:id', to: 'entries#share_entry', as: "share_entry"
    resources :entries, except: :show

    get '/feed' => 'statuses#index', as: 'feed'
    resources :statuses, only: [:new, :create, :edit, :update, :destroy]

    patch '/worksheet_entries' => 'worksheet_entries#create'
    resources :worksheet_entries
    get '/login' => "sessions#new", as: "login"

    delete '/sessions', to: 'sessions#destroy'
    resources :sessions, only: [:new, :create, :destroy]

    get '/meetings/search' => "meetings#search_meetings", as: "search_meetings"
    resources :meetings, only: [:index, :search_meetings]

    namespace :big_book do
      get '/', to: 'chapters#index'
    end

    resources :friendships, only: [:index, :create]
    post '/friendships/accept/:id', to: 'friendships#update', as: :accept_friendship
    delete '/friendships/reject/:id', to: 'friendships#destroy', as: :reject_friendship
    delete '/friendships/remove/:id', to: 'friendships#destroy', as: :remove_friendship

    namespace :friends do
      resources :search, only: [:new, :create, :index]
    end

    namespace :api do
      namespace :v1 do

        namespace :entries do
          get '/search/:query', to: 'search#show'
        end

        namespace :worksheet do
          get '/entries', to: 'entries#index'
        end

        namespace :big_book do
          resources :chapters
          get '/search/:query', to: 'search#show'
        end

        namespace :feed do
          get '/statuses', to: 'statuses#index'
        end

      end
    end
  end

  get "/pages/*id" => 'pages#show', as: :page, format: false

  get '/:locale', to: 'statuses#index'
  root 'statuses#index'

  get '/*not_found', to: 'not_found#index'
end
