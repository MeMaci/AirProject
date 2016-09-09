class FlightsController < ApplicationController
	before_action :authenticate_user!
	def index
		@flights = current_user.flights
	end

end
