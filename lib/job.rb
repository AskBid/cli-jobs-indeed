class Job
	extend Concerns::Findable
	attr_accessor :url, :title, :location, :salary, :contract, :description
	attr_reader :company

	@@all = []

	def initialize(url)
		@url = url
	end

	def company=(company)
		@company = company
	end

	def self.all
		@@all
	end
end