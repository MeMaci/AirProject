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
			redirect_to flights_path(current_user), flash: {notice: "Successfully created"}
		else
			render 'new'
		end

	end

	def destroy
		flash[:sucess] = "Flight Deleted"

		@flight = current_user.flights.find(params[:id])

		@flight.destroy
		redirect_to flights_path(current_user)
		
	end

	def update
		@user = User.find(params[:user_id])
		@flight = @user.flight.find(:id)

		if @flight.update(flight_params)
			redirect_to flights_path(current_user)
		else
			render 'edit'
		end
		
	end

	def show
		@flight = Flight.find_by_id(params[:id])
        @data = @flight
        p request.location
        tsa_checkpoint_url = 'http://apps.tsa.dhs.gov/MyTSAWebService/GetWaitTimes.ashx?&output=json&ap=' + @flight.airport
        tsa_checkpoint_response = JSON.parse(Net::HTTP.get(URI.parse(tsa_checkpoint_url)))
       

        tsa_airport_url = 'http://apps.tsa.dhs.gov/mytsawebservice/GetAirportCheckpoints.ashx?ap=' + @flight.airport
        tsa_airport_response = JSON.parse(Net::HTTP.get(URI.parse(tsa_airport_url)))[0]["airport"]

        @wait_time = tsa_checkpoint_response['WaitTimes'][0]['WaitTimeIndex']	
        @airport_position = {
        	:airport_latitude => tsa_airport_response['latitude'],
        	:airport_longitude => tsa_airport_response['longitude']
        }
	end

	private

	def flight_params
		params.require(:flight)
			.permit(:airport, :gate)
	end

end
