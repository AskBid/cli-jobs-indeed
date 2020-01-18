require 'bundler'

require 'open-uri'
require 'nokogiri'

require 'pry'

Bundler.require

module Concerns
	module Findable
		def find_by_name(name)
			self.all.find {|obj| obj.name == name}
		end

		def create(name)
			obj = self.new(name)
			self.all << obj
			obj
		end

		def find_or_create(name)
			find_by_name(name) || create(name)
		end
	end
end

require_all './lib'