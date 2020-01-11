class Scraper
	attr_accessor :page, :search

	BASE = 'https://www.indeed.co.uk'

	def initialize( position = 'Full Stack Developer', city = 'London' )
		position = dash_word(position)
		@page = Nokogiri::HTML( open("#{BASE}/#{position}-jobs-in-#{city}") )
		
		@search = Search.new
		@search.position = position
		@search.city = city

		openings_url

		binding.pry
	end

	def dash_word(word)
		word.split(' ').map {|w| w.capitalize}.join('-')
	end

	def openings_url
		divs = @page.css('div.jobsearch-SerpJobCard div.title a')
		divs.map {|div| 
			href = div.attribute('href').value
			"#{BASE}#{href}"
		}
	end

end 