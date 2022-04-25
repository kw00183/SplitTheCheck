Rails.application.routes.draw do
  devise_for :users
  resources :comments, except: [:index, :show, :edit, :update, :destroy]
  resources :favorites, except: [:index, :show, :edit, :update, :destroy]
  resources :vote_histories, except: [:index, :show, :edit, :update, :destroy]
  resources :users, only: [:summary]

  resources :users do
    resource :users, controller: 'users'
  end

  resources :restaurants, except: [:destroy]
  root :to => 'restaurants#index'

  get '/submit_vote', to: "restaurants#submit_vote"
  get '/submit_favorite', to: "restaurants#submit_favorite"
  get '/submit_comment', to: "restaurants#submit_comment"
  get 'restaurants/:id/vote' => "restaurants#vote", :as => :vote, controller: 'restaurants', action: 'id'
  get 'restaurants/:id/favorite' => "restaurants#favorite", :as => :favorite, controller: 'restaurants', action: 'id'
  get 'restaurants/:id/comment' => "restaurants#comment", :as => :comment, controller: 'restaurants', action: 'id'

  get  '/users/:id/summary' => 'users#summary', :as => 'summary', controller: 'users', action: 'id'

  get '/search', to: "restaurants#index"
  get '/:restaurants/:id' => 'restaurants/id', controller: 'restaurants', action: 'id'
  get '*path' => redirect('/')
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
