TwelveStepper::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  scope "(:locale)", locale: /en|es|fr/ do
    resources :users
    resources :entries
    resources :worksheet_entries
    resources :sessions
    get '/meetings/search' => "meetings#search_meetings", as: "search_meetings"
    resources :meetings
    delete '/sessions', to: 'sessions#destroy'

    namespace :big_book do
      get '/', to: 'chapters#index'
      resources :chapters
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

  get '/:locale', to: 'entries#index'
  root 'entries#index'
end
