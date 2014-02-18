TwelveStepper::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  scope "(:locale)", locale: /en|es|fr/ do
    # resources :entries
  end

  get '/:locale', to: 'entries#index'
  delete '/sessions', to: 'sessions#destroy'
  resources :sessions
  resources :users
  root 'entries#index'
end
