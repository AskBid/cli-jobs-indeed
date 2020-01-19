class JobsIndeedController

	def initialize
		String.disable_colorization = false

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
  	index = 1
  	if Search.all.size > 1
	  	list_searches
	  	puts "Select which (index) search you want to extend:".colorize(:yellow)
	  	puts "...".colorize(:light_blue)
	  	index = gets.strip.to_i
	  	if index < 1 && index > Search.all.size
	  		merge_searches
	  	end
	  end
	  index =- 1
	  initial_jobs = Search.all[index].jobs.size
	  Search.all[index].merge(input_search)

	  puts ""
	  print "The extended search added ".colorize(:yellow)
	  puts "#{Search.all[index].jobs.size - initial_jobs} jobs".colorize(:light_red)
	  puts ""
  end

  def main_menu
  	puts ""
    print "chose an action:".colorize(:light_yellow)
    puts " (enter number)".colorize(:light_black)
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
    puts "check company rating".colorize(:yellow)
    print "7: ".colorize(:light_yellow)
    puts "List searches".colorize(:yellow)
    print "8: ".colorize(:light_yellow)
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
    	when '7'
    		list_searches
    		main_menu
    	when '8'
    		puts "!!!         !!!".colorize(:light_blue)
    		puts 'We wish you the best of luck! :)'.colorize(:light_magenta)
    		puts "!!! the end !!!".colorize(:light_blue)
    	else
    		puts 'you insert the wrong action/input'.colorize(:light_magenta)
    		puts 'please choose between one of the listed numbers:'.colorize(:light_magenta)
    		main_menu
    end
  end

  def list_searches
  	puts ""
  	puts "----------------------------------------------------------".colorize(:light_blue)
  	puts "::::::::::::::::::: existing searches ::::::::::::::::::::".colorize(:light_blue)
  	Search.all.each_with_index {|search, i| 
  		puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize(:light_blue)
  		puts "#{i + 1}.".colorize(:light_yellow)
  		print "  title: ".colorize(:light_black)
  		puts "#{search.position}".colorize(:red)
  		print "  in   : ".colorize(:light_black)
  		puts "#{search.city}".colorize(:red)
  		print "  jobs : ".colorize(:light_black)
  		puts "#{search.jobs.size}".colorize(:red)
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