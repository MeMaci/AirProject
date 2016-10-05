class FlightsController < ApplicationController
	before_action :authenticate_user!

	require 'nokogiri'
	require 'open-uri'

	def index
		@flights = current_user.flights.order(id: :desc)

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

		# flash[:notice] = "Flight Deleted"
		# @user = User.find(params[:user_id])
		@flight = current_user.flights.find(params[:id])

		# @flight.destroy
		# redirect_to flights_path(@user)
		


		if @flight.destroy
			flash[:notice] = "Flight Deleted"
			redirect_to flights_path
		end
		
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
	        tsa_checkpoint_get = Net::HTTP.get(URI.parse(tsa_checkpoint_url))

	        if tsa_checkpoint_get === "Bad Request"
	        	@wait_time = 0
	        	@airport_position = {
		        	:wait_time => 0,
		        	:airport_latitude => 0,
		        	:airport_longitude => 0
		        }
			else	        

		        tsa_checkpoint_response = JSON.parse(tsa_checkpoint_get)


		        tsa_airport_url = 'http://apps.tsa.dhs.gov/mytsawebservice/GetAirportCheckpoints.ashx?ap=' + @flight.airport

		        tsa_airport_response = JSON.parse(Net::HTTP.get(URI.parse(tsa_airport_url)))[0]["airport"]

		        @wait_time = getWaitTime(@flight.airport)
		    



		        @airport_position = {
		        	:wait_time => @wait_time,
		        	:airport_latitude => tsa_airport_response['latitude'],
		        	:airport_longitude => tsa_airport_response['longitude']
		        }
		    end

	end

	private

	def getWaitTime(ap)

		doc = Nokogiri::HTML(open('http://apps.tsa.dhs.gov/mytsa/wait_times_detail.aspx?airport='+ ap))
		new_array = []
		doc.css('.time').each do | span_item |
			if span_item.parent.parent.next_element.content.to_s.include?("Today") 
				if span_item.content === "No Wait"
					next
				end

				span_item = span_item.content.to_s.sub('min','')

				span_item.gsub!(/\s+/,"")

				span_item.gsub!(/[+]/,"")
				
				if  span_item.split("-")[1] 
					span_item = span_item.split("-")[1]
				end

				new_array.push(span_item.to_i)
			end
		end

		if new_array.size === 0
			doc.css('.time').each do | span_item |
				if span_item.content === "No Wait"
					next
				end

				span_item = span_item.content.to_s.sub('min','')

				span_item.gsub!(/\s+/,"")

				span_item.gsub!(/[+]/,"")
				
				if  span_item.split("-")[1] 
					span_item = span_item.split("-")[1]
				end

				new_array.push(span_item.to_i)
			end

			if new_array.size === 0
					return 0
			else		
			 		return new_array.inject{ |sum, el| sum + el }.to_f / new_array.size				
			end
		else
				return new_array.inject{ |sum, el| sum + el }.to_f / new_array.size				
		end

		
	end

	def flight_params
		params.require(:flight)
			.permit(:airport, :gate, :destination)
	end

end
