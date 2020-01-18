class Company
	extend Concerns::Findable
	attr_accessor :name, :url, :rating, :reviews

	@@all = []

	def initialize(name)
		@name = name
	end

	#company sometime don't have an url therefore the 'id' is the 'name' instead
	def self.find_by_id(id)
		self.all.find {|obj| obj.name == id}
	end

	def self.all
		@@all
	end
end