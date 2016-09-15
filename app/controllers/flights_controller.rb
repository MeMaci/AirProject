class FlightsController < ApplicationController
	before_action :authenticate_user!
	def index
		# @flights = current_user.flights
		@flights = Flight.all
	end

	def new
		@flight = Flight.new
	end

	def create

		@flight = current_user.flights.new(flight_params)
		if @flight.save
			redirect_to user_flights_path(current_user)
		else
			render 'new'
		end
		
	end

	private

	def flight_params
		params.require(:flight)
			.permit(:airport, :gate)
	end

end
