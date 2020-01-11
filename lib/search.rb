class Search
	attr_accessor :position, :city

	@@all = []

	def initialize()
		@@all << self
	end

	def self.all
		@@all
	end

end