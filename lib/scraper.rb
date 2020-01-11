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
			# search.add_job(job)
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
		job = Job.new
		page = Nokogiri::HTML( open(url) )
		job.title = page.css('h3.jobsearch-JobInfoHeader-title').text
		job.description = page.css('.jobsearch-jobDescriptionText').first
		job.company = scrape_company_from_job_page(page)
		job_details_hunter(job, page)
	end

	def scrape_company_from_job_page(page)
		company_div = page.search('div.jobsearch-DesktopStickyContainer-companyrating').first
		if company_div.children.size > 1
			url = company_div.css('a').first.attribute('href').value
			Company.find_or_create(company_div.text, url)
		else
			Company.find_or_create(company_div.text)
		end
	end

	def job_details_hunter(job, page)
		index = 0
		if page.css('.icl-IconFunctional--location')[0]
			job.location = page.css('.jobsearch-JobMetadataHeader-iconLabel')[index].text
			index += 1
		end
		if page.css('.icl-IconFunctional--jobs')[0]
			job.contract = page.css('.jobsearch-JobMetadataHeader-iconLabel')[index].text
			index += 1
		end
		if page.css('.icl-IconFunctional--salary')[0]
			job.salary = page.css('.jobsearch-JobMetadataHeader-iconLabel')[index].text
		end
	end
			
end 