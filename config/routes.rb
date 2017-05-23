Rails.application.routes.draw do

  root 'rounds#index'

  get '/index' => 'rounds#index'

  resources :rounds

  namespace :admin do
    resources :rounds
    resources :imdbs
    resources :people
  end
  # mount Fae below your admin namespec
  mount Fae::Engine => '/admin'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
