Rails.application.routes.draw do
  resources :restaurants, except: [:destroy]
  root :to => 'restaurants#index'

  get '/search', to: "restaurants#index"
  get '/:restaurants/:id' => 'restaurants/id', controller: 'restaurants', action: 'id'
  get '*path' => redirect('/')
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
