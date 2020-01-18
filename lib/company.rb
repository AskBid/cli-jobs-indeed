class Company
	attr_accessor :name, :url, :rating, :reviews

	@@all = []

	def initialize(name)
		@name = name
	end

	def self.find_by_name(name)
		@@all.find {|company| company.name == name}
	end

	def self.create(name)
		company = self.new(name)
		@@all << company
		company
	end

	def self.find_or_create(name)
		find_by_name(name) || create(name)
	end
end