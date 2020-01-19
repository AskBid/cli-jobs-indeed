class JobsIndeedController
	def initialize
		String.disable_colorization = false

		puts ""
		puts ""
		puts ""
		puts "------------------------------------------------------------".colorize(:light_blue)
    puts "                Welcome to Jobs Indeed CLI!!! ".colorize(:light_blue)
    puts "------------------------------------------------------------".colorize(:light_blue)
    puts ""
    puts ""

    new_search
    list_searches

    main_menu
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

  	puts ""
	  print "Last search found ".colorize(:yellow)
	  puts "#{Search.all.last.jobs.size} jobs".colorize(:light_red)
	  puts ""
  end

  def merge_searches
  	index = 1
  	if Search.all.size > 1
	  	list_searches
	  	puts "Select which (index) search you want to extend:".colorize(:yellow)
	  	puts "...".colorize(:light_blue)
	  	index = gets.strip.to_i
	  	if index < 1 && index > Search.all.size
	  		wrong_input_msg
	  		merge_searches
	  	end
	  end
	  index -= 1
	  initial_jobs = Search.all[index].jobs.size
	  Search.all[index].merge(input_search)

	  puts ""
	  print "The extended search added ".colorize(:yellow)
	  puts "#{Search.all[index].jobs.size - initial_jobs} jobs".colorize(:light_red)
	  puts ""
  end

  def main_menu
  	puts ""
    print "Choose an action:".colorize(:light_yellow)
    puts " (enter number)".colorize(:light_black)
    puts ""

    print "1: ".colorize(:light_yellow)
    puts "make another search".colorize(:yellow)

    print "2: ".colorize(:light_yellow)
    puts "extend existing search".colorize(:yellow)

    print "3: ".colorize(:light_yellow)
    puts "list jobs for an existing Search".colorize(:yellow)

    print "4: ".colorize(:light_yellow)
    puts "compare average salaries for each search".colorize(:yellow)

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
    		list_searches
    		main_menu
    	when '2'
    		merge_searches
    		main_menu
    	when '3'
    		list_jobs
    		main_menu
    	when '4'
    		average_salaries
    		main_menu
    	when '5'
    		highest_salary
    		main_menu
    	when '6'
    		company_rating
    		main_menu
    	when '7'
    		list_searches
    		main_menu
    	when '8'
    		puts "--------------------------------------".colorize(:light_blue)
    		puts "!!!                                !!!".colorize(:light_blue)
    		puts '   We wish you the best of luck! :)'.colorize(:light_magenta)
    		puts "!!!            the end             !!!".colorize(:light_blue)
    		puts "--------------------------------------".colorize(:light_blue)
    	else
    		wrong_input_msg
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
  	search_index = 1

  	if Search.all.size > 1
	  	list_searches
	  	puts ""
	    print "Choose a Search to show its Jobs:".colorize(:light_yellow)
	    puts " (enter number)".colorize(:light_black)
	    puts "...".colorize(:light_blue)
	    search_index = gets.strip.to_i
	  	if search_index < 1 && search_index > Search.all.size
	  		wrong_input_msg
	  		list_jobs
	  	end
	  end

  	search_index -= 1

  	search = Search.all[search_index]

  	puts "----------------------------------------------------------".colorize(:light_blue)
  	puts "#{search.position}".colorize(:red)
  	puts ":::::::::::::::::::::::: JOBS in :::::::::::::::::::::::::".colorize(:light_blue)
  	puts "#{search.city}".colorize(:red)
  	puts "----------------------------------------------------------".colorize(:light_blue)
  	puts ""

  	search.jobs.each_with_index { |job, i|
  		puts "#{i + 1}.".colorize(:light_yellow)
  		print "  title  : ".colorize(:light_black)
  		puts "#{job.title}".colorize(:light_red)
  		print "  in     : ".colorize(:light_black)
  		puts "#{job.location}".colorize(:red)
  		print "  company: ".colorize(:light_black)
  		puts "#{job.company.name}".colorize(:light_red)
  		print "  terms  : ".colorize(:light_black)
  		puts "#{job.contract ? job.contract : "N/A"}".colorize(:red)
  		print "  salary : ".colorize(:light_black)
  		puts "#{display_currency(job.salary)}".colorize(:light_red)
  		puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize(:light_blue)
    }
		puts ""
		
		condition = true
  	while condition
  		print "Choose a Job to show its Description:".colorize(:light_yellow)
	    puts " (enter number or anything else to show main menu)".colorize(:light_black)
	    puts "...".colorize(:light_blue)

  		job_index = gets.strip.to_i
  		condition = job_index > 0 && job_index <= search.jobs.size
  		i = job_index - 1
  		show_job_description(search.jobs[i]) if condition
  	end
  end

  def show_job_description(job)
  	puts "here is the description:".colorize(:light_yellow)
  	texts = job.description.css('ul' || 'li' ||  'div' || 'p').map(&:text)
  	puts "...".colorize(:blue)
  	puts texts[0].colorize(:blue)
  	puts "...".colorize(:blue)
  end

  def average_salaries
  	puts ""
  	puts "----------------------------------------------------------".colorize(:light_blue)
  	puts "::::::::::::::: average salary per search ::::::::::::::::".colorize(:light_blue)
  	Search.all.each_with_index {|search, i| 
  		puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize(:light_blue)
  		puts "#{i + 1}.".colorize(:light_yellow)
  		print "  title: ".colorize(:light_black)
  		puts "#{search.position}".colorize(:red)
  		print "  in   : ".colorize(:light_black)
  		puts "#{search.city}".colorize(:red)
  		print "  jobs : ".colorize(:light_black)
  		puts "#{search.jobs.size}".colorize(:red)
  		print "  AVERAGE SALARY: ".colorize(:light_black)
  		puts "#{display_currency(search.average)}".colorize(:light_cyan)
  	}
  	puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize(:light_blue)
  end

  def highest_salary
  	job = Job.all.select{|job| job.salary}.max{|x, y| x.salary <=> y.salary}
  	puts "----------------------------------------------------------".colorize(:light_blue)
  	puts "::::::::::::::::::: Highest Paid Job :::::::::::::::::::::".colorize(:light_blue)
  	puts "----------------------------------------------------------".colorize(:light_blue)
  	print "  title  : ".colorize(:light_black)
		puts "#{job.title}".colorize(:light_red)
		print "  in     : ".colorize(:light_black)
		puts "#{job.location}".colorize(:red)
		print "  company: ".colorize(:light_black)
		puts "#{job.company.name}".colorize(:light_red)
		print "  terms  : ".colorize(:light_black)
		puts "#{job.contract ? job.contract : "N/A"}".colorize(:red)
		print "  salary : ".colorize(:light_black)
		puts "#{display_currency(job.salary)}".colorize(:light_cyan)
		puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize(:light_blue)
  end

  def company_rating
  	print "type a Company name:".colorize(:light_yellow)
    puts " (enter the exact company name or anything else to go back to main menu)".colorize(:light_black)
    puts "...".colorize(:light_blue)
    name_input = gets.strip
    company = Company.find_by_id(name_input)
    if company
    	visualise_company(company)
    else
    	puts "No Company was found with #{name_input} as name"
    end
  end

  def visualise_company(company)
  	puts "----------------------------------------------------------".colorize(:light_blue)
  	puts "::::::::::::::::::: Company Summary ::::::::::::::::::::::".colorize(:light_blue)
  	puts "----------------------------------------------------------".colorize(:light_blue)
  	print "  name  : ".colorize(:light_black)
		puts "#{company.name}".colorize(:light_red)
		print "  rating: ".colorize(:light_black)
		puts "#{company.rating}".colorize(:light_cyan)
		puts "  for more details visit company URL: ".colorize(:light_black)
		puts "#{company.url}".colorize(:light_black)
		puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize(:light_blue)
  end

  def display_currency(number)
  	FriendlyNumbers.number_to_currency(number, unit: "£")
  end

  def wrong_input_msg
  	puts "X X X X X X X X X".colorize(:light_blue)
		puts 'you insert the wrong action/input'.colorize(:light_magenta)
		puts "X X X X X X X X X".colorize(:light_blue)
	end
end