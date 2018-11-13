Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  get 'home/index'
  #post 'study/phonics'
  post 'study/phonics', to: 'study#phonics'
  get 'study/phonics', to: 'study#phonics'
  resources :histories
  resources :phonetic_tests
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
