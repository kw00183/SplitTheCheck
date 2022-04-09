Rails.application.routes.draw do
  devise_for :users
  resources :restaurants, except: [:destroy]
  root :to => 'restaurants#index'

  get '/submit_vote', to: "restaurants#submit_vote"
  get 'restaurants/:id/vote' => "restaurants#vote", :as => :vote, controller: 'restaurants', action: 'id'
  get '/search', to: "restaurants#index"
  get '/:restaurants/:id' => 'restaurants/id', controller: 'restaurants', action: 'id'
  get '*path' => redirect('/')
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
