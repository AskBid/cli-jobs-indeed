class Job
	attr_accessor :url

	@@all = []

	def initialize(url)
		@url = url
		@@all << self
	end
end