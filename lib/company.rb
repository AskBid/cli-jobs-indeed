class Company
	extend Concerns::Findable
	attr_accessor :name, :url, :rating, :reviews

	@@all = []

	def initialize(name)
		@name = name
		@url = "N/A"
		@rating = "N/A"
	end

	#company sometime don't have an url therefore the 'id' is the 'name' instead
	def self.find_by_id(name)
		self.all.find {|obj| obj.name == name}
	end

	def self.all
		@@all
	end

	def jobs
		Job.all.select {|job| job.company.name == self.name}
	end
end