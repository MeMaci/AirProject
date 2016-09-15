Rails.application.routes.draw do
	get '/' => 'welcome#index'
 
	devise_for :users
	
	resources :flights

	resources :users do
		resources :flights
	end
end
