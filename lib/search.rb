class Search
	attr_accessor :position, :city, :jobs

	@@all = []

	def initialize()
		@@all << self
	end

	def self.all
		@@all
	end

end