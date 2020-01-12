class ScraperCo
	attr_accessor :company

	def initialize(company)
		@company = company
		@page = Nokogiri::HTML(open(@company.url))
		scrape_co_details
	end

	def scrape_co_details
		@company.rating = @page.css('span.cmp-header-rating-average').text
	end
end