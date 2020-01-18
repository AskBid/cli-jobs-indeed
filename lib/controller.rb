class JobsIndeedController
	def initialize
    puts "Welcome to Jobs Indeed!!!"

    puts "Enter the job title/position you would like to look for:"
    puts "(i.e. Full Stack Developer, Architect, 3D Designer, ...)"
    position = gets.strip
    puts "Enter the location you are looking the job for:"
    puts "(i.e. London, Bristol, United Kingdom, ...)"
    location = gets.strip

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