TwelveStepper::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  scope "(:locale)", locale: /en|es|fr/ do

    resources :users, only: [:index, :new, :create, :update]
    get '/:id/profile', to: 'users#edit', as: "edit_user"

    resources :entries
<<<<<<< HEAD
    resources :worksheet_entries
    resources :sessions
    get '/meetings/search' => "meetings#search_meetings", as: "search_meetings"
    resources :meetings
=======

    get '/login' => "sessions#new", as: "login"
>>>>>>> d48dde51cc1abaf1763bcd0e9a734201b8a54d17
    delete '/sessions', to: 'sessions#destroy'
    resources :sessions, only: [:new, :create, :destroy]

    get '/meetings/search' => "meetings#search_meetings", as: "search_meetings"
    resources :meetings, only: [:index, :search_meetings]

    namespace :big_book do
      get '/', to: 'chapters#index'
    end


    namespace :api do
      namespace :v1 do

        namespace :entries do
          get '/search/:query', to: 'search#show'
        end

        namespace :big_book do
          resources :chapters
          get '/search/:query', to: 'search#show'
        end

      end
    end
  end

  get "/pages/*id" => 'pages#show', as: :page, format: false

  get '/:locale', to: 'entries#index'
  root 'entries#index'
end
