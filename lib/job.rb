class Job
	attr_accessor :url, :title, :location, :salary, :contract, :description
	attr_reader  :company

	@@all = []

	def initialize
		@@all << self
	end

	def company=(company)
		@company = company
		company.jobs << self
	end

end