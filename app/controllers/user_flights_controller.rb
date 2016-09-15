class UserFlightsController < ApplicationController
  def index
  	 @user = User.find(params[:user_id])
  	 @flights = @user.flights.all

  	 # @flights = current_user.flights

  end

  def new
  	# @user = User.find_by(params[:user_id])
  	# @flight = Flight.find_by(params[:flight_id])
  	# @users_flights = @user.flights.new
	
  end
  def create
      @user = User.find(params[:user_id])
      @flight = Flight.find(params[:flight_id])
        if @user.flights.push(@flight)
          redirect_to user_flights_path(current_user)
        else
          render 'new'
        end

  end
  def show
  end
end
