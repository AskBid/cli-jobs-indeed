class Company
	extend Concerns::Findable
	attr_accessor :name, :url, :rating, :reviews

	@@all = []

	def initialize(name)
		@name = name
	end

	def self.all
		@@all
	end
end