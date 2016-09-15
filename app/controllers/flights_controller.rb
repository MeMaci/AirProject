class FlightsController < ApplicationController
	before_action :authenticate_user!
	def index
		@flights = current_user.flights
		# @flights = Flight.all
	end

	def new
		@flight = Flight.new
	end

	def create

		@flight = current_user.flights.new(flight_params)
		if @flight.save
			current_user.flights.push(@flight)
			redirect_to flights_path(current_user)
		else
			render 'new'
		end

		
	end

	def show
		@flight = Flight.find_by_id(params[:id])
        @data = @flight
        url = 'http://apps.tsa.dhs.gov/mytsawebservice/GetAirportCheckpoints.ashx?output=json&ap=' + @flight.airport
        @data = JSON.parse(Net::HTTP.get(URI.parse(url)))[0]
        # p@data
        data =  JSON.parse(Net::HTTP.get(URI.parse(url)))[0]
        # airport =  data[:airport]
        # p airport
		
	end

	private

	def flight_params
		params.require(:flight)
			.permit(:airport, :gate)
	end

end
