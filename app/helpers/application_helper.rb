module ApplicationHelper

	def greet

	  	now = Time.now
  		today = Date.today.to_time

		  morning = today.beginning_of_day
		  noon = today.noon
		  evening = today.change( hour: 17 )
		  night = today.change( hour: 20 )
		  tomorrow = today.tomorrow

		  if (morning..noon).cover? now
		    'Good Morning'
		  elsif (noon..evening).cover? now
		    'Good Afternoon'
		  elsif (evening..night).cover? now
		    'Good Evening'
		  elsif (night..tomorrow).cover? now
		    'Good Night'
		  end
	end
end
