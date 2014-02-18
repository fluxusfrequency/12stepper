TwelveStepper::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  scope "(:locale)", locale: /en|es|fr/ do
    resources :users
    resources :sessions
    delete '/sessions', to: 'sessions#destroy'

    namespace :big_book do
      resources :chapters
    end
  end

  get '/:locale', to: 'entries#index'
  root 'entries#index'
end
