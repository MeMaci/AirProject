class WelcomeController < ApplicationController
	def index
		@time = Time.now.strftime("%A")
		
	end
end
