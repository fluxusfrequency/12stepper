TwelveStepper::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  scope "(:locale)", locale: /en|es|fr/ do
  end

  # get '/:locale' => 'dashboard#index'
  # root 'entries#index'
end
