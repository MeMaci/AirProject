Rails.application.routes.draw do
	get '/' => 'welcome#index'
	# get '/' => 'users/#{user.id}/flights'
	devise_for :users
	
	resources :flights

	resources :users do
		resources :flights
	end
end
