Rails.application.routes.draw do
  
  get 'user_flights/index'

  get 'user_flights/new'

  get 'user_flights/show'

  devise_for :users
	
	get '/' => 'welcome#index'
	
	resources :flights

	resources :users do
		resources :flights, controller: "user_flights"
	end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
