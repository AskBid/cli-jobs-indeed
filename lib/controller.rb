class JobsIndeedController
	def initialize
		puts ""
		puts ""
		puts ""
		puts "-------------------------"
    puts "Welcome to Jobs Indeed!!!"
    puts "-------------------------"
    puts ""
    puts ""

    puts "Enter the job title/position you would like to look for:"
    puts "(i.e. Full Stack Developer, Architect, 3D Designer, waiter...)"
    puts "(if empty defaults to 'Full Stack Developer')"
    puts ""
    position = gets.strip
    position == '' ? position = 'Full Stack Developer' : nil
    puts "..."
    puts "Enter the location you are looking the job for:"
    puts "(i.e. London, Bristol, United Kingdom, uk, ...)"
    puts "(if empty defaults to 'UK')"
    puts ""
    location = gets.strip
    location == '' ? location = 'United Kingdom' : nil
    puts "..."
    puts "... we are scraping the website for you .. ~ ~ ~ ~"

    s1 = Scraper.new(position, location).search

    s1.jobs.each {|job| 
    	puts ":::::::::::::::::::::::::"
    	puts "#{job.title}"
    	puts "location: #{job.location}"
    	puts "salary: #{job.salary}"
    	puts "#{job.contract}"
    	puts "company: #{job.company.name}"
    }
    # binding.pry
  end
end