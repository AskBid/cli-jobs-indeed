class Search
	extend Concerns::Findable
	attr_accessor :position, :city, :url

	@@all = []

	def initialize(url)
		@url = url
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

  def merge(search2merge)
  	search2merge.jobs.each {|job2merge| self.add_job(job2merge)}
  	self.position += " + #{search2merge.position}" if search2merge.position != self.position
  	self.city += " + #{search2merge.city}" if search2merge.city != self.city
  end

  def average
  	total = 0 
  	jobs.each {|job| total += job.salary }
  	total / jobs.size
  end
	
  class InvalidType < StandardError; end
end