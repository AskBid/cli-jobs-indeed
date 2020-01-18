require 'bundler'

require 'open-uri'
require 'nokogiri'

require 'pry'

Bundler.require

module Concerns
	module Findable
		def find_by_id(id)
			self.all.find {|obj| obj.url == id}
		end

		def create(id)
			obj = self.new(id)
			self.all << obj
			obj
		end

		def find_or_create(id)
			find_by_id(id) || create(id)
		end
	end
end

require_all './lib'