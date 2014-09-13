require 'open-uri'
require 'nokogiri'
require 'geocoder'
require 'csv'
require 'imgkit'


def get_route(year)
	route_places = []

	route_points = []

	doc = Nokogiri::HTML(open("http://en.wikipedia.org/wiki/#{year}_Tour_de_France"))
	stages_table = []
	table = doc.css('table.wikitable').first

		table.css('tr td:nth-child(2)')[1..-1].each do |course|
			place = course.text.split(/[^A-Za-z\u00C0-\u017F\s]/).first
			unless (coords = Geocoder.coordinates("#{place}, France")).nil?
				route_points << coords.reverse
				route_places << place
			end
			sleep(0.25)
		end

	return route_points.uniq, route_places.uniq
end

def loop_routes
	[1974, 1975].each do |year|
		open("/Users/adamssarah/Desktop/tour_years/#{year}.html", "wb") do |file|
			open("http://localhost:1080/route/#{year}") do |uri|
				file.write(uri.read)
			end
		end
	end
end