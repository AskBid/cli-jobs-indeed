class ScraperJob
	attr_accessor :job

	def initialize(url)
		@page = Nokogiri::HTML(open(url))
		@job = Job.new
		@job.url = url
		scrape_job_details
	end

	def scrape_job_details
		@job.title = @page.css('h3.jobsearch-JobInfoHeader-title').text
		# @job.description = @page.css('.jobsearch-jobDescriptionText').first
		@job.company = scrape_company_from_job_page
		job_details_hunter
	end

	def scrape_company_from_job_page
		company_div = @page.search('div.jobsearch-DesktopStickyContainer-companyrating').first
		if company_div.children.size > 1 
			#company has a company page
			url = company_div.css('a').first.attribute('href').value
			co = Company.find_or_create(company_div.text)
			if !co.url
				co.url = url
			end
			if !co.rating
				ScraperCo.new(co).company
			else
				co
			end
		else 
			#company has NOT a company page
			Company.find_or_create(company_div.text)
		end
	end															

	def job_details_hunter
		index = 0
		if @page.css('.icl-IconFunctional--location')[0]
			@job.location = @page.css('.jobsearch-JobMetadataHeader-iconLabel')[index].text
			index += 1
		end
		if @page.css('.icl-IconFunctional--jobs')[0]
			@job.contract = @page.css('.jobsearch-JobMetadataHeader-iconLabel')[index].text
			index += 1
		end
		if @page.css('.icl-IconFunctional--salary')[0]
			salary = reformat_salary(@page.css('.jobsearch-JobMetadataHeader-iconLabel')[index].text)
			@job.salary = salary if salary
		end
	end

	def reformat_salary(salary_str)
		str = salary_str.split(' - ').last
		salary = nil
		case str.scan(/[a-zA-Z]/).join()
			when 'ayear'
				salary = salary_to_i(str)
			when 'amonth'
				salary = salary_to_i(str) * 12
			when 'aday'
				salary = salary_to_i(str) * 253
			when 'anhour'
				salary = salary_to_i(str) * 1880
		end
		salary
	end

	def salary_to_i(str)
		str.scan(/[0-9]/).join().to_i
	end
end





