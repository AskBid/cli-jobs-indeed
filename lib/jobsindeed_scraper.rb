class Scraper
	attr_accessor :search

	BASE = 'https://www.indeed.co.uk'

	def initialize( position = 'Full Stack Developer', city = 'London' )
		position = dash_words(position)
		@page = Nokogiri::HTML( open("#{BASE}/#{position}-jobs-in-#{city}") )
		
		search = Search.new
		search.position = position
		search.city = city

		scrape_jobs_urls.each {|job_url| 
			job = scrape_job_details(job_url)
			search.add_job(job)
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

	def scrape_job_details(url)
		job = Job.new(url)
	end


end 