class JobsIndeedController

	@@all = []

	def initialize
		puts ""
		puts ""
		puts ""
		puts "---------------------------"
    puts " Welcome to Jobs Indeed!!! "
    puts "---------------------------"
    puts ""
    puts ""

    new_search

		puts ""
    puts "last search found #{@@all.last.jobs.size} jobs"
    puts "you currently have #{@@all.size} searches"

    main_menu
  end

  def input_search
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
    puts "... we are scraping the website for you ... ~ ~ ~ ~"
    puts "... searching for '#{position}' in '#{location}'... ~ ~ ~ ~"
    Scraper.new(position, location).search
  end

  def new_search
  	@@all << input_search
  end

  def merge_search
  	@@all << input_search
  end

  def main_menu
  	puts ""
    puts "chose an action (enter number):"
    puts ""
    puts "1: make another search"
    puts "2: extend existing search"
    puts "3: list jobs of one search"
    puts "4: compare average salaries of each search"
    puts "5: get highest paid job"
    puts "6: quit! (your job?)"
    puts "..."
    action = gets.strip
    case action
    	when '1'
    		new_search 
    	when '2'
    		puts 'we shall see'
    	when '6'
    		puts 'We wish you the best of luck! :)'
    	else
    		puts 'you insert the wrong action/input'
    		puts 'please choose between one of the listed numbers:'
    		main_menu
    end
  end

  def list_searches

  end

  def list_jobs
  	# s1.jobs.each {|job| 
    # 	puts ":::::::::::::::::::::::::"
    # 	puts "#{job.title}"
    # 	puts "location: #{job.location}"
    # 	puts "salary: #{job.salary}"
    # 	puts "#{job.contract}"
    # 	puts "company: #{job.company.name}"
    # }
  end
end