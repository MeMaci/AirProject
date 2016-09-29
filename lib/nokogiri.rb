	require 'nokogiri'
	require 'open-uri'

class CheckPointWaitTime

	def initialize(args)
		doc = Nokogiri::HTML(open('http://apps.tsa.dhs.gov/mytsa/wait_times_detail.aspx?airport=MIA'))

			doc.css('.time').each do | span_item | 
				@wait_time = (span_item.content).split.first.split("-")
				p Range.new(@wait_time[0].to_i, @wait_time[1].to_i)
			end
	end
		
end