class Job
	attr_accessor :url, :title, :location, :salary, :contract, :company, :description

	@@all = []

	def initialize
		@@all << self
	end
	
end