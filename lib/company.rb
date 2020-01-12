class Company
	attr_accessor :name, :url, :rating, :reviews, :jobs

	@@all = []

	def initialize(name)
		@name = name
		@jobs = []
	end

	def self.find_by_name(name)
		@@all.find {|company| company.name == name}
	end

	def self.create(name, url = nil)
		company = self.new(name)
		company.url = url
		@@all << company
		company
	end

	def self.find_or_create(name, url = nil)
		find_by_name(name) || create(name, url)
	end
end