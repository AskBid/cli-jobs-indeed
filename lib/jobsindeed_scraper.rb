class Scraper
	attr_accessor :page, :search

	def initialize( position = 'Full Stack Developer', city = 'London' )
		position = dash_word(position)
		@page = Nokogiri::HTML( open("https://www.indeed.co.uk/#{position}-jobs-in-#{city}") )
		@search = Search.new
		@search.position = position
		@search.city = city
	end

	def dash_word(word)
		word.split(' ').map {|w| w.capitalize}.join('-')
	end

end 