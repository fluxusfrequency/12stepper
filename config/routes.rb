TwelveStepper::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  scope "(:locale)", locale: /en|es|fr/ do
    # resources :entries
    resources :users
    resources :entries
    resources :sessions
    get '/meetings/search' => "meetings#search_meetings", as: "search_meetings"
    resources :meetings
    delete '/sessions', to: 'sessions#destroy'
  end

  get '/:locale', to: 'entries#index'
  root 'landing#index'
end
