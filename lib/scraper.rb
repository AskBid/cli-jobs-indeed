class Scraper
	attr_accessor :search

	BASE = 'https://www.indeed.co.uk'

	def initialize(position, city)
		position = dash_words(position)
		city = dash_words(city)
		url = "#{BASE}/#{position}-jobs-in-#{city}"
		@page = Nokogiri::HTML(open(url))
		
		@search = Search.new(url)
		@search.position = position
		@search.city = city

		scrape_jobs_urls.each {|job_url| 
			job = ScraperJob.new(job_url).job
			if job && job.salary
				@search.add_job(job)
			end
		}
	end

	def dash_words(words)
		words.split(' ').map {|w| w.capitalize}.join('-')
	end

	def scrape_jobs_urls
		divs = @page.css('div.jobsearch-SerpJobCard div.title a')
		divs.map {|div| 
			href = div.attribute('href').value
			"#{BASE}#{href}"
		}
	end
			
end 