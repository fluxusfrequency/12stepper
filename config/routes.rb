TwelveStepper::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  scope "(:locale)", locale: /en|es|fr/ do
    resources :users
    resources :sessions
    delete '/sessions', to: 'sessions#destroy'

    namespace :big_book do
      get '/', to: 'chapters#index'
      resources :chapters
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :big_book do
        resources :chapters
      end
    end
  end

  get '/:locale', to: 'entries#index'
  root 'entries#index'
end
