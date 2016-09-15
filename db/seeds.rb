# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
clark, tony, rick = User.create!([
		{name: 'Clark Kent', email: 'superman@ironhack.com', password: 'ironhack', password_confirmation: 'ironhack'},
		{name: 'Tony Tail', email: 'tony@ironhack.com', password: 'ironhack', password_confirmation: 'ironhack'},
		{name: 'Rick Roll', email: 'rick@ironhack.com', password: 'ironhack', password_confirmation: 'ironhack'}
	])


clark.flights.create!([{airport:'MIA', gate:'H10'}, {airport:'NY', gate:'G5'}])
tony.flights.create!([{airport:'MIA', gate:'G10'}])