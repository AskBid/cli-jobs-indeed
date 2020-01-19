class JobsIndeedController

	def initialize
		String.disable_colorization = false
		puts String.color_samples 

		puts ""
		puts ""
		puts ""
		puts "------------------------------------------------------------".colorize(:light_blue)
    puts "                Welcome to Jobs Indeed!!! ".colorize(:light_blue)
    puts "------------------------------------------------------------".colorize(:light_blue)
    puts ""
    puts ""

    new_search
    list_searches

		# puts ""
  #   puts "last search found #{.last.jobs.size} jobs"
  #   puts "you currently have #{@@all.size} searches"

    main_menu
    binding.pry
  end

  def input_search
  	puts "Enter the job title/position you would like to look for:".colorize(:light_yellow)
    puts "(i.e. Full Stack Developer, Architect, 3D Designer, waiter...)".colorize(:light_black)
    puts "(if empty defaults to 'Full Stack Developer')".colorize(:light_black)
    puts "...".colorize(:light_blue)
    position = gets.strip
    position == '' ? position = 'Full Stack Developer' : nil
    puts ""

    puts "Enter the location you are looking the job for:".colorize(:light_yellow)
    puts "(i.e. London, Bristol, United Kingdom, uk, ...)".colorize(:light_black)
    puts "(if empty defaults to 'UK')".colorize(:light_black)
    puts "...".colorize(:light_blue)
    location = gets.strip
    location == '' ? location = 'United Kingdom' : nil
    puts ""

    puts "... we are scraping the website for you ... ~ ~ ~ ~".colorize(:yellow)
    print "... searching for ".colorize(:yellow)
    print "'#{position}' ".colorize(:red)
    print "in ".colorize(:yellow)
    print "'#{location}'".colorize(:red)
    puts "... ~ ~ ~ ~".colorize(:yellow)

    Scraper.new(position, location).search
  end

  def new_search
  	Search.update_or_create(input_search)
  end

  def merge_searches
  	list_searches
  end

  def main_menu
  	puts ""
    puts "chose an action (enter number):".colorize(:light_yellow)
    puts ""
    print "1: ".colorize(:light_yellow)
    puts "make another search".colorize(:yellow)
    print "2: ".colorize(:light_yellow)
    puts "extend existing search".colorize(:yellow)
    print "3: ".colorize(:light_yellow)
    puts "list jobs of one search".colorize(:yellow)
    print "4: ".colorize(:light_yellow)
    puts "compare average salaries of each search".colorize(:yellow)
    print "5: ".colorize(:light_yellow)
    puts "get highest paid job".colorize(:yellow)
    print "6: ".colorize(:light_yellow)
    puts "quit! (your job?)".colorize(:yellow)
    puts "...".colorize(:light_blue)
    action = gets.strip
    case action
    	when '1'
    		new_search
    		main_menu
    	when '2'
    		merge_searches
    		main_menu
    	when '6'
    		puts 'We wish you the best of luck! :)'.colorize(:light_magenta)
    	else
    		puts 'you insert the wrong action/input'.colorize(:light_magenta)
    		puts 'please choose between one of the listed numbers:'.colorize(:light_magenta)
    		main_menu
    end
  end

  def list_searches
  	puts ""
  	     "------------------------------------------------------------".colorize(:light_blue)
  	puts "::::::::::::::::::: existing searches ::::::::::::::::::::::".colorize(:light_blue)
  	Search.all.each_with_index {|search, i| 
  		puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize(:light_blue)
  		puts "#{i + 1}.".colorize(:light_yellow)
  		print "title: ".colorize(:light_black)
  		puts "#{search.position}".colorize(:red)
  		print "in   : ".colorize(:light_black)
  		puts "#{search.city}".colorize(:red)
  	}
  	puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize(:light_blue)
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