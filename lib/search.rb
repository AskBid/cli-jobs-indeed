class Search
	attr_accessor :position, :city

	@@all = []

	def initialize()
		@@all << self
		@jobs = []
	end

	def self.all
		@@all
	end

	def jobs
	    @jobs.dup.freeze
	end

	def add_job(job)
    if !job.is_a?(Job)
      raise InvalidType, "must be a Job object"
    else
      @jobs << job
    end
  end
	
  class InvalidType < StandardError; end
end