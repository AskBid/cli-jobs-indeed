require 'bundler'

require 'open-uri'
require 'nokogiri'

require 'pry'

require_relative '../lib/controller.rb'
require_relative '../lib/scraper.rb'
require_relative '../lib/job.rb'
require_relative '../lib/search.rb'
require_relative '../lib/company.rb'

Bundler.require

# require_all './lib'