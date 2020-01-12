class JobsIndeedController
	def initialize
    puts "Welcome to Jobs Indeed!!!"

    s1 = Scraper.new().search
    binding.pry
  end
end