Rails.application.routes.draw do
  resources :vote_histories
  devise_for :users
  resources :restaurants, except: [:destroy]
  root :to => 'restaurants#index'

  get '/restaurant_will_count', to: "restaurants#restaurant_will_count"
  get '/restaurant_wont_count', to: "restaurants#restaurant_wont_count"
  get '/submit_vote', to: "restaurants#submit_vote"
  get 'restaurants/:id/vote' => "restaurants#vote", :as => :vote, controller: 'restaurants', action: 'id'
  get '/search', to: "restaurants#index"
  get '/:restaurants/:id' => 'restaurants/id', controller: 'restaurants', action: 'id'
  get '*path' => redirect('/')
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
