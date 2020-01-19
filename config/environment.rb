require 'bundler'

require 'open-uri'
require 'nokogiri'

require 'colorize'

require 'pry'

Bundler.require

module Concerns
	module Findable
		def find_by_id(id)
			self.all.find {|obj| obj.url == id}
		end

		def create(id)
			obj = self.new(id)
			save(obj)
			obj
		end

		def find_or_create(id)
			find_by_id(id) || create(id)
		end

		def update_or_create(obj)
			existing = find_by_id(obj.url)
			if existing
				existing = obj
			else
				save(obj)
			end
		end

		def save(obj)
			self.all << obj
		end
	end
end

require_all './lib'